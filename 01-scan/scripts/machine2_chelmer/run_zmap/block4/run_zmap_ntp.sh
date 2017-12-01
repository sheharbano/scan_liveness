#!/bin/bash

config_prefix="/usr/share/scan_config/ntp/"

source $config_prefix"zmap_config.sh"
source $config_prefix"paths_config.sh"

# Which network block to scan
block="96.0.0.0/3"
block_code="block4"

# Path where all results of current scan(s) will go
mkdir -p $out_prefix

# ====== NTP ========

# Where to save ntp results
mkdir -p $path_ntp

# log file for ntp scan(s)
log_ntp=$path_ntp"log_ntp.txt"
touch $log_ntp

# To which scan block do the results correspond
path_ntp_block=$path_ntp""$block_code"/"
mkdir -p $path_ntp_block

# for udp output
out_udp=$path_ntp_block"out_udp/"
mkdir -p $out_udp

echo "NTP "$block" started at: "`date -u` >> $log_ntp

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p  $target_port -r $scan_rate --sender-threads=$send_threads -c $udp_cooloff -b $path_blacklist  --output-module=json  -f $out_fields  --probe-module=ntp -m $out_udp"meta.log" $block   2>$out_udp"err.log" >$out_udp"out.log"

echo "NTP "$block" finished at: "`date -u` >> $log_ntp
