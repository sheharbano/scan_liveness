folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"

in_file=$folder_prefix"telnet/proc/flat/telnet.flat"

out_file=$folder_prefix"telnet/out_tcp/out_srcIP_telnet_success.set"
log_file=$folder_prefix"telnet/out_tcp/log_out_srcIP_telnetSuccess_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '$1=="ok" && $3~/^[0-9]/{print $3}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
