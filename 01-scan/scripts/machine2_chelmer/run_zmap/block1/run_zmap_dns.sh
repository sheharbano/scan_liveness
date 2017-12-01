#!/bin/bash
config_prefix="/usr/share/scan_config/dns/"

source $config_prefix"zmap_config.sh"
source $config_prefix"paths_config.sh"

# Which network block to scan
block="0.0.0.0/3"
block_code="block1"

# Path where all results of current scan(s) will go
mkdir -p $out_prefix

# Where is zgrab
path_zgrab=$path_home"go_work/src/github.com/zmap/zgrab/"

# ====== DNS ========

# Where to save dns results
mkdir -p $path_dns

# log file for dns scan(s)
log_dns=$path_dns"log_dns.txt"
touch $log_dns

# To which scan block do the results correspond
# FIXME: WHICH BLOCK? IN MOST SCANS, THIS IS THE ONLY PART THAT NEEDS TO BE FIXED
path_dns_block=$path_dns""$block_code"/"
mkdir -p $path_dns_block

# for udp output
out_udp=$path_dns_block"out_udp/"
mkdir -p $out_udp

echo "DNS "$block" started at: "`date -u` >> $log_dns

taskset -c $cores_zmap $path_zmap""zmap -e $seed -i $interface -G $gateway -S $src_ip -p $target_port -r $scan_rate --sender-threads=$send_threads -c $udp_cooloff -b $path_blacklist --output-module=json -f $out_fields  --probe-module=dns --probe-args="A,google.com" -m $out_udp"meta.log" $block 2>$out_udp"err.log" >$out_udp"out.log"  

echo "DNS "$block" finished at: "`date -u` >> $log_dns
