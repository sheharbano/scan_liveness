#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file_icmp_echoreply=$folder_prefix"icmp/out_icmp/diff_sets/out_srcIP_echoreply.set"

out_folder=$folder_prefix"analysis/nw_aliveness/breakdown_ICMPErr_vs_Proto/breakdown_icmpErr_icmpEchoReply/"
mkdir -p $out_folder
out_file_icmp_echoreply=$out_folder"nw_alive_icmp_echoreply.set"

# ===== ICMP Echo Reply =====

cp $in_file_icmp_echoreply $out_file_icmp_echoreply

# ====== ICMP Err ======

in_file_icmp_icmpErr=$folder_prefix"icmp/out_icmp/diff_sets/out_srcIP_icmpErr.set"

out_file_icmp_icmpErr=$out_folder"nw_alive_icmp_icmpErr.set"

cp $in_file_icmp_icmpErr $out_file_icmp_icmpErr

# ====== UNIQUE =======

out_file_icmp_echoreply_unique=$out_folder"nw_alive_icmp_echoreply_unique.set"
out_file_icmp_icmpErr_unique=$out_folder"nw_alive_icmp_icmpErr_unique.set"
out_file_both=$out_folder"nw_alive_bothIcmpEchoreplyErr.set"

rwsettool --difference $out_file_icmp_echoreply $out_file_icmp_icmpErr --output-path $out_file_icmp_echoreply_unique

rwsettool --difference $out_file_icmp_icmpErr $out_file_icmp_echoreply --output-path $out_file_icmp_icmpErr_unique

rwsettool --intersect $out_file_icmp_echoreply $out_file_icmp_icmpErr --output-path $out_file_both

