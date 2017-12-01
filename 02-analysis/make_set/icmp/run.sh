# FIXME: set scan folder in config_scan_folder.sh
source "config_scan_folder.sh"
export scan_folder

>err.log

sh make_set_icmp_breakdown.sh 2>>err.log
sh make_set_icmpInnerDaddr.sh 2>>err.log
sh make_set_icmp_primarySecondaryAlive_srcip.sh 2>>err.log

