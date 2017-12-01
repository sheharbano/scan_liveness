#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/"

in_file_icmp=$folder_prefix"icmp/out_icmp/diff_sets/out_srcIP.set"

#FIXME
out_folder="/home/bano/my_media/nemesis/vertical/07-09-2017/analysis/nw_aliveness/highLevel/"
mkdir -p $out_folder
out_file=$out_folder"nw_alive_icmp.set"

cp $in_file_icmp $out_file
