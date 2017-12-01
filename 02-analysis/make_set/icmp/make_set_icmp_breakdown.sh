folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"

in_file=$folder_prefix"icmp/out_icmp/out.log"

out_file_ALL=$folder_prefix"icmp/out_icmp/out_srcIP.set"
out_file_echoreply=$folder_prefix"icmp/out_icmp/out_srcIP_echoreply.set"
out_file_icmpErr=$folder_prefix"icmp/out_icmp/out_srcIP_icmpErr.set"

tmp=$folder_prefix"tmp.set"
out_file_unreach=$folder_prefix"icmp/out_icmp/out_srcIP_unreach.set"
out_file_timxceed=$folder_prefix"icmp/out_icmp/out_srcIP_timxceed.set"
out_file_redirect=$folder_prefix"icmp/out_icmp/out_srcIP_redirect.set"
out_file_srcquench=$folder_prefix"icmp/out_icmp/out_srcIP_srcquench.set"
out_file_other=$folder_prefix"icmp/out_icmp/out_srcIP_other.set"

out_file_portUnreach=$folder_prefix"icmp/out_icmp/out_srcip_icmpPortUnreach.set"
out_file_hostUnreach=$folder_prefix"icmp/out_icmp/out_srcip_icmpHostUnreach.set"
out_file_otherUnreach=$folder_prefix"icmp/out_icmp/out_srcip_icmpOtherUnreach.set"
out_file_union_srcquench_redirect=$folder_prefix"icmp/out_icmp/out_srcip_icmp_union_SrcquenchRedirect.set"
out_file_union_srcquench_redirect_ttl=$folder_prefix"icmp/out_icmp/out_srcip_icmp_union_SrcquenchRedirectTtl.set"

log_file=$folder_prefix"icmp/out_icmp/log_out_srcIP_breakdown_set.log"

#>$log_file
#
#echo 'Started at: '`date` >>$log_file
#
#awk -F"," '$0!~/^class/&&$1=="echoreply"{print $2}' $in_file | rwsetbuild stdin $out_file_echoreply
#
#awk -F"," '$0!~/^class/&&$1=="unreach"{print $2}' $in_file | rwsetbuild stdin $out_file_unreach
#
#awk -F"," '$0!~/^class/&&$1=="timxceed"{print $2}' $in_file | rwsetbuild stdin $out_file_timxceed
#
#awk -F"," '$0!~/^class/&&$1=="redirect"{print $2}' $in_file | rwsetbuild stdin $out_file_redirect
#
#awk -F"," '$0!~/^class/&&$1=="sourcequench"{print $2}' $in_file | rwsetbuild stdin $out_file_srcquench
#
#awk -F"," '$0!~/^class/&&$1=="other"{print $2}' $in_file | rwsetbuild stdin $out_file_other
#
#rwsettool --union $out_file_echoreply $out_file_timxceed $out_file_redirect $out_file_srcquench $out_file_unreach --output-path $out_file_ALL
#
#rwsettool --union $out_file_timxceed $out_file_redirect $out_file_srcquench $out_file_unreach --output-path $out_file_icmpErr

#rwsettool --union $out_file_redirect $out_file_srcquench --output-path $out_file_union_srcquench_redirect

rwsettool --union $out_file_redirect $out_file_srcquench $out_file_ttl  --output-path $out_file_union_srcquench_redirect_ttl

#awk -F"," '$0!~/^class/&&$1=="unreach" && $9=="3"{print $2}' $in_file | rwsetbuild stdin $out_file_portUnreach

awk -F"," '$0!~/^class/&&$1=="unreach" && $9=="1"{print $2}' $in_file | rwsetbuild stdin $out_file_hostUnreach

awk -F"," '$0!~/^class/&&$1=="unreach" && $9!="3" && $9!="1"{print $2}' $in_file | rwsetbuild stdin $out_file_otherUnreach

#echo 'Finished at: '`date` >>$log_file
