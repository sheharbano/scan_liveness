folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/icmp/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/icmp/"

path_out_icmp=$folder_out"out_icmp/"

mkdir -p $path_out_icmp

file_icmp=$path_out_icmp"out.log"

> $file_icmp

log_icmp=$path_out_icmp"log_merge_blocks.log"

> $log_icmp

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_icmp1=$folder_in"first/"$block"/out.log"
	cat $file_in_icmp1 >> $file_icmp
	echo "Done icmp1 "$block >> $log_icmp
	# comment out if you want to keep per block out data
	#rm $file_in_icmp1
	file_in_icmp2=$folder_in"second/"$block"/out.log"
	cat $file_in_icmp2 >> $file_icmp
	echo "Done icmp2 "$block >> $log_icmp
	# comment out if you want to keep per block out data
        #rm $file_in_icmp2
done 

