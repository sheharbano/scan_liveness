folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/tls/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/tls/"

path_out_tls=$folder_out"out_tls/"
path_out_tcp=$folder_out"out_tcp/"

mkdir -p $path_out_tls
mkdir -p $path_out_tcp

file_tcp=$path_out_tcp"out.log"
file_tls=$path_out_tls"out.log"

> $file_tcp
> $file_tls

log_tcp=$path_out_tcp"log_merge_blocks.log"
log_tls=$path_out_tls"log_merge_blocks.log"

> $log_tcp
> $log_tls

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_tcp=$folder_in""$block"/out_tcp/out.log"
	cat $file_in_tcp >> $file_tcp
	echo "Done tcp "$block >> $log_tcp
	# comment out if you want to keep per block out data
	#rm $file_in_tcp
	file_in_tls=$folder_in""$block"/out_tls/out.log"
	cat $file_in_tls >> $file_tls
	echo "Done tls "$block >> $log_tls
	# comment out if you want to keep per block out data
        #rm $file_in_tls
done 

