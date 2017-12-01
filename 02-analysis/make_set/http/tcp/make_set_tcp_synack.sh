scan_folder="21-09-2017/tcp-18517"

folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"http/out_tcp/out.log"
out_file=$folder_prefix"http/out_tcp/out_srcIP_synack.set"
log_file=$folder_prefix"http/out_tcp/log_out_srcIP_synack_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"," '$0!~/^class/&&$1=="synack"{print $2}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
