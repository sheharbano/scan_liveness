#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file_http_tcp=$folder_prefix"http/out_tcp/diff_sets/out_srcIP_synackRst.set"
in_file_ssh_tcp=$folder_prefix"ssh/out_tcp/diff_sets/out_srcIP_synackRst.set"
in_file_tls_tcp=$folder_prefix"tls/out_tcp/diff_sets/out_srcIP_synackRst.set"
in_file_cwmp_tcp=$folder_prefix"cwmp/out_tcp/diff_sets/out_srcIP_synackRst.set"
in_file_telnet_tcp=$folder_prefix"telnet/out_tcp/diff_sets/out_srcIP_synackRst.set"

out_folder=$folder_prefix"analysis/nw_aliveness/breakdown_ICMPErr_vs_Proto/breakdown_icmpErr_tcp/"
mkdir -p $out_folder
out_file_tcp=$out_folder"nw_alive_tcp.set"

rwsettool --union $in_file_http_tcp $in_file_ssh_tcp $in_file_tls_tcp $in_file_cwmp_tcp $in_file_telnet_tcp --output-path $out_file_tcp

# ====== ICMP ======

in_file_http_icmp=$folder_prefix"http/out_tcp/diff_sets/out_srcip_icmp.set"
in_file_ssh_icmp=$folder_prefix"ssh/out_tcp/diff_sets/out_srcip_icmp.set"
in_file_tls_icmp=$folder_prefix"tls/out_tcp/diff_sets/out_srcip_icmp.set"
in_file_cwmp_icmp=$folder_prefix"cwmp/out_tcp/diff_sets/out_srcip_icmp.set"
in_file_telnet_icmp=$folder_prefix"telnet/out_tcp/diff_sets/out_srcip_icmp.set"

out_file_icmp=$out_folder"nw_alive_icmp.set"

rwsettool --union $in_file_http_icmp $in_file_ssh_icmp $in_file_tls_icmp $in_file_cwmp_icmp $in_file_telnet_icmp --output-path $out_file_icmp

# ====== UNIQUE =======

out_file_tcp_unique=$out_folder"nw_alive_tcp_unique.set"
out_file_icmp_unique=$out_folder"nw_alive_icmp_unique.set"
out_file_both=$out_folder"nw_alive_bothIcmpTcp.set"

rwsettool --difference $out_file_tcp $out_file_icmp --output-path $out_file_tcp_unique

rwsettool --difference $out_file_icmp $out_file_tcp --output-path $out_file_icmp_unique

rwsettool --intersect $out_file_tcp $out_file_icmp --output-path $out_file_both

