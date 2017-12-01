folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/http/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/http/"

path_out_http=$folder_out"out_http/"
path_out_tcp=$folder_out"out_tcp/"

mkdir -p $path_out_http
mkdir -p $path_out_tcp

file_tcp=$path_out_tcp"out.log"
file_http=$path_out_http"out.log"

> $file_tcp
> $file_http

log_tcp=$path_out_tcp"log_merge_blocks.log"
log_http=$path_out_http"log_merge_blocks.log"

> $log_tcp
> $log_http

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_tcp=$folder_in""$block"/out_tcp/out.log"
	cat $file_in_tcp >> $file_tcp
	echo "Done tcp "$block >> $log_tcp
	# comment out if you want to keep per block out data
	#rm $file_in_tcp
	file_in_http=$folder_in""$block"/out_http/out.log"
	cat $file_in_http >> $file_http
	echo "Done http "$block >> $log_http
	# comment out if you want to keep per block out data
        #rm $file_in_http
done 

