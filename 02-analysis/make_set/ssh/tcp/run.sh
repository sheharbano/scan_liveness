# FIXME: set scan folder in config_scan_folder.sh
source "config_scan_folder.sh"
export scan_folder

>err.log

sh make_set_tcp_icmpInnerDaddr.sh 2>>err.log
sh make_set_tcp_icmpSrcIP.sh 2>>err.log 
sh make_set_tcp.sh 2>>err.log
sh make_set_tcp_rst.sh 2>>err.log
sh make_set_tcp_synack.sh 2>>err.log
sh make_set_tcp_synackRst.sh 2>>err.log
