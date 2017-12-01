folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/dns/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/dns/"

path_out_udp=$folder_out"out_udp/"

mkdir -p $path_out_udp

file_udp=$path_out_udp"out.log"

> $file_udp

log_udp=$path_out_udp"log_merge_blocks.log"

> $log_udp

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_udp=$folder_in""$block"/out_udp/out.log"
	cat $file_in_udp >> $file_udp
	echo "Done udp "$block >> $log_udp
	# comment out if you want to keep per block out data
	#rm $file_in_udp
done 

