# From all *.set files in the target_folder, diff file_to_diff  
# output files have the same name as the original, except that
# they are output to a separate folder out_folder

#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_folder=$folder_prefix"analysis/nw_aliveness/highLevel/"
out_folder=$folder_prefix"analysis/nw_aliveness/highLevel/block24/"

mkdir -p $out_folder 

in_nw_alive_icmp=$in_folder"nw_alive_icmp.set"
in_nw_alive_icmp_unique=$in_folder"nw_alive_icmp_unique.set"
in_nw_alive_tcp=$in_folder"nw_alive_tcp.set"
in_nw_alive_tcp_unique=$in_folder"nw_alive_tcp_unique.set"
in_nw_alive_udp=$in_folder"nw_alive_udp.set"
in_nw_alive_udp_unique=$in_folder"nw_alive_udp_unique.set"   
in_nw_alive_union=$in_folder"UNION.set"

out_nw_alive_icmp=$out_folder"nw_alive_icmp.set"
out_nw_alive_icmp_unique=$out_folder"nw_alive_icmp_unique.set"
out_nw_alive_tcp=$out_folder"nw_alive_tcp.set"
out_nw_alive_tcp_unique=$out_folder"nw_alive_tcp_unique.set"
out_nw_alive_udp=$out_folder"nw_alive_udp.set"
out_nw_alive_udp_unique=$out_folder"nw_alive_udp_unique.set"
out_nw_alive_union=$out_folder"UNION.set"

rwsettool --mask=24 $in_nw_alive_icmp --output-path $out_nw_alive_icmp

rwsettool --mask=24 $in_nw_alive_tcp --output-path $out_nw_alive_tcp

rwsettool --mask=24 $in_nw_alive_udp --output-path $out_nw_alive_udp

rwsettool --mask=24 $in_nw_alive_union --output-path $out_nw_alive_union


rwsettool --difference $out_nw_alive_icmp $out_nw_alive_tcp $out_nw_alive_udp --output-path $out_nw_alive_icmp_unique

rwsettool --difference $out_nw_alive_tcp $out_nw_alive_icmp $out_nw_alive_udp --output-path $out_nw_alive_tcp_unique

rwsettool --difference $out_nw_alive_udp $out_nw_alive_tcp $out_nw_alive_icmp --output-path $out_nw_alive_udp_unique
