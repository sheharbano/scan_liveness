#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"
out_folder_prefix=$folder_prefix"analysis/app_aliveness/tarpit_analysis/"

mkdir -p $out_folder_prefix

# ----- HTTP ------

in_folder_prefix=$folder_prefix"http/out_tcp/diff_sets/"

in_http_tcpAlive=$in_folder_prefix"out_srcIP_synack.set"
in_http_appActiveOrAlive=$in_folder_prefix"out_srcIP_http_activeOrAlive.set"

out_http_tarpits=$out_folder_prefix"http_tarpits.set"

rwsettool --difference $in_http_tcpAlive $in_http_appActiveOrAlive --output-path $out_http_tarpits

# ----- SSH ------

in_folder_prefix=$folder_prefix"ssh/out_tcp/diff_sets/"

in_ssh_tcpAlive=$in_folder_prefix"out_srcIP_synack.set"
in_ssh_appActiveOrAlive=$in_folder_prefix"out_srcIP_ssh_success.set"

out_ssh_tarpits=$out_folder_prefix"ssh_tarpits.set"

rwsettool --difference $in_ssh_tcpAlive $in_ssh_appActiveOrAlive --output-path $out_ssh_tarpits

# ----- TLS ------

in_folder_prefix=$folder_prefix"tls/out_tcp/diff_sets/"

in_tls_tcpAlive=$in_folder_prefix"out_srcIP_synack.set"
in_tls_appActiveOrAlive=$in_folder_prefix"out_srcIP_tls_activeOrAlive.set"

out_tls_tarpits=$out_folder_prefix"tls_tarpits.set"

rwsettool --difference $in_tls_tcpAlive $in_tls_appActiveOrAlive --output-path $out_tls_tarpits

# ----- CWMP ------

in_folder_prefix=$folder_prefix"cwmp/out_tcp/diff_sets/"

in_cwmp_tcpAlive=$in_folder_prefix"out_srcIP_synack.set"
in_cwmp_appActiveOrAlive=$in_folder_prefix"out_srcIP_cwmp_activeOrAlive.set"

out_cwmp_tarpits=$out_folder_prefix"cwmp_tarpits.set"

rwsettool --difference $in_cwmp_tcpAlive $in_cwmp_appActiveOrAlive --output-path $out_cwmp_tarpits


# ----- Telnet ------

in_folder_prefix=$folder_prefix"telnet/out_tcp/diff_sets/"

in_telnet_tcpAlive=$in_folder_prefix"out_srcIP_synack.set"
in_telnet_appActiveOrAlive=$in_folder_prefix"out_srcIP_telnet_success.set"

out_telnet_tarpits=$out_folder_prefix"telnet_tarpits.set"

rwsettool --difference $in_telnet_tcpAlive $in_telnet_appActiveOrAlive --output-path $out_telnet_tarpits


# ----- Find tarpits ------
# Intersect all failed application-layer IPs

out_tarpits=$out_folder_prefix"tarpits.set"

rwsettool --intersect $out_http_tarpits $out_ssh_tarpits $out_tls_tarpits $out_cwmp_tarpits $out_telnet_tarpits --output-path $out_tarpits


