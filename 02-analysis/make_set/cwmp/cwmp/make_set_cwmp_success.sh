folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file=$folder_prefix"cwmp/proc/flat/cwmp.flat"

out_file_alive=$folder_prefix"cwmp/out_tcp/out_srcIP_cwmp_success.set"
out_file_activeOnly=$folder_prefix"cwmp/out_tcp/out_srcIP_cwmp_activeOnly.set"
out_file_activeOrAlive=$folder_prefix"cwmp/out_tcp/out_srcIP_cwmp_activeOrAlive.set"

log_file=$folder_prefix"cwmp/out_tcp/log_out_srcIP_cwmpSuccess_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '$1=="ok" && $2!="active" && $5~/^[0-9]/{print $5}' $in_file | rwsetbuild stdin $out_file_alive

awk -F"\t" '$1=="ok" && $2=="active" && $5~/^[0-9]/{print $5}' $in_file | rwsetbuild stdin $out_file_activeOnly

rwsettool --union $out_file_alive $out_file_activeOnly --output-path $out_file_activeOrAlive

echo 'Finished at: '`date` >>$log_file
