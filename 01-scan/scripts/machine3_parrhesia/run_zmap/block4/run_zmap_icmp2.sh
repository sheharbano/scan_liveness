#!/bin/bash
config_prefix="/usr/share/scan_config/icmp/second/"

source $config_prefix"zmap_config.sh"
source $config_prefix"paths_config.sh"

# Which network block to scan
block="96.0.0.0/3"
block_code="block4"

# Path where all results of current scan(s) will go
mkdir -p $out_prefix

# ====== ICMP ========

# Where to save icmp results
mkdir -p $path_icmp

# log file for icmp scan(s)
log_icmp=$path_icmp"log_icmp.txt"
touch $log_icmp

# To which scan block do the results correspond
path_icmp_block=$path_icmp""$block_code"/"
mkdir -p $path_icmp_block

out_icmp=$path_icmp_block

echo "ICMP "$block" started at: "`date -u` >> $log_icmp

taskset $cores_zmap $path_zmap""zmap -i $interface -G $gateway  -S $src_ip --probe-module=icmp_echoscan -r $scan_rate --sender-threads=1 -c $icmp_cooloff -b $path_blacklist -e $seed --output-module=csv  -f $out_fields -m $out_icmp"meta.log" $block  2>$out_icmp"err.log" > $out_icmp"out.log"

echo "ICMP "$block" finished at: "`date -u` >> $log_icmp
