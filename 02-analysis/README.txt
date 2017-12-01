===============
Get scan meta (scan_meta)
===============

Use scripts get_meta_*.py in scan_meta/

Manually check losses/soundness etc in <protocol>/proc/meta/ 

===============
Merge per-batch scan responses into one big file (preprocessing/merge_blocks/)
===============

Run the scripts in preprocessing/merge_blocks/

Check: that the log files in out_tcp, out_udp, and/or out_<protocol> say that all batch files have been merged

========
Convert application logs such as http.log from json to awk-parsable format (preprocessing/parse_application/)
========

Run preprocessing/parse_application/get_<proc>_proc.py

========
Generate SiLK sets from log files (chelmer)
========

For tcp/udp logs:
make_set/<protocol>/tcp/run.sh

For application layer logs:
make_set_<proto>_success.sh 

Note: Fix paths and check err.log after the script finishes running


========
Generate IP addresses from the scan blacklist (blacklist/ and diff_sets/)
Optional: Relevant if there are multiple scans that use a growing blacklist
========

- Blacklist kept getting extended for the 3 days of scans, so subtract all those IPs in the final/most recent blacklist from our sets. (If there is only 1 scan to analyse, then this step is unnecessary)

- Say the blacklist corresponding to the most recent scan is bl.conf

cd blacklist
python nw_expand.py bl.conf blacklist.ip

- Now convert blacklist.ip to SiLK set

rwsetbuild blacklist.ip blacklist.set

- Then for each folder with *.set files from which you want to exclude blacklisted IPs, run diff_sets/diff_sets.sh
s
%%%%%%%%%%

========
FIGURE 2a
========

# Network alive IPs for TCP, UDP, and ICMP

analysis_aliveness/nw_aliveness/highLevel/tcp/make_set_TCP_nw_alive.sh
analysis_aliveness/nw_aliveness/highLevel/udp/make_set_UDP_nw_alive.sh
analysis_aliveness/nw_aliveness/highLevel/icmp/make_set_ICMP_nw_alive.sh

# All Network Alive IPs (TCP, UDP, and ICMP)
analysis_aliveness/nw_aliveness/highLevel/UNION.sh

# Network Alive IPs, exclusively per TCP, UDP, and ICMP
analysis_aliveness/nw_aliveness/highLevel/make_set_nw_alive_unique.sh

# Results

cd <scan_folder>/analysis/nw_aliveness/highLevel

rwsetcat --count-ips nw_alive_icmp.set nw_alive_icmp_unique.set nw_alive_tcp.set nw_alive_tcp_unique.set nw_alive_udp.set   nw_alive_udp_unique.set UNION.set | awk -F":" 'BEGIN{print "TYPE\tVALUE\tUNIQUE"; line="";}{val=$2; if(NR==1)line="ICMP\t"val; if(NR==3) line="TCP\t"val; if(NR==5) line="UDP\t"val; if(NR==7) line="UNION\t"val; if(NR%2==0) {print line"\t"val; line="";}}END{print line"\t0";}'


========
FIGURE 2b
========

# /24 block versions of all of the above
analysis_aliveness/nw_aliveness/highLevel/convert_to_block24.sh

# Results

cd <scan_folder>/analysis/nw_aliveness/highLevel/block24

rwsetcat --count-ips nw_alive_icmp.set nw_alive_icmp_unique.set nw_alive_tcp.set nw_alive_tcp_unique.set nw_alive_udp.set   nw_alive_udp_unique.set UNION.set > tmp

cat tmp | awk -F":" 'BEGIN{print "TYPE\tVALUE\tUNIQUE"; line="";}{val=$2; if(NR==1)line="ICMP\t"val; if(NR==3) line="TCP\t"val; if(NR==5) line="UDP\t"val; if(NR==7) line="UNION\t"val; if(NR%2==0) {print line"\t"val; line="";}}END{print line"\t0";}'


========
FIGURE 3a
========

Breakdown of ICMP vs <Proto> where Proto is TCP, UDP, or ICMP (EchoReply)


- tcp

breakdown_ICMPErr_vs_Proto/tcp/make_set_nw_alive_breakdownIcmpTcp.sh

- udp 

breakdown_ICMPErr_vs_Proto/udp/make_set_nw_alive_breakdownIcmpUdp.sh

- icmp

breakdown_ICMPErr_vs_Proto/icmp/make_set_nw_alive_breakdownIcmpEchoreplyErr.sh

# Results

cd <scan_folder>/analysis/nw_aliveness/breakdown_ICMPErr_vs_Proto

rwsetcat --count-ips breakdown_icmpErr_icmpEchoReply/nw_alive_icmp_echoreply_unique.set breakdown_icmpErr_icmpEchoReply/nw_alive_icmp_icmpErr_unique.set breakdown_icmpErr_icmpEchoReply/nw_alive_bothIcmpEchoreplyErr.set breakdown_icmpErr_tcp/nw_alive_tcp_unique.set breakdown_icmpErr_tcp/nw_alive_icmp_unique.set breakdown_icmpErr_tcp/nw_alive_bothIcmpTcp.set breakdown_icmpErr_udp/nw_alive_udp_unique.set breakdown_icmpErr_udp/nw_alive_icmp_unique.set breakdown_icmpErr_udp/nw_alive_bothIcmpUdp.set > tmp

cat tmp | awk -F":" 'BEGIN{print "PROBE\tREPLY\tCOUNT"}{if(NR==1)print "ICMP\treply\t"$2; if(NR==2) print "ICMP\terror\t"$2; if(NR==3) print "ICMP\tboth\t"$2; if(NR==4) print "TCP\ttcp\t"$2; if(NR==5) print "TCP\terror\t"$2; if(NR==6) print "TCP\tboth\t"$2; if(NR==7) print "UDP\tudp\t"$2; if(NR==8) print "UDP\terror\t"$2; if(NR==9) print "UDP\tboth\t"$2; }'


=========
FIGURE 3b
=========

Breakdown of ICMP Errors


breakdown_icmpErr/make_set_nw_alive_breakdown_icmpErr.sh

# results

 cd <scan_protocol>/analysis/nw_aliveness/breakdown_icmpErr

rwsetcat --count-ips icmp_icmpOtherUnreach_unique.set icmp_icmpPortUnreach_unique.set icmp_icmpHostUnreach_unique.set  icmp_icmpOther_unique.set icmp_multipleErr.set tcp_icmpOtherUnreach_unique.set tcp_icmpPortUnreach_unique.set tcp_icmpHostUnreach_unique.set  tcp_icmpOther_unique.set tcp_multipleErr.set udp_icmpOtherUnreach_unique.set udp_icmpPortUnreach_unique.set udp_icmpHostUnreach_unique.set  udp_icmpOther_unique.set udp_multipleErr.set > tmp

cat tmp | awk -F":" 'BEGIN{print "PROTO\tUNREACH_OTHER\tUNREACH_PORT\tUNREACH_HOST\tOTHER\tMULTI"; line_icmp="ICMP";line_tcp="TCP";line_udp="UDP";}{val=$2;if($1~/^icmp/)line_icmp=line_icmp"\t"val; if($1~/^tcp/)line_tcp=line_tcp"\t"val; if($1~/^udp/)line_udp=line_udp"\t"val;}END{print line_icmp; print line_tcp; print line_udp;}'


========
FIGURE 4a
========

sh analysis_aliveness/transport_aliveness/tcp_stack_consistency/make_set_tcp_synackRst_analysis.sh

# results

cd <scan_folder>/analysis/transport_aliveness/tcp_stack_consistency/

rwsetcat --count-ips one/rstOnly.set two/rstOnly.set three/rstOnly.set four/rstOnly.set five/rstOnly.set one/both.set  two/both.set three/both.set four/both.set five/both.set one/synackOnly.set two/synackOnly.set three/synackOnly.set four/synackOnly.set five/synackOnly.set > tmp

cat tmp | awk -F":" 'BEGIN{print "\tSet1\tSet2\tSet3\tSet4\tSet5"; line_rst="RST"; line_both="BOTH";line_synack="SYNACK";}{val=$2; if($1~/rst/)line_rst=line_rst"\t"val; if($1~/both/)line_both=line_both"\t"val; if($1~/synack/)line_synack=line_synack"\t"val;}END{print line_rst; print line_both; print line_synack;}'


========
FIGURE 4b
========

sh analysis_aliveness/transport_aliveness/breakdown_tcpSynackRst/make_set_nw_alive_breakdown_tcp.sh


# results

cd <scan_folder>/analysis/transport_aliveness/breakdown_tcpSynackRst/

rwsetcat --count-ips http_totalSynackRst.set http_synack_unique.set http_rst_unique.set  http_bothSynackRst.set ssh_totalSynackRst.set ssh_synack_unique.set ssh_rst_unique.set  ssh_bothSynackRst.set tls_totalSynackRst.set tls_synack_unique.set tls_rst_unique.set  tls_bothSynackRst.set cwmp_totalSynackRst.set cwmp_synack_unique.set cwmp_rst_unique.set  cwmp_bothSynackRst.set telnet_totalSynackRst.set telnet_synack_unique.set telnet_rst_unique.set  telnet_bothSynackRst.set > tmp


cat tmp | awk -F":" 'BEGIN{print "PROTO\tTOTAL\tSYNACK\tRST\tBOTH"; line_http="HTTP"; line_ssh="SSH"; line_tls="TLS"; line_cwmp="CWMP"; line_telnet="Telnet"}{val=$2;if($1~/^http/)line_http=line_http"\t"val; if($1~/^ssh/)line_ssh=line_ssh"\t"val; if($1~/^tls/)line_tls=line_tls"\t"val; if($1~/^cwmp/)line_cwmp=line_cwmp"\t"val; if($1~/^telnet/)line_telnet=line_telnet"\t"val;}END{print line_http; print line_ssh; print line_tls; print line_cwmp; print line_telnet;}'


=========
FIGURE 5
=========

# generate conditional probabilities of transport-layer/ICMP liveness

- First use python script (after suitably tweaking) to generate bash file. 
 
python gen_set_cond_prob.py > set_cond_prob.sh

- rename INTERSECT.set in the output to 111.set (or however many 1’s)

- Generate sets.count

./get_set_count.sh

========
TARPIT ANALYSIS:
========

sh analysis_aliveness/transport_aliveness/tarpit_analysis/make_set_tarpits.sh
