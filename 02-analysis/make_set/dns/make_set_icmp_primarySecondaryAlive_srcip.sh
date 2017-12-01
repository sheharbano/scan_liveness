folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"dns/proc/flat/dns.flat"

out_file_primary=$folder_prefix"dns/out_udp/out_srcIP_icmp_primaryAlive.set"
out_file_secondary=$folder_prefix"dns/out_udp/out_srcIP_icmp_secondaryAlive.set"
log_file=$folder_prefix"dns/out_udp/log_out_srcIP_icmpPrimarySecondaryAlive_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '($3=="unreach"||$3=="timxceed"||$3=="redirect"||$3=="sourcequench")&&$5==$11{print $5}' $in_file | rwsetbuild stdin $out_file_primary

awk -F"\t" '($3=="unreach"||$3=="timxceed"||$3=="redirect"||$3=="sourcequench")&&$5!=$11{print $5}' $in_file | rwsetbuild stdin $out_file_secondary

echo 'Finished at: '`date` >>$log_file
