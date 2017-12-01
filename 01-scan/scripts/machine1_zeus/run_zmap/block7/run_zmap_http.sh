#!/bin/bash
config_prefix="/usr/share/scan_config/http/"

source $config_prefix"tcp_tuning_config.sh" 
source $config_prefix"zmap_config.sh"
source $config_prefix"ztee_config.sh"
source $config_prefix"zgrab_config.sh"
source $config_prefix"paths_config.sh"

# Which network block to scan
block="192.0.0.0/3"
block_code="block7"

# Path where all results of current scan(s) will go
mkdir -p $out_prefix

# Where is zgrab
path_zgrab=$path_home"go_work/src/github.com/zmap/zgrab/"

# ====== HTTP ========

# Where to save http results
mkdir -p $path_http

# log file for http scan(s)
log_http=$path_http"log_http.txt"
touch $log_http

# To which scan block do the results correspond
# FIXME: WHICH BLOCK? IN MOST SCANS, THIS IS THE ONLY PART THAT NEEDS TO BE FIXED
path_http_block=$path_http""$block_code"/"
mkdir -p $path_http_block

# for tcp output
out_tcp=$path_http_block"out_tcp/"
mkdir -p $out_tcp

# for http output
out_http=$path_http_block"out_http/"
mkdir -p $out_http


echo "HTTP "$block" started at: "`date -u` >> $log_http

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p $target_port -r $scan_rate --sender-threads=$send_threads -c $tcp_cooloff -b $path_blacklist --output-module=csv -f $out_fields -m $out_tcp"meta.log" $block 2>$out_tcp"err.log" | taskset -c $cores_ztee $path_zmap""ztee $out_tcp"out.log" -u $path_http_block"ztee_monitor.csv" --success-only | taskset -c $cores_zgrab $path_zgrab""zgrab --interface $interface --port $target_port --log-file $out_http"err.log" --metadata-file $out_http"meta.log" --output-file=$out_http"out.log" --timeout=$zgrab_timeout --senders $zgrab_senders --http "/" --http-max-redirects=$zgrab_http_redirects --gomaxprocs $zgrab_cpu


echo "HTTP "$block" finished at: "`date -u` >> $log_http

