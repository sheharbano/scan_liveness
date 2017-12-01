#!/bin/bash

config_prefix="/usr/share/scan_config/telnet/"

source $config_prefix"tcp_tuning_config.sh"
source $config_prefix"zmap_config.sh"
source $config_prefix"ztee_config.sh"
source $config_prefix"zgrab_config.sh"
source $config_prefix"paths_config.sh"

# Which network block to scan
block="96.0.0.0/3"
block_code="block4"

# Path where all results of current scan(s) will go
mkdir -p $out_prefix


# ====== Telnet ========

# Where to save telnet results
mkdir -p $path_telnet

# log file for telnet scan(s)
log_telnet=$path_telnet"log_telnet.txt"
touch $log_telnet

# To which scan block do the results correspond
path_telnet_block=$path_telnet""$block_code"/"
mkdir -p $path_telnet_block

# for tcp output
out_tcp=$path_telnet_block"out_tcp/"
mkdir -p $out_tcp

# for telnet output
out_telnet=$path_telnet_block"out_telnet/"
mkdir -p $out_telnet

echo "Telnet "$block" started at: "`date -u` >> $log_telnet

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p $target_port -r $scan_rate --sender-threads=$send_threads -c $tcp_cooloff -b $path_blacklist --output-module=csv -f $out_fields  -m $out_tcp"meta.log" $block  2>$out_tcp"err.log" | taskset -c $cores_ztee $path_zmap""ztee $out_tcp"out.log" -u $path_telnet_block"ztee_monitor.csv" --success-only | taskset -c $cores_zgrab $path_zgrab""zgrab --interface $interface --log-file $out_telnet"err.log" --metadata-file $out_telnet"meta.log" --output-file=$out_telnet"out.log" --timeout=$zgrab_timeout --senders $zgrab_senders --telnet --port $target_port --gomaxprocs $zgrab_cpu

echo "Telnet "$block" finished at: "`date -u` >> $log_telnet
