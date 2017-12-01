scan_folder="05-09-2017"
folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/dns/"

in_file=$folder_prefix"proc/flat/dns.flat"

in_file_dnsSuccess=$folder_prefix"out_udp/out_srcIP_dns_success.set"
tmp=$folder_prefix"tmp.set"

out_file_unreach=$folder_prefix"out_udp/out_srcip_icmpUnreach.set"
out_file_timxceed=$folder_prefix"out_udp/out_srcip_icmpTimxceed.set"
out_file_redirect=$folder_prefix"out_udp/out_srcip_icmpRedirect.set"
out_file_srcquench=$folder_prefix"out_udp/out_srcip_icmpSrcquench.set"
out_file_all=$folder_prefix"out_udp/out_srcip_icmp.set"

out_file_portUnreach=$folder_prefix"out_udp/out_srcip_icmpPortUnreach.set"
out_file_hostUnreach=$folder_prefix"out_udp/out_srcip_icmpHostUnreach.set"
out_file_otherUnreach=$folder_prefix"out_udp/out_srcip_icmpOtherUnreach.set"
out_file_union_srcquench_redirect=$folder_prefix"out_udp/out_srcip_icmp_union_SrcquenchRedirect.set"
out_file_union_srcquench_redirect_ttl=$folder_prefix"out_udp/out_srcip_icmp_union_SrcquenchRedirectTtl.set"

log_file=$folder_prefix"out_udp/log_out_srcIP_udp53IcmpSrcip_set.log"

#>$log_file
#
#echo 'Started at: '`date` >>$log_file
#
#awk -F"\t" '$3=="timxceed"{print $5}' $in_file | rwsetbuild stdin $out_file_timxceed
#
#awk -F"\t" '$3=="unreach"{print $5}' $in_file | rwsetbuild stdin $out_file_unreach
#
#awk -F"\t" '$3=="redirect"{print $5}' $in_file | rwsetbuild stdin $out_file_redirect
#
#awk -F"\t" '$3=="sourcequench"{print $5}' $in_file | rwsetbuild stdin $out_file_srcquench
#
#rwsettool --union $out_file_unreach $out_file_timxceed $out_file_redirect $out_file_srcquench --output-path $out_file_all

#rwsettool --union $out_file_redirect $out_file_srcquench --output-path $out_file_union_srcquench_redirect

rwsettool --union $out_file_redirect $out_file_srcquench $out_file_ttl --output-path $out_file_union_srcquench_redirect_ttl

#awk -F"\t" '$3=="unreach" && $10=="3" {print $5}' $in_file | rwsetbuild stdin  $out_file_portUnreach

awk -F"\t" '$3=="unreach" && $10=="1" {print $5}' $in_file | rwsetbuild stdin  $out_file_hostUnreach

awk -F"\t" '$3=="unreach" && $10!="3" && $10!="1" {print $5}' $in_file | rwsetbuild stdin  $out_file_otherUnreach


#echo 'Finished at: '`date` >>$log_file
