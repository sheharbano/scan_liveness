folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"tls/out_tcp/out.log"
in_file_tcp_synack=$folder_prefix"tls/out_tcp/out_srcIP_synack.set"
in_file_tcp_rst=$folder_prefix"tls/out_tcp/out_srcIP_rst.set"

out_file=$folder_prefix"tls/out_tcp/out_srcIP_synackRst.set"
log_file=$folder_prefix"tls/out_tcp/log_out_srcIP_synackRst_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

rwsettool --union $in_file_tcp_synack $in_file_tcp_rst --output-path $out_file

echo 'Finished at: '`date` >>$log_file
