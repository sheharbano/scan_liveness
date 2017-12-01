#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"
out_folder_prefix=$folder_prefix"analysis/nw_aliveness/breakdown_icmpErr/"

mkdir -p $out_folder_prefix

# ----- HTTP ------

in_folder_prefix=$folder_prefix"http/out_tcp/diff_sets/"

in_http_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_http_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_http_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_http_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_http_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_http_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"


# ----- SSH ------

in_folder_prefix=$folder_prefix"ssh/out_tcp/diff_sets/"

in_ssh_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_ssh_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_ssh_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_ssh_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_ssh_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_ssh_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"

# ----- TLS ------

in_folder_prefix=$folder_prefix"tls/out_tcp/diff_sets/"

in_tls_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_tls_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_tls_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_tls_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_tls_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_tls_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"

# ----- CWMP ------

in_folder_prefix=$folder_prefix"cwmp/out_tcp/diff_sets/"

in_cwmp_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_cwmp_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_cwmp_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_cwmp_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_cwmp_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_cwmp_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"

# ----- Telnet ------

in_folder_prefix=$folder_prefix"telnet/out_tcp/diff_sets/"

in_telnet_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_telnet_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_telnet_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_telnet_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_telnet_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_telnet_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"

# ----- DNS ------

in_folder_prefix=$folder_prefix"dns/out_udp/diff_sets/"

in_dns_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_dns_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_dns_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_dns_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_dns_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_dns_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"

# ----- NTP ------

in_folder_prefix=$folder_prefix"ntp/out_udp/diff_sets/"

in_ntp_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_ntp_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_ntp_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_ntp_ttl=$in_folder_prefix"out_srcip_icmpTimxceed.set"
in_ntp_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_ntp_icmpErr_union=$in_folder_prefix"out_srcip_icmp.set"

# ----- ICMP ------

in_folder_prefix=$folder_prefix"icmp/out_icmp/diff_sets/"

in_icmp_portUnreach=$in_folder_prefix"out_srcip_icmpPortUnreach.set"
in_icmp_hostUnreach=$in_folder_prefix"out_srcip_icmpHostUnreach.set"
in_icmp_otherUnreach=$in_folder_prefix"out_srcip_icmpOtherUnreach.set"
in_icmp_ttl=$in_folder_prefix"out_srcIP_timxceed.set"
in_icmp_other=$in_folder_prefix"out_srcip_icmp_union_SrcquenchRedirectTtl.set"

in_icmp_icmpErr_union=$in_folder_prefix"out_srcIP_icmpErr.set"

# %%%%% TCP %%%%%%%%

out_tcp_icmpPortUnreach=$out_folder_prefix"tcp_icmpPortUnreach.set"
out_tcp_icmpHostUnreach=$out_folder_prefix"tcp_icmpHostUnreach.set"
out_tcp_icmpOtherUnreach=$out_folder_prefix"tcp_icmpOtherUnreach.set"
out_tcp_icmpTTL=$out_folder_prefix"tcp_icmpTTL.set"
out_tcp_icmpOther=$out_folder_prefix"tcp_icmpOther.set"
out_tcp_icmpErrUnion=$out_folder_prefix"tcp_icmpErrUnion.set"

rwsettool --union $in_http_portUnreach $in_ssh_portUnreach $in_tls_portUnreach $in_cwmp_portUnreach $in_telnet_portUnreach --output-path $out_tcp_icmpPortUnreach

rwsettool --union $in_http_hostUnreach $in_ssh_hostUnreach $in_tls_hostUnreach $in_cwmp_hostUnreach $in_telnet_hostUnreach --output-path $out_tcp_icmpHostUnreach

rwsettool --union $in_http_otherUnreach $in_ssh_otherUnreach $in_tls_otherUnreach $in_cwmp_otherUnreach $in_telnet_otherUnreach --output-path $out_tcp_icmpOtherUnreach

rwsettool --union $in_http_ttl $in_ssh_ttl $in_tls_ttl $in_cwmp_ttl $in_telnet_ttl --output-path $out_tcp_icmpTTL

rwsettool --union $in_http_other $in_ssh_other $in_tls_other $in_cwmp_other $in_telnet_other --output-path $out_tcp_icmpOther

rwsettool --union $in_http_icmpErr_union $in_ssh_icmpErr_union $in_tls_icmpErr_union $in_cwmp_icmpErr_union $in_telnet_icmpErr_union --output-path $out_tcp_icmpErrUnion

# %%%%% UDP %%%%%%%%

out_udp_icmpPortUnreach=$out_folder_prefix"udp_icmpPortUnreach.set"
out_udp_icmpHostUnreach=$out_folder_prefix"udp_icmpHostUnreach.set"
out_udp_icmpOtherUnreach=$out_folder_prefix"udp_icmpOtherUnreach.set"
out_udp_icmpTTL=$out_folder_prefix"udp_icmpTTL.set"
out_udp_icmpOther=$out_folder_prefix"udp_icmpOther.set"
out_udp_icmpErrUnion=$out_folder_prefix"udp_icmpErrUnion.set"

rwsettool --union $in_dns_portUnreach $in_ntp_portUnreach --output-path $out_udp_icmpPortUnreach

rwsettool --union $in_dns_otherUnreach $in_ntp_otherUnreach --output-path $out_udp_icmpOtherUnreach

rwsettool --union $in_dns_ttl $in_ntp_ttl --output-path $out_udp_icmpTTL

rwsettool --union $in_dns_hostUnreach $in_ntp_hostUnreach --output-path $out_udp_icmpHostUnreach

rwsettool --union $in_dns_other $in_ntp_other --output-path $out_udp_icmpOther

rwsettool --union $in_dns_icmpErr_union $in_ntp_icmpErr_union --output-path $out_udp_icmpErrUnion

# %%%%% ICMP %%%%%%%%

out_icmp_icmpPortUnreach=$out_folder_prefix"icmp_icmpPortUnreach.set"
out_icmp_icmpHostUnreach=$out_folder_prefix"icmp_icmpHostUnreach.set"
out_icmp_icmpOtherUnreach=$out_folder_prefix"icmp_icmpOtherUnreach.set"
out_icmp_icmpTTL=$out_folder_prefix"icmp_icmpTTL.set"
out_icmp_icmpOther=$out_folder_prefix"icmp_icmpOther.set"
out_icmp_icmpErrUnion=$out_folder_prefix"icmp_icmpErrUnion.set"

cp $in_icmp_portUnreach $out_icmp_icmpPortUnreach
cp $in_icmp_hostUnreach $out_icmp_icmpHostUnreach
cp $in_icmp_otherUnreach $out_icmp_icmpOtherUnreach
cp $in_icmp_ttl $out_icmp_icmpTTL
cp $in_icmp_other $out_icmp_icmpOther
cp $in_icmp_icmpErr_union $out_icmp_icmpErrUnion

# %%%%% TCP Unique %%%%%%%%

out_tcp_icmpPortUnreach_unique=$out_folder_prefix"tcp_icmpPortUnreach_unique.set"
out_tcp_icmpHostUnreach_unique=$out_folder_prefix"tcp_icmpHostUnreach_unique.set"
out_tcp_icmpOtherUnreach_unique=$out_folder_prefix"tcp_icmpOtherUnreach_unique.set"
out_tcp_icmpTTL_unique=$out_folder_prefix"tcp_icmpTTL_unique.set"
out_tcp_icmpOther_unique=$out_folder_prefix"tcp_icmpOther_unique.set"
out_tcp_multipleErr=$out_folder_prefix"tcp_multipleErr.set"

rwsettool --difference $out_tcp_icmpPortUnreach $out_tcp_icmpOtherUnreach $out_tcp_icmpHostUnreach $out_tcp_icmpOther --output-path  $out_tcp_icmpPortUnreach_unique

rwsettool --difference $out_tcp_icmpOtherUnreach $out_tcp_icmpPortUnreach  $out_tcp_icmpHostUnreach $out_tcp_icmpOther --output-path  $out_tcp_icmpOtherUnreach_unique

rwsettool --difference $out_tcp_icmpHostUnreach $out_tcp_icmpPortUnreach $out_tcp_icmpOtherUnreach $out_tcp_icmpOther --output-path  $out_tcp_icmpHostUnreach_unique

rwsettool --difference $out_tcp_icmpOther $out_tcp_icmpPortUnreach $out_tcp_icmpOtherUnreach $out_tcp_icmpHostUnreach --output-path  $out_tcp_icmpOther_unique

rwsettool --difference $out_tcp_icmpErrUnion  $out_tcp_icmpPortUnreach_unique $out_tcp_icmpOtherUnreach_unique $out_tcp_icmpHostUnreach_unique $out_tcp_icmpOther_unique --output-path $out_tcp_multipleErr

# %%%%% UDP Unique %%%%%%%%

out_udp_icmpPortUnreach_unique=$out_folder_prefix"udp_icmpPortUnreach_unique.set"
out_udp_icmpHostUnreach_unique=$out_folder_prefix"udp_icmpHostUnreach_unique.set"
out_udp_icmpOtherUnreach_unique=$out_folder_prefix"udp_icmpOtherUnreach_unique.set"
out_udp_icmpTTL_unique=$out_folder_prefix"udp_icmpTTL_unique.set"
out_udp_icmpOther_unique=$out_folder_prefix"udp_icmpOther_unique.set"
out_udp_multipleErr=$out_folder_prefix"udp_multipleErr.set"

rwsettool --difference $out_udp_icmpPortUnreach $out_udp_icmpOtherUnreach $out_udp_icmpHostUnreach $out_udp_icmpOther --output-path  $out_udp_icmpPortUnreach_unique

rwsettool --difference $out_udp_icmpOtherUnreach $out_udp_icmpPortUnreach  $out_udp_icmpHostUnreach $out_udp_icmpOther --output-path  $out_udp_icmpOtherUnreach_unique

rwsettool --difference $out_udp_icmpHostUnreach $out_udp_icmpPortUnreach $out_udp_icmpOtherUnreach $out_udp_icmpOther --output-path  $out_udp_icmpHostUnreach_unique

rwsettool --difference $out_udp_icmpOther $out_udp_icmpPortUnreach $out_udp_icmpOtherUnreach $out_udp_icmpHostUnreach --output-path  $out_udp_icmpOther_unique

rwsettool --difference $out_udp_icmpErrUnion  $out_udp_icmpPortUnreach_unique $out_udp_icmpOtherUnreach_unique $out_udp_icmpHostUnreach_unique $out_udp_icmpOther_unique --output-path $out_udp_multipleErr

# %%%%% ICMP Unique %%%%%%%%

out_icmp_icmpPortUnreach_unique=$out_folder_prefix"icmp_icmpPortUnreach_unique.set"
out_icmp_icmpHostUnreach_unique=$out_folder_prefix"icmp_icmpHostUnreach_unique.set"
out_icmp_icmpOtherUnreach_unique=$out_folder_prefix"icmp_icmpOtherUnreach_unique.set"
out_icmp_icmpTTL_unique=$out_folder_prefix"icmp_icmpTTL_unique.set"
out_icmp_icmpOther_unique=$out_folder_prefix"icmp_icmpOther_unique.set"
out_icmp_multipleErr=$out_folder_prefix"icmp_multipleErr.set"

rwsettool --difference $out_icmp_icmpPortUnreach $out_icmp_icmpOtherUnreach $out_icmp_icmpHostUnreach $out_icmp_icmpOther --output-path  $out_icmp_icmpPortUnreach_unique

rwsettool --difference $out_icmp_icmpOtherUnreach $out_icmp_icmpPortUnreach  $out_icmp_icmpHostUnreach $out_icmp_icmpOther --output-path  $out_icmp_icmpOtherUnreach_unique

rwsettool --difference $out_icmp_icmpHostUnreach $out_icmp_icmpPortUnreach $out_icmp_icmpOtherUnreach $out_icmp_icmpOther --output-path  $out_icmp_icmpHostUnreach_unique

rwsettool --difference $out_icmp_icmpOther $out_icmp_icmpPortUnreach $out_icmp_icmpOtherUnreach $out_icmp_icmpHostUnreach --output-path  $out_icmp_icmpOther_unique

rwsettool --difference $out_icmp_icmpErrUnion  $out_icmp_icmpPortUnreach_unique $out_icmp_icmpOtherUnreach_unique $out_icmp_icmpHostUnreach_unique $out_icmp_icmpOther_unique --output-path $out_icmp_multipleErr
