#scan_folder="07-09-2017"
folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"dns/proc/flat/dns.flat"

out_file=$folder_prefix"dns/out_udp/out_srcIP_dns_success.set"
log_file=$folder_prefix"dns/out_udp/log_out_srcIP_dnsSuccess_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '$1=="ok" && $3=="dns"{print $5}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
