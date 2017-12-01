folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file=$folder_prefix"icmp/out_icmp/out.log"

out_file_unreach=$folder_prefix"icmp/out_icmp/out_innerdaddr_icmpUnreach.set"
out_file_timxceed=$folder_prefix"icmp/out_icmp/out_innerdaddr_icmpTimxceed.set"
out_file_redirect=$folder_prefix"icmp/out_icmp/out_innerdaddr_icmpRedirect.set"
out_file_srcquench=$folder_prefix"icmp/out_icmp/out_innerdaddr_icmpSrcquench.set"
out_file_all=$folder_prefix"icmp/out_icmp/out_innerdaddr.set"

log_file=$folder_prefix"icmp/out_icmp/log_out_srcIP_icmpIcmpInnerdaddr_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"," '$0!~/^class/&&$1=="timxceed"{print $10}' $in_file | rwsetbuild stdin $out_file_timxceed

awk -F"," '$0!~/^class/&&$1=="unreach"{print $10}' $in_file | rwsetbuild stdin $out_file_unreach

awk -F"," '$0!~/^class/&&$1=="redirect"{print $10}' $in_file | rwsetbuild stdin $out_file_redirect

awk -F"," '$0!~/^class/&&$1=="sourcequench"{print $10}' $in_file | rwsetbuild stdin $out_file_srcquench

rwsettool --union $out_file_unreach $out_file_timxceed $out_file_redirect $out_file_srcquench --output-path $out_file_all

echo 'Finished at: '`date` >>$log_file
