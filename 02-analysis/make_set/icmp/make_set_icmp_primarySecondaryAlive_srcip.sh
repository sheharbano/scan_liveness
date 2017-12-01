folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file=$folder_prefix"icmp/out_icmp/out.log"

out_file_primary=$folder_prefix"icmp/out_icmp/out_srcIP_icmp_primaryAlive.set"
out_file_secondary=$folder_prefix"icmp/out_icmp/out_srcIP_icmp_secondaryAlive.set"
log_file=$folder_prefix"icmp/out_icmp/log_out_srcIP_icmpPrimarySecondaryAlive_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"," '$0!~/^class/&&($1=="unreach"||$1=="timxceed"||$1=="redirect"||$1=="sourcequench")&&$2==$10{print $2}' $in_file | rwsetbuild stdin $out_file_primary

awk -F"," '$0!~/^class/&&($1=="unreach"||$1=="timxceed"||$1=="redirect"||$1=="sourcequench")&&$2!=$10{print $2}' $in_file | rwsetbuild stdin $out_file_secondary

echo 'Finished at: '`date` >>$log_file
