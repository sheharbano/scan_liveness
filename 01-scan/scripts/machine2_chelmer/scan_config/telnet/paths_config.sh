# Home directory
path_home="/home/bano/"

# Path where all results of current scan(s) will go
#date="$(date --utc +%d-%m-%Y)"
date="07-09-2017"
out_prefix=$path_home"my_media/nemesis/vertical/"$date"/"

# Where is zgrab
path_zgrab=$path_home"go_work/src/github.com/zmap/zgrab/"

# where is zmap
path_zmap=$path_home"zmap_vanilla/zmap-2.1.0-telnet/src/"

# Where to save telnet results
path_telnet=$out_prefix"telnet/"
