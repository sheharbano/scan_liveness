folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"http/out_tcp/out.log"
out_file=$folder_prefix"http/out_tcp/out_srcIP.set"
log_file=$folder_prefix"http/out_tcp/log_out_srcIP_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"," '$0!~/^class/{print $2}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
