#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/analysis/nw_aliveness/highLevel/"

in_file_tcp=$folder_prefix"nw_alive_tcp.set"
in_file_udp=$folder_prefix"nw_alive_udp.set"
in_file_icmp=$folder_prefix"nw_alive_icmp.set"

out_file_tcp=$folder_prefix"nw_alive_tcp_unique.set"
out_file_udp=$folder_prefix"nw_alive_udp_unique.set"
out_file_icmp=$folder_prefix"nw_alive_icmp_unique.set"

rwsettool --difference $in_file_tcp $in_file_icmp $in_file_udp --output-path $out_file_tcp
rwsettool --difference $in_file_udp $in_file_icmp $in_file_tcp --output-path $out_file_udp
rwsettool --difference $in_file_icmp $in_file_tcp $in_file_udp --output-path $out_file_icmp

