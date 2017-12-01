# FIXME: set scan folder in config_scan_folder.sh
source "config_scan_folder.sh"
export scan_folder

>err.log

sh make_set_dns.sh 2>>err.log
sh make_set_udp_icmpInnerDaddr.sh 2>>err.log
sh make_set_dns_success.sh 2>>err.log  
sh make_set_udp_icmpSrcIP.sh 2>>err.log
