#source "config_scan_folder.sh"
folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"ssh/out_tcp/out.log"
in_file_tcpSynack=$folder_prefix"ssh/out_tcp/out_srcIP_synack.set"
tmp=$folder_prefix"tmp.set"

out_file=$folder_prefix"ssh/out_tcp/out_srcIP_rst.set"
log_file=$folder_prefix"ssh/out_tcp/log_out_srcIP_rst_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"," '$0!~/^class/&&$1=="rst"{print $2}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
