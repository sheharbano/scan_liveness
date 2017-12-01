folder_prefix="/home/bano/my_media/nemesis/vertical/"$scan_folder"/"

in_file=$folder_prefix"dns/proc/flat/dns.flat"

in_file_dnsSuccess=$folder_prefix"dns/out_udp/out_srcIP_dns_success.set"
tmp=$folder_prefix"tmp.set"

out_file_unreach=$folder_prefix"dns/out_udp/out_innerdaddr_icmpUnreach.set"
out_file_timxceed=$folder_prefix"dns/out_udp/out_innerdaddr_icmpTimxceed.set"
out_file_redirect=$folder_prefix"dns/out_udp/out_innerdaddr_icmpRedirect.set"
out_file_srcquench=$folder_prefix"dns/out_udp/out_innerdaddr_icmpSrcquench.set"
out_file_all=$folder_prefix"dns/out_udp/out_innerdaddr.set"

log_file=$folder_prefix"dns/out_udp/log_out_srcIP_udp53IcmpInnerdaddr_set.log"

>$log_file

echo 'Started at: '`date` >>$log_file

awk -F"\t" '$3=="timxceed"{print $11}' $in_file | rwsetbuild stdin $out_file_timxceed

awk -F"\t" '$3=="unreach"{print $11}' $in_file | rwsetbuild stdin $out_file_unreach

awk -F"\t" '$3=="redirect"{print $11}' $in_file | rwsetbuild stdin $out_file_redirect

awk -F"\t" '$3=="sourcequench"{print $11}' $in_file | rwsetbuild stdin $out_file_srcquench

rwsettool --union $out_file_unreach $out_file_timxceed $out_file_redirect $out_file_srcquench --output-path $out_file_all

echo 'Finished at: '`date` >>$log_file
