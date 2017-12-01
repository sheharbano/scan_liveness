#!/bin/bash

config_prefix="/usr/share/scan_config/tls/"

source $config_prefix"tcp_tuning_config.sh"
source $config_prefix"zmap_config.sh"
source $config_prefix"ztee_config.sh"
source $config_prefix"zgrab_config.sh"
source $config_prefix"paths_config.sh"

# Which network block to scan
block="0.0.0.0/3"
block_code="block1"

# Path where all results of current scan(s) will go
mkdir -p $out_prefix


# ====== TLS ========

# Where to save tls results
mkdir -p $path_tls

# log file for tls scan(s)
log_tls=$path_tls"log_tls.txt"
touch $log_tls

# To which scan block do the results correspond
path_tls_block=$path_tls""$block_code"/"
mkdir -p $path_tls_block

# for tcp output
out_tcp=$path_tls_block"out_tcp/"
mkdir -p $out_tcp

# for tls output
out_tls=$path_tls_block"out_tls/"
mkdir -p $out_tls

echo "TLS "$block" started at: "`date -u` >> $log_tls

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p $target_port -r $scan_rate --sender-threads=$send_threads -c $tcp_cooloff -b $path_blacklist --output-module=csv -f $out_fields  -m $out_tcp"meta.log" $block 2>$out_tcp"err.log" | taskset -c $cores_ztee $path_zmap""ztee $out_tcp"out.log" -u $path_tls_block"ztee_monitor.csv" --success-only | taskset -c $cores_zgrab $path_zgrab""zgrab --interface $interface --log-file $out_tls"err.log" --metadata-file $out_tls"meta.log" --output-file=$out_tls"out.log" --timeout=$zgrab_timeout --senders $zgrab_senders --tls --port $target_port --gomaxprocs $zgrab_cpu

echo "TLS "$block" finished at: "`date -u` >> $log_tls
