/*
 * ZMap Copyright 2013 Regents of the University of Michigan
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy
 * of the License at http://www.apache.org/licenses/LICENSE-2.0
 */

// probe module for performing TCP SYN scans

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>

#include "../../lib/includes.h"
#include "../fieldset.h"
#include "probe_modules.h"
#include "packet.h"

#define ICMP_SMALLEST_SIZE 5
#define ICMP_TIMXCEED_UNREACH_HEADER_SIZE 8

probe_module_t module_tcp_synscan;
static uint32_t num_ports;

int synscan_global_initialize(struct state_conf *state)
{
	num_ports = state->source_port_last - state->source_port_first + 1;
	return EXIT_SUCCESS;
}

int synscan_init_perthread(void* buf, macaddr_t *src,
		macaddr_t *gw, port_h_t dst_port,
		__attribute__((unused)) void **arg_ptr)
{
	memset(buf, 0, MAX_PACKET_SIZE);
	struct ether_header *eth_header = (struct ether_header *) buf;
	make_eth_header(eth_header, src, gw);
	struct ip *ip_header = (struct ip*)(&eth_header[1]);
	uint16_t len = htons(sizeof(struct ip) + sizeof(struct tcphdr));
	make_ip_header(ip_header, IPPROTO_TCP, len);
	struct tcphdr *tcp_header = (struct tcphdr*)(&ip_header[1]);
	make_tcp_header(tcp_header, dst_port);
	return EXIT_SUCCESS;
}

int synscan_make_packet(void *buf, ipaddr_n_t src_ip, ipaddr_n_t dst_ip,
		uint32_t *validation, int probe_num, __attribute__((unused)) void *arg)
{
	struct ether_header *eth_header = (struct ether_header *)buf;
	struct ip *ip_header = (struct ip*)(&eth_header[1]);
	struct tcphdr *tcp_header = (struct tcphdr*)(&ip_header[1]);
	uint32_t tcp_seq = validation[0];

	ip_header->ip_src.s_addr = src_ip;
	ip_header->ip_dst.s_addr = dst_ip;

	tcp_header->th_sport = htons(get_src_port(num_ports,
				probe_num, validation));
	tcp_header->th_seq = tcp_seq;
	tcp_header->th_sum = 0;
	tcp_header->th_sum = tcp_checksum(sizeof(struct tcphdr),
			ip_header->ip_src.s_addr, ip_header->ip_dst.s_addr, tcp_header);

	ip_header->ip_sum = 0;
	ip_header->ip_sum = zmap_ip_checksum((unsigned short *) ip_header);

	return EXIT_SUCCESS;
}

void synscan_print_packet(FILE *fp, void* packet)
{
	struct ether_header *ethh = (struct ether_header *) packet;
	struct ip *iph = (struct ip *) &ethh[1];
	struct tcphdr *tcph = (struct tcphdr *) &iph[1];
	fprintf(fp, "tcp { source: %u | dest: %u | seq: %u | checksum: %#04X }\n",
			ntohs(tcph->th_sport),
			ntohs(tcph->th_dport),
			ntohl(tcph->th_seq),
			ntohs(tcph->th_sum));
	fprintf_ip_header(fp, iph);
	fprintf_eth_header(fp, ethh);
	fprintf(fp, "------------------------------------------------------\n");
}

int synscan_validate_packet(const struct ip *ip_hdr, uint32_t len,
		__attribute__((unused))uint32_t *src_ip,
		uint32_t *validation)
{
	if (ip_hdr->ip_p == IPPROTO_TCP) {
		if ((4*ip_hdr->ip_hl + sizeof(struct tcphdr)) > len) {
			// buffer not large enough to contain expected tcp header
			return 0;
		}


		struct tcphdr *tcp = (struct tcphdr*)((char *) ip_hdr + 4*ip_hdr->ip_hl);
		uint16_t sport = tcp->th_sport;
		uint16_t dport = tcp->th_dport;
	
		// validate source port
		if (ntohs(sport) != zconf.target_port) {
			return 0;
		}
		// validate destination port
		if (!check_dst_port(ntohs(dport), num_ports, validation)) {
			return 0;
		}
		// validate tcp acknowledgement number
		/*if (htonl(tcp->th_ack) != htonl(validation[0])+1) {
			return 0;
		}
		*/
		// Bano: validate tcp acknowledgement number for syn-ack packets
        	if (!(tcp->th_flags & TH_RST) && (htonl(tcp->th_ack) != htonl(validation[0])+1)) {
            		return 0;
        	}
	}
	// Bano: Assuming that pcap_filter for this module will capture only ICMPICMP_TIMXCEED, ICMP_UNREACH, ICMP_SOURCEQUENCH, ICMP_REDIRECT 
	else if (ip_hdr->ip_p == IPPROTO_ICMP) {

		if (((uint32_t) 4 * ip_hdr->ip_hl + ICMP_SMALLEST_SIZE) > len) {
                // buffer not large enough to contain expected icmp header
                	return 0;
        	}

        	struct icmp *icmp = (struct icmp*) ((char *) ip_hdr + 4*ip_hdr->ip_hl);

		// + 1st 8B of original ICMP frame
                if ((4*ip_hdr->ip_hl + ICMP_TIMXCEED_UNREACH_HEADER_SIZE +
                        sizeof(struct ip)) > len) {
                        return 0;
                }

        	struct ip *ip_inner = (struct ip*) ((char *) icmp+8);

        	uint32_t inner_src_ip = ip_inner->ip_src.s_addr;
        	uint32_t inner_dst_ip = ip_inner->ip_dst.s_addr;


        	// This is the packet we sent
        	struct tcphdr *inner_tcp = (struct tcphdr*)((char *) ip_inner + 4*ip_inner->ip_hl);
        	uint16_t inner_sport = inner_tcp->th_sport;
        	uint16_t inner_dport = inner_tcp->th_dport;

		// validate destination port
                if (!check_dst_port(ntohs(inner_dport), num_ports, validation)) {
                        return 0;
                }

		// Bano: I am not using validation of seq number as it
		// uses some icmp_id which has been set by ZMap. However,
		// ICMP error msgs to tcp syn scan are unsolicited, so
		// can't verify them other than checking inner dport

        }
	return 1;
}

void synscan_process_packet(const u_char *packet,
		__attribute__((unused)) uint32_t len, fieldset_t *fs)
{
	struct ip *ip_hdr = (struct ip *)&packet[sizeof(struct ether_header)];
	
	if (ip_hdr->ip_p == IPPROTO_TCP) {
		struct tcphdr *tcp = (struct tcphdr*)((char *)ip_hdr
					+ 4*ip_hdr->ip_hl);

		fs_add_uint64(fs, "sport", (uint64_t) ntohs(tcp->th_sport));
		fs_add_uint64(fs, "dport", (uint64_t) ntohs(tcp->th_dport));

  	      //ICMP specific fields, adding null for TCP
        	fs_add_null(fs, "inner_daddr");
        	fs_add_null(fs, "icmp_type");
        	fs_add_null(fs, "icmp_code");

		fs_add_uint64(fs, "seqnum", (uint64_t) ntohl(tcp->th_seq));
		fs_add_uint64(fs, "acknum", (uint64_t) ntohl(tcp->th_ack));
		fs_add_uint64(fs, "window", (uint64_t) ntohs(tcp->th_win));

		if (tcp->th_flags & TH_RST) { // RST packet
			fs_add_string(fs, "classification", (char*) "rst", 0);
			fs_add_uint64(fs, "success", 0);
		} else { // SYNACK packet
			fs_add_string(fs, "classification", (char*) "synack", 0);
			fs_add_uint64(fs, "success", 1);
		}
	}
	// Bano: Assuming that pcap_filter for this module will capture
	//       ICMP unreach and timxceed
	else if (ip_hdr->ip_p == IPPROTO_ICMP) {
		
		struct icmp *icmp = (struct icmp*) ((char *) ip_hdr + 4*ip_hdr->ip_hl);
		struct ip *ip_inner = (struct ip*) ((char *) icmp+8);
        	struct tcphdr *inner_tcp = (struct tcphdr*)((char *) ip_inner + 4*ip_inner->ip_hl);
        	char *dipstr;

		fs_add_null(fs, "sport");
        	fs_add_null(fs, "dport");
        	// Get inner dest ip
        	//struct in_addr inner_dst_ip = ip_inner->ip_dst;
        	dipstr = make_ip_str(ip_inner->ip_dst.s_addr);
        	fs_add_string(fs, "inner_daddr", dipstr, 1);
        	fs_add_uint64(fs, "icmp_type", icmp->icmp_type);
        	fs_add_uint64(fs, "icmp_code", icmp->icmp_code);
        	//These are TCP specific fields and adding null for icmp
        	fs_add_null(fs, "seqnum");
        	fs_add_null(fs, "acknum");
        	fs_add_null(fs, "window");
	
		switch (icmp->icmp_type) {
                	case ICMP_UNREACH:
                        	fs_add_string(fs, "classification", (char*) "unreach", 0);
                        	fs_add_uint64(fs, "success", 0);
                        	break;
                	case ICMP_TIMXCEED:
                        	fs_add_string(fs, "classification", (char*) "timxceed", 0);
                        	fs_add_uint64(fs, "success", 0);
                        	break;
			case ICMP_REDIRECT:
                                fs_add_string(fs, "classification", (char*) "redirect", 0);
                                fs_add_uint64(fs, "success", 0);
                                break;
			case ICMP_SOURCEQUENCH:
                                fs_add_string(fs, "classification", (char*) "sourcequench", 0);
                                fs_add_uint64(fs, "success", 0);
                                break;

                	default:
                        	fs_add_string(fs, "classification", (char*) "other", 0);
                        	fs_add_uint64(fs, "success", 0);
                        	break;
		}
	}
}

static fielddef_t fields[] = {
	{.name = "sport",  .type = "int", .desc = "TCP source port"},
	{.name = "dport",  .type = "int", .desc = "TCP destination port"},

	//Bano: ICMP specific fields
	// ZMap replaces original saddr of icmp packet with
        // the inner daddr and then have an additional field
        // icmp_responder for real daddr of the icmp packet. 
        // I let saddr and daddr as they are in the packet, 
        // and add the field inner_daddr for the inner daddr
        {.name = "inner_daddr", .type = "string", .desc = "Dest IP of TCP packet within ICMP message"},
	{.name="type", .type="int", .desc="icmp message type"},
        {.name="code", .type="int", .desc="icmp message sub type code"},

	{.name = "seqnum", .type = "int", .desc = "TCP sequence number"},
	{.name = "acknum", .type = "int", .desc = "TCP acknowledgement number"},
	{.name = "window", .type = "int", .desc = "TCP window"},
	{.name = "classification", .type="string", .desc = "packet classification"},
	{.name = "success", .type="int", .desc = "is response considered success"}
};

probe_module_t module_tcp_synscan = {
	.name = "tcp_synscan",
	.packet_length = 54,
	.pcap_filter = "ip host 193.63.58.83 and ( (icmp and (icmp[0]==3 or icmp[0]==4 or icmp[0]==5 or icmp[0]==11)) or (tcp && tcp[13] & 4 != 0 || tcp[13] == 18) )",
	     // .pcap_filter = "ip host 128.232.110.28 and (tcp && tcp[13] == 18)",
	.pcap_snaplen = 96,
	.port_args = 1,
	.global_initialize = &synscan_global_initialize,
	.thread_initialize = &synscan_init_perthread,
	.make_packet = &synscan_make_packet,
	.print_packet = &synscan_print_packet,
	.process_packet = &synscan_process_packet,
	.validate_packet = &synscan_validate_packet,
	.close = NULL,
	.helptext = "Probe module that sends a TCP SYN packet to a specific "
		"port. Possible classifications are: synack and rst. A "
		"SYN-ACK packet is considered a success and a reset packet "
		"is considered a failed response.",

	.fields = fields,
	.numfields = 10};

