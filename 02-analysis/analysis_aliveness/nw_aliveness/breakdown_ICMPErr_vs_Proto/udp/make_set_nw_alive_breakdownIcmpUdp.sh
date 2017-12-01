#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file_dns_udp=$folder_prefix"dns/out_udp/diff_sets/out_srcIP_dns_success.set"
in_file_ntp_udp=$folder_prefix"ntp/out_udp/diff_sets/out_srcIP_ntp_success.set"

out_folder=$folder_prefix"analysis/nw_aliveness/breakdown_ICMPErr_vs_Proto/breakdown_icmpErr_udp/"
mkdir -p $out_folder
out_file_udp=$out_folder"nw_alive_udp.set"

rwsettool --union $in_file_dns_udp $in_file_ntp_udp --output-path $out_file_udp

# ====== ICMP ======

in_file_dns_icmp=$folder_prefix"dns/out_udp/diff_sets/out_srcip_icmp.set"
in_file_ssh_icmp=$folder_prefix"ntp/out_udp/diff_sets/out_srcip_icmp.set"

out_file_icmp=$out_folder"nw_alive_icmp.set"

rwsettool --union $in_file_dns_icmp $in_file_ntp_icmp --output-path $out_file_icmp

# ====== UNIQUE =======

out_file_udp_unique=$out_folder"nw_alive_udp_unique.set"
out_file_icmp_unique=$out_folder"nw_alive_icmp_unique.set"
out_file_both=$out_folder"nw_alive_bothIcmpUdp.set"

rwsettool --difference $out_file_udp $out_file_icmp --output-path $out_file_udp_unique

rwsettool --difference $out_file_icmp $out_file_udp --output-path $out_file_icmp_unique

rwsettool --intersect $out_file_udp $out_file_icmp --output-path $out_file_both

