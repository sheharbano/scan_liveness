#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/analysis/nw_aliveness/highLevel/"

in_file_tcp=$folder_prefix"nw_alive_tcp.set"
in_file_udp=$folder_prefix"nw_alive_udp.set"
in_file_icmp=$folder_prefix"nw_alive_icmp.set"

out_file=$folder_prefix"UNION.set"

rwsettool --union $in_file_tcp $in_file_udp $in_file_icmp --output-path $out_file

