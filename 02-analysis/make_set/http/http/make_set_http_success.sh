folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file=$folder_prefix"http/proc/flat/http.flat"

out_file_alive=$folder_prefix"http/out_tcp/out_srcIP_http_success.set"
out_file_activeOnly=$folder_prefix"http/out_tcp/out_srcIP_http_activeOnly.set"
out_file_activeOralive=$folder_prefix"http/out_tcp/out_srcIP_http_activeOrAlive.set"
log_file=$folder_prefix"http/out_tcp/log_out_srcIP_httpSuccess_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '$1=="ok" && $2=="active" && $7~/^[0-9]/{print $7}' $in_file | rwsetbuild stdin $out_file_activeOnly

awk -F"\t" '$1=="ok" && $2!="active" && $7~/^[0-9]/{print $7}' $in_file | rwsetbuild stdin $out_file_alive

rwsettool --union $out_file_activeOnly $out_file_alive --output-path $out_file_activeOralive 

echo 'Finished at: '`date` >>$log_file
