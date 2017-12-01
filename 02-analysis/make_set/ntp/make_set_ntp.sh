folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"ntp/proc/flat/ntp.flat"

out_file=$folder_prefix"ntp/out_udp/out_srcIP.set"
log_file=$folder_prefix"ntp/out_udp/log_out_srcIP_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '($1=="ok" && $3=="ntp")||($3!="ntp"){print $5}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
