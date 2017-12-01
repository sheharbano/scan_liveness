folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"

in_file=$folder_prefix"ssh/proc/flat/ssh.flat"

out_file=$folder_prefix"ssh/out_tcp/out_srcIP_ssh_success.set"
log_file=$folder_prefix"ssh/out_tcp/log_out_srcIP_sshSuccess_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '$1=="ok" && $4~/^[0-9]/{print $4}' $in_file | rwsetbuild stdin $out_file

echo 'Finished at: '`date` >>$log_file
