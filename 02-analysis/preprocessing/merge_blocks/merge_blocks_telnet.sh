folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/telnet/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/telnet/"

path_out_telnet=$folder_out"out_telnet/"
path_out_tcp=$folder_out"out_tcp/"

mkdir -p $path_out_telnet
mkdir -p $path_out_tcp

file_tcp=$path_out_tcp"out.log"
file_telnet=$path_out_telnet"out.log"

> $file_tcp
> $file_telnet

log_tcp=$path_out_tcp"log_merge_blocks.log"
log_telnet=$path_out_telnet"log_merge_blocks.log"

> $log_tcp
> $log_telnet

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_tcp=$folder_in""$block"/out_tcp/out.log"
	cat $file_in_tcp >> $file_tcp
	echo "Done tcp "$block >> $log_tcp
	# comment out if you want to keep per block out data
	#rm $file_in_tcp
	file_in_telnet=$folder_in""$block"/out_telnet/out.log"
	cat $file_in_telnet >> $file_telnet
	echo "Done telnet "$block >> $log_telnet
	# comment out if you want to keep per block out data
        #rm $file_in_telnet
done 

