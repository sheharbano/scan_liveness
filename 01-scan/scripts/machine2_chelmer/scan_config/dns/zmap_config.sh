gateway="00:0f:8f:92:34:c5"

# How long to listen for responses after the scan has finished
udp_cooloff="10"

# If scanning IPs in same order across multiple scans, specify a seed value with -e
seed=73

# Where is the blacklist
path_blacklist="/home/bano/bl_tor_limits.conf"

# src IP from which scanning
src_ip="193.63.58.87"

# interface from which scanning
interface="eth3"

# scan rate
scan_rate=105000

# target port
target_port=53

# num of  sender threads
send_threads=1

# output fields (no spaces in the string)
out_fields="classification,saddr,success,app_success,ipid,ttl,icmp_type,icmp_code,icmp_responder,icmp_unreach_str,udp_len,dns_id,dns_aa,dns_rcode,dns_ancount,dns_nscount,dns_arcount,dns_answers,dns_authorities,dns_additionals,dns_parse_err,dns_tc"

# output filter (no spaces in the string, can't leave empty -- if no filter then put dummy)
#out_filter="repeat=1"

# if cpu pinning, then which cores to use for zmap
cores_zmap="0,1"

