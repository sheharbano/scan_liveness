#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file_dns=$folder_prefix"dns/out_udp/diff_sets/out_srcIP.set"
in_file_ntp=$folder_prefix"ntp/out_udp/diff_sets/out_srcIP.set"

#FIXME
out_folder="/home/bano/my_media/nemesis/vertical/07-09-2017/analysis/nw_aliveness/highLevel/"
mkdir -p $out_folder
out_file=$out_folder"nw_alive_udp.set"

rwsettool --union $in_file_dns $in_file_ntp --output-path $out_file

