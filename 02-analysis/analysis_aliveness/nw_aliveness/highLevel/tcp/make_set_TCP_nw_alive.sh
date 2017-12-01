#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file_http=$folder_prefix"http/out_tcp/diff_sets/out_srcIP.set"
in_file_ssh=$folder_prefix"ssh/out_tcp/diff_sets/out_srcIP.set"
in_file_tls=$folder_prefix"tls/out_tcp/diff_sets/out_srcIP.set"
in_file_cwmp=$folder_prefix"cwmp/out_tcp/diff_sets/out_srcIP.set"
in_file_telnet=$folder_prefix"telnet/out_tcp/diff_sets/out_srcIP.set"

#FIXME
out_folder="/home/bano/my_media/nemesis/vertical/07-09-2017/analysis/nw_aliveness/highLevel/"
mkdir -p $out_folder
out_file=$out_folder"nw_alive_tcp.set"

rwsettool --union $in_file_http $in_file_ssh $in_file_tls $in_file_cwmp $in_file_telnet --output-path $out_file

