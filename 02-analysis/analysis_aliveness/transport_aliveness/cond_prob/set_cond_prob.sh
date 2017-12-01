folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"
folder_out=$folder_prefix"analysis/nw_aliveness/cond_prob_byProto/"
mkdir -p $folder_out
log_file=$folder_out"log_condProb.log"
>$log_file
tmp_union=$folder_out"tmp_union.set"
tmp_intersect=$folder_out"tmp_intersect.set"
in_icmp=$folder_prefix"icmp/out_icmp/diff_sets/out_srcIP.set"
in_http=$folder_prefix"http/out_tcp/diff_sets/out_srcIP.set"
in_ssh=$folder_prefix"ssh/out_tcp/diff_sets/out_srcIP.set"
in_tls=$folder_prefix"tls/out_tcp/diff_sets/out_srcIP.set"
in_cwmp=$folder_prefix"cwmp/out_tcp/diff_sets/out_srcIP.set"
in_telnet=$folder_prefix"telnet/out_tcp/diff_sets/out_srcIP.set"
in_dns=$folder_prefix"dns/out_udp/diff_sets/out_srcIP.set"
in_ntp=$folder_prefix"ntp/out_udp/diff_sets/out_srcIP.set"

#=========== 00000001 ============
echo 'Started at: '`date` >>$log_file
cp $in_ntp  $tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00000010 ============
echo 'Started at: '`date` >>$log_file
cp $in_dns  $tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00000011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00000100 ============
echo 'Started at: '`date` >>$log_file
cp $in_telnet  $tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00000101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00000110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00000111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00000111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001000 ============
echo 'Started at: '`date` >>$log_file
cp $in_cwmp  $tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00001111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00001111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010000 ============
echo 'Started at: '`date` >>$log_file
cp $in_tls  $tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00010111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00010111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00011111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ssh --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00011111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100000 ============
echo 'Started at: '`date` >>$log_file
cp $in_ssh  $tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00100111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00100111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00101111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00101111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00110111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00110111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 00111111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_http --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"00111111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000000 ============
echo 'Started at: '`date` >>$log_file
cp $in_http  $tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01000111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01000111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01001111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01001111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01010111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01010111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01011111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ssh --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01011111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01100111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01100111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01101111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01101111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01110111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01110111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_icmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 01111111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
cp $in_icmp  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"01111111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000000 ============
echo 'Started at: '`date` >>$log_file
cp $in_icmp  $tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10000111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10000111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10001111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10001111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10010111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10010111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10011111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_ssh --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10011111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10100111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10100111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10101111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10101111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10110111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10110111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_http $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_http $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_http $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_http $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 10111111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
cp $in_http  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"10111111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11000111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11000111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11001111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_tls --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11001111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11010111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11010111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_ssh $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11011111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
cp $in_ssh  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11011111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_dns --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11100111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_cwmp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11100111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_tls $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_tls $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_tls $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_tls $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11101111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
cp $in_tls  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11101111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_dns --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_dns $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_telnet --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_telnet $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_telnet $in_dns --output-path=$tmp_intersect
rwsettool --union $in_cwmp $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11110111 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_telnet $in_dns $in_ntp --output-path=$tmp_intersect
cp $in_cwmp  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11110111.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111000 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp --output-path=$tmp_intersect
rwsettool --union $in_telnet $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111000.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111001 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_ntp --output-path=$tmp_intersect
rwsettool --union $in_telnet $in_dns --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111001.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111010 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_dns --output-path=$tmp_intersect
rwsettool --union $in_telnet $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111010.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111011 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_dns $in_ntp --output-path=$tmp_intersect
cp $in_telnet  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111011.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111100 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet --output-path=$tmp_intersect
rwsettool --union $in_dns $in_ntp --output-path=$tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111100.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111101 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_ntp --output-path=$tmp_intersect
cp $in_dns  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111101.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

#=========== 11111110 ============
echo 'Started at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns --output-path=$tmp_intersect
cp $in_ntp  $tmp_union
rwsettool --difference $tmp_intersect $tmp_union --output-path=$folder_out"11111110.set"
rm $tmp_intersect
rm $tmp_union
echo 'Finished at: '`date` >>$log_file

# ============ UNION ============
out_UNION=$folder_out"UNION.set"
echo 'Started UNION at: '`date` >>$log_file
rwsettool --union $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$out_UNION
echo 'Finished UNION at: '`date` >>$log_file

# ============ INTERSECT ============
out_INTERSECT=$folder_out"INTERSECT.set"
echo 'Started INTERSECT at: '`date` >>$log_file
rwsettool --intersect $in_icmp $in_http $in_ssh $in_tls $in_cwmp $in_telnet $in_dns $in_ntp --output-path=$out_INTERSECT
echo 'Finished INTERSECT at: '`date` >>$log_file
