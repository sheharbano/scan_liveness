folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/cwmp/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/cwmp/"

path_out_cwmp=$folder_out"out_cwmp/"
path_out_tcp=$folder_out"out_tcp/"

mkdir -p $path_out_cwmp
mkdir -p $path_out_tcp

file_tcp=$path_out_tcp"out.log"
file_cwmp=$path_out_cwmp"out.log"

> $file_tcp
> $file_cwmp

log_tcp=$path_out_tcp"log_merge_blocks.log"
log_cwmp=$path_out_cwmp"log_merge_blocks.log"

> $log_tcp
> $log_cwmp

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_tcp=$folder_in""$block"/out_tcp/out.log"
	cat $file_in_tcp >> $file_tcp
	echo "Done tcp "$block >> $log_tcp
	# comment out if you want to keep per block out data
	#rm $file_in_tcp
	file_in_cwmp=$folder_in""$block"/out_cwmp/out.log"
	cat $file_in_cwmp >> $file_cwmp
	echo "Done cwmp "$block >> $log_cwmp
	# comment out if you want to keep per block out data
        #rm $file_in_cwmp
done 

