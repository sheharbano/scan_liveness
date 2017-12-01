# Home directory
path_home="/home/parrhesia/"

# Path where all results of current scan(s) will go
#date="$(date --utc +%d-%m-%Y)"
date="07-09-2017"
out_prefix=$path_home"my_media/nemesis/vertical/"$date"/"
mkdir -p $out_prefix

# where is zmap
path_zmap=$path_home"zmap_vanilla/zmap-2.1.0-first/src/"

# Where to save icmp results
path_icmp=$out_prefix"icmp/first/"

