#!/bin/bash

config_prefix="/usr/share/scan_config/ssh/"

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


# ====== SSH ========

# Where to save ssh results
mkdir -p $path_ssh

# log file for ssh scan(s)
log_ssh=$path_ssh"log_ssh.txt"
touch $log_ssh

# To which scan block do the results correspond
path_ssh_block=$path_ssh""$block_code"/"
mkdir -p $path_ssh_block

# Wheres is ssh related config data
path_ssh_scan_config=$path_scan_config"name_config_ssh.txt"

# for tcp output
out_tcp=$path_ssh_block"out_tcp/"
mkdir -p $out_tcp

# for ssh output
out_ssh=$path_ssh_block"out_ssh/"
mkdir -p $out_ssh

echo "SSH "$block" started at: "`date -u` >> $log_ssh

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p  $target_port -r $scan_rate --sender-threads=$send_threads -c $tcp_cooloff -b $path_blacklist --output-module=csv -f $out_fields  -m $out_tcp"meta.log" $block 2>$out_tcp"err.log" | taskset -c $cores_ztee $path_zmap""ztee $out_tcp"out.log" -u $path_ssh_block"ztee_monitor.csv" --success-only | taskset -c $cores_zgrab $path_zgrab""zgrab --interface $interface --log-file $out_ssh"err.log" --metadata-file $out_ssh"meta.log" --output-file=$out_ssh"out.log" --timeout=$zgrab_timeout --senders $zgrab_senders --ssh --port $target_port --gomaxprocs $zgrab_cpu

echo "SSH "$block" finished at: "`date -u` >> $log_ssh
