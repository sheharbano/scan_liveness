#!/bin/bash

config_prefix="/usr/share/scan_config/cwmp/"

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


# ====== CWMP ========

# Where to save cwmp results
mkdir -p $path_cwmp

# log file for cwmp scan(s)
log_cwmp=$path_cwmp"log_cwmp.txt"
touch $log_cwmp

# To which scan block do the results correspond
path_cwmp_block=$path_cwmp""$block_code"/"
mkdir -p $path_cwmp_block

# for tcp output
out_tcp=$path_cwmp_block"out_tcp/"
mkdir -p $out_tcp

# for cwmp output
out_cwmp=$path_cwmp_block"out_cwmp/"
mkdir -p $out_cwmp

echo "CWMP "$block" started at: "`date -u` >> $log_cwmp

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p $target_port -r $scan_rate --sender-threads=$send_threads -c $tcp_cooloff -b $path_blacklist --output-module=csv -f $out_fields  -m $out_tcp"meta.log" $block 2>$out_tcp"err.log" | taskset -c $cores_ztee $path_zmap""ztee $out_tcp"out.log" -u $path_cwmp_block"ztee_monitor.csv" --success-only | taskset -c $cores_zgrab $path_zgrab""zgrab --interface $interface --log-file $out_cwmp"err.log" --metadata-file $out_cwmp"meta.log" --output-file=$out_cwmp"out.log" --timeout=$zgrab_timeout --senders $zgrab_senders --http "/" --port $target_port --gomaxprocs $zgrab_cpu

echo "CWMP "$block" finished at: "`date -u` >> $log_cwmp
