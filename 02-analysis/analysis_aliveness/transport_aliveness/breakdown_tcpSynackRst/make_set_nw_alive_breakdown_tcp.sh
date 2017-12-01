#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"
out_folder_prefix=$folder_prefix"analysis/transport_aliveness/breakdown_tcpSynackRst/"

mkdir -p $out_folder_prefix

## ----- HTTP ------
#
#in_folder_prefix=$folder_prefix"http/out_tcp/diff_sets/"
#
#in_http_synack=$in_folder_prefix"out_srcIP_synack.set"
#in_http_rst=$in_folder_prefix"out_srcIP_rst.set"
#in_http_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"
#
#out_http_synack_unique=$out_folder_prefix"http_synack_unique.set"
#out_http_rst_unique=$out_folder_prefix"http_rst_unique.set"
#out_http_bothSynackRst=$out_folder_prefix"http_bothSynackRst.set"
#out_http_totalSynackRst=$out_folder_prefix"http_totalSynackRst.set"
#
#rwsettool --difference $in_http_synack $in_http_rst --output-path $out_http_synack_unique
#
#rwsettool --difference $in_http_rst $in_http_synack --output-path $out_http_rst_unique
#
#rwsettool --difference $in_http_unionSynackRst $out_http_synack_unique $out_http_rst_unique --output-path $out_http_bothSynackRst 
#
#cp $in_http_unionSynackRst $out_http_totalSynackRst
#
## ----- SSH ------
#
#in_folder_prefix=$folder_prefix"ssh/out_tcp/diff_sets/"
#
#in_ssh_synack=$in_folder_prefix"out_srcIP_synack.set"
#in_ssh_rst=$in_folder_prefix"out_srcIP_rst.set"
#in_ssh_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"
#
#out_ssh_synack_unique=$out_folder_prefix"ssh_synack_unique.set"
#out_ssh_rst_unique=$out_folder_prefix"ssh_rst_unique.set"
#out_ssh_bothSynackRst=$out_folder_prefix"ssh_bothSynackRst.set"
#out_ssh_totalSynackRst=$out_folder_prefix"ssh_totalSynackRst.set"
#
#rwsettool --difference $in_ssh_synack $in_ssh_rst --output-path $out_ssh_synack_unique
#
#rwsettool --difference $in_ssh_rst $in_ssh_synack --output-path $out_ssh_rst_unique
#
#rwsettool --difference $in_ssh_unionSynackRst $out_ssh_synack_unique $out_ssh_rst_unique --output-path $out_ssh_bothSynackRst
#
#cp $in_ssh_unionSynackRst $out_ssh_totalSynackRst
#
## ----- TLS ------
#
#in_folder_prefix=$folder_prefix"tls/out_tcp/diff_sets/"
#
#in_tls_synack=$in_folder_prefix"out_srcIP_synack.set"
#in_tls_rst=$in_folder_prefix"out_srcIP_rst.set"
#in_tls_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"
#
#out_tls_synack_unique=$out_folder_prefix"tls_synack_unique.set"
#out_tls_rst_unique=$out_folder_prefix"tls_rst_unique.set"
#out_tls_bothSynackRst=$out_folder_prefix"tls_bothSynackRst.set"
#out_tls_totalSynackRst=$out_folder_prefix"tls_totalSynackRst.set"
#
#rwsettool --difference $in_tls_synack $in_tls_rst --output-path $out_tls_synack_unique
#
#rwsettool --difference $in_tls_rst $in_tls_synack --output-path $out_tls_rst_unique
#
#rwsettool --difference $in_tls_unionSynackRst $out_tls_synack_unique $out_tls_rst_unique --output-path $out_tls_bothSynackRst
#
#cp $in_tls_unionSynackRst $out_tls_totalSynackRst
#
## ----- CWMP ------
#
#in_folder_prefix=$folder_prefix"cwmp/out_tcp/diff_sets/"
#
#in_cwmp_synack=$in_folder_prefix"out_srcIP_synack.set"
#in_cwmp_rst=$in_folder_prefix"out_srcIP_rst.set"
#in_cwmp_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"
#
#out_cwmp_synack_unique=$out_folder_prefix"cwmp_synack_unique.set"
#out_cwmp_rst_unique=$out_folder_prefix"cwmp_rst_unique.set"
#out_cwmp_bothSynackRst=$out_folder_prefix"cwmp_bothSynackRst.set"
#out_cwmp_totalSynackRst=$out_folder_prefix"cwmp_totalSynackRst.set"
#
#rwsettool --difference $in_cwmp_synack $in_cwmp_rst --output-path $out_cwmp_synack_unique
#
#rwsettool --difference $in_cwmp_rst $in_cwmp_synack --output-path $out_cwmp_rst_unique
#
#rwsettool --difference $in_cwmp_unionSynackRst $out_cwmp_synack_unique $out_cwmp_rst_unique --output-path $out_cwmp_bothSynackRst
#
#cp $in_cwmp_unionSynackRst $out_cwmp_totalSynackRst
#
# ----- Telnet ------

in_folder_prefix=$folder_prefix"telnet/out_tcp/diff_sets/"

in_telnet_synack=$in_folder_prefix"out_srcIP_synack.set"
in_telnet_rst=$in_folder_prefix"out_srcIP_rst.set"
in_telnet_unionSynackRst=$in_folder_prefix"out_srcIP_synackRst.set"

out_telnet_synack_unique=$out_folder_prefix"telnet_synack_unique.set"
out_telnet_rst_unique=$out_folder_prefix"telnet_rst_unique.set"
out_telnet_bothSynackRst=$out_folder_prefix"telnet_bothSynackRst.set"
out_telnet_totalSynackRst=$out_folder_prefix"telnet_totalSynackRst.set"

rwsettool --difference $in_telnet_synack $in_telnet_rst --output-path $out_telnet_synack_unique

rwsettool --difference $in_telnet_rst $in_telnet_synack --output-path $out_telnet_rst_unique

rwsettool --difference $in_telnet_unionSynackRst $out_telnet_synack_unique $out_telnet_rst_unique --output-path $out_telnet_bothSynackRst

cp $in_telnet_unionSynackRst $out_telnet_totalSynackRst

