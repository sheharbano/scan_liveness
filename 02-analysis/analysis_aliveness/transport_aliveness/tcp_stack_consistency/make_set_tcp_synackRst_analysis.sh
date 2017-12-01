#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"
out_folder_prefix=$folder_prefix"analysis/transport_aliveness/tcp_stack_consistency/"

mkdir -p $out_folder_prefix

# ----- HTTP ------

in_folder_prefix=$folder_prefix"http/out_tcp/diff_sets/"

in_http_synack=$in_folder_prefix"out_srcIP_synack.set"
in_http_rst=$in_folder_prefix"out_srcIP_rst.set"
in_http_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"

# ----- SSH ------

in_folder_prefix=$folder_prefix"ssh/out_tcp/diff_sets/"

in_ssh_synack=$in_folder_prefix"out_srcIP_synack.set"
in_ssh_rst=$in_folder_prefix"out_srcIP_rst.set"
in_ssh_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"

# ----- TLS ------

in_folder_prefix=$folder_prefix"tls/out_tcp/diff_sets/"

in_tls_synack=$in_folder_prefix"out_srcIP_synack.set"
in_tls_rst=$in_folder_prefix"out_srcIP_rst.set"
in_tls_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"

# ----- CWMP ------

in_folder_prefix=$folder_prefix"cwmp/out_tcp/diff_sets/"

in_cwmp_synack=$in_folder_prefix"out_srcIP_synack.set"
in_cwmp_rst=$in_folder_prefix"out_srcIP_rst.set"
in_cwmp_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"

# ----- Telnet ------

in_folder_prefix=$folder_prefix"telnet/out_tcp/diff_sets/"

in_telnet_synack=$in_folder_prefix"out_srcIP_synack.set"
in_telnet_rst=$in_folder_prefix"out_srcIP_rst.set"
in_telnet_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"

# ------ UNION --------

out_tcp_synack=$out_folder_prefix"tcp_synack.set"
out_tcp_rst=$out_folder_prefix"tcp_rst.set"
out_tcp_unionSynackRst=$out_folder_prefix"tcp_unionSynackRst.set"

out_tcp_catSynackRst=$out_folder_prefix"tcp_catSynackRst.txt"
out_tcp_catSynackRst_freqDist=$out_folder_prefix"tcp_catSynackRst_freqDist.bag"
out_tcp_catSynackRst_freqDist_txt=$out_folder_prefix"tcp_catSynackRst_freqDist.txt"

out_5=$out_folder_prefix"5.set"
out_4=$out_folder_prefix"4.set"
out_3=$out_folder_prefix"3.set"
out_2=$out_folder_prefix"2.set"
out_1=$out_folder_prefix"1.set"

rwsettool --union $in_http_synack $in_ssh_synack $in_tls_synack $in_cwmp_synack $in_telnet_synack --output-path $out_tcp_synack

rwsettool --union $in_http_rst $in_ssh_rst $in_tls_rst $in_cwmp_rst $in_telnet_rst --output-path $out_tcp_rst

rwsettool --union $in_http_unionSynackRst $in_ssh_unionSynackRst $in_tls_unionSynackRst $in_cwmp_unionSynackRst $in_telnet_unionSynackRst --output-path $out_tcp_unionSynackRst

rwsetcat $in_http_unionSynackRst $in_ssh_unionSynackRst $in_tls_unionSynackRst $in_cwmp_unionSynackRst $in_telnet_unionSynackRst > $out_tcp_catSynackRst

# Then create freq dist
rwbagbuild --bag-input=$out_tcp_catSynackRst --output-path=$out_tcp_catSynackRst_freqDist

# convert it into text file 
rwbagcat $out_tcp_catSynackRst_freqDist > $out_tcp_catSynackRst_freqDist_txt

# IPs with count 5 in Freq Dist
cat $out_tcp_catSynackRst_freqDist_txt | awk '$2=="5|"{split($1,arr,"|");print arr[1]}' | rwsetbuild stdin $out_5

# IPs with count 4 in Freq Dist
cat $out_tcp_catSynackRst_freqDist_txt | awk '$2=="4|"{split($1,arr,"|");print arr[1]}' | rwsetbuild stdin $out_4

# IPs with count 3 in Freq Dist
cat $out_tcp_catSynackRst_freqDist_txt | awk '$2=="3|"{split($1,arr,"|");print arr[1]}' | rwsetbuild stdin $out_3

# IPs with count 2 in Freq Dist
cat $out_tcp_catSynackRst_freqDist_txt | awk '$2=="2|"{split($1,arr,"|");print arr[1]}' | rwsetbuild stdin $out_2

# IPs with count 1 in Freq Dist
cat $out_tcp_catSynackRst_freqDist_txt | awk '$2=="1|"{split($1,arr,"|");print arr[1]}' | rwsetbuild stdin $out_1

#------- 1 SynAck/Rst -------

out_folder_prefix_1=$out_folder_prefix"one/"
mkdir -p $out_folder_prefix_1

out_1_both=$out_folder_prefix_1"both.set"
out_1_onlySynAck=$out_folder_prefix_1"synackOnly.set"
out_1_onlyRst=$out_folder_prefix_1"rstOnly.set"
tmp=$out_folder_prefix"tmp.set"

# set_X INTERSECT SYN_ACK INTERSECT RST == “both”
rwsettool --intersect $out_1 $out_tcp_synack $out_tcp_rst --output-path $out_1_both

# set_X INTERSECT SYNACK DIFFERENCE RST = only SYNACK
rwsettool --difference $out_tcp_synack $out_tcp_rst --output-path $tmp

rwsettool --intersect $out_1 $tmp --output-path $out_1_onlySynAck

rm $tmp

# set_X INTERSECT RST DIFFERENCE SYNACK = only RST
rwsettool --difference $out_tcp_rst $out_tcp_synack --output-path $tmp

rwsettool --intersect $out_1 $tmp --output-path $out_1_onlyRst

rm $tmp

#------- 2 SynAck/Rst -------

out_folder_prefix_2=$out_folder_prefix"two/"
mkdir -p $out_folder_prefix_2

out_2_both=$out_folder_prefix_2"both.set"
out_2_onlySynAck=$out_folder_prefix_2"synackOnly.set"
out_2_onlyRst=$out_folder_prefix_2"rstOnly.set"
tmp=$out_folder_prefix"tmp.set"

# set_X INTERSECT SYN_ACK INTERSECT RST == “both”
rwsettool --intersect $out_2 $out_tcp_synack $out_tcp_rst --output-path $out_2_both

# set_X INTERSECT SYNACK DIFFERENCE RST = only SYNACK
rwsettool --difference $out_tcp_synack $out_tcp_rst --output-path $tmp

rwsettool --intersect $out_2 $tmp --output-path $out_2_onlySynAck

rm $tmp

# set_X INTERSECT RST DIFFERENCE SYNACK = only RST
rwsettool --difference $out_tcp_rst $out_tcp_synack --output-path $tmp

rwsettool --intersect $out_2 $tmp --output-path $out_2_onlyRst

rm $tmp

#------- 3 SynAck/Rst -------

out_folder_prefix_3=$out_folder_prefix"three/"
mkdir -p $out_folder_prefix_3

out_3_both=$out_folder_prefix_3"both.set"
out_3_onlySynAck=$out_folder_prefix_3"synackOnly.set"
out_3_onlyRst=$out_folder_prefix_3"rstOnly.set"
tmp=$out_folder_prefix"tmp.set"

# set_X INTERSECT SYN_ACK INTERSECT RST == “both”
rwsettool --intersect $out_3 $out_tcp_synack $out_tcp_rst --output-path $out_3_both

# set_X INTERSECT SYNACK DIFFERENCE RST = only SYNACK
rwsettool --difference $out_tcp_synack $out_tcp_rst --output-path $tmp

rwsettool --intersect $out_3 $tmp --output-path $out_3_onlySynAck

rm $tmp

# set_X INTERSECT RST DIFFERENCE SYNACK = only RST
rwsettool --difference $out_tcp_rst $out_tcp_synack --output-path $tmp

rwsettool --intersect $out_3 $tmp --output-path $out_3_onlyRst

rm $tmp

#------- 4 SynAck/Rst -------

out_folder_prefix_4=$out_folder_prefix"four/"
mkdir -p $out_folder_prefix_4

out_4_both=$out_folder_prefix_4"both.set"
out_4_onlySynAck=$out_folder_prefix_4"synackOnly.set"
out_4_onlyRst=$out_folder_prefix_4"rstOnly.set"
tmp=$out_folder_prefix"tmp.set"

# set_X INTERSECT SYN_ACK INTERSECT RST == “both”
rwsettool --intersect $out_4 $out_tcp_synack $out_tcp_rst --output-path $out_4_both

# set_X INTERSECT SYNACK DIFFERENCE RST = only SYNACK
rwsettool --difference $out_tcp_synack $out_tcp_rst --output-path $tmp

rwsettool --intersect $out_4 $tmp --output-path $out_4_onlySynAck

rm $tmp

# set_X INTERSECT RST DIFFERENCE SYNACK = only RST
rwsettool --difference $out_tcp_rst $out_tcp_synack --output-path $tmp

rwsettool --intersect $out_4 $tmp --output-path $out_4_onlyRst

rm $tmp


#------- 5 SynAck/Rst -------

out_folder_prefix_5=$out_folder_prefix"five/"
mkdir -p $out_folder_prefix_5

out_5_both=$out_folder_prefix_5"both.set"
out_5_onlySynAck=$out_folder_prefix_5"synackOnly.set"
out_5_onlyRst=$out_folder_prefix_5"rstOnly.set"
tmp=$out_folder_prefix"tmp.set"

# set_X INTERSECT SYN_ACK INTERSECT RST == “both”
rwsettool --intersect $out_5 $out_tcp_synack $out_tcp_rst --output-path $out_5_both

# set_X INTERSECT SYNACK DIFFERENCE RST = only SYNACK
rwsettool --difference $out_tcp_synack $out_tcp_rst --output-path $tmp

rwsettool --intersect $out_5 $tmp --output-path $out_5_onlySynAck

rm $tmp

# set_X INTERSECT RST DIFFERENCE SYNACK = only RST
rwsettool --difference $out_tcp_rst $out_tcp_synack --output-path $tmp

rwsettool --intersect $out_5 $tmp --output-path $out_5_onlyRst

rm $tmp


