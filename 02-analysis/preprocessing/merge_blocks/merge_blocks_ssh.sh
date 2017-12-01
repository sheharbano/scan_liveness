folder_in="/home/bano/my_media/nemesis/vertical/07-09-2017/ssh/"
folder_out="/home/bano/my_media/nemesis/vertical/07-09-2017/ssh/"

path_out_ssh=$folder_out"out_ssh/"
path_out_tcp=$folder_out"out_tcp/"

mkdir -p $path_out_ssh
mkdir -p $path_out_tcp

file_tcp=$path_out_tcp"out.log"
file_ssh=$path_out_ssh"out.log"

> $file_tcp
> $file_ssh

log_tcp=$path_out_tcp"log_merge_blocks.log"
log_ssh=$path_out_ssh"log_merge_blocks.log"

> $log_tcp
> $log_ssh

for block in "block1" "block2" "block3" "block4" "block5" "block6" "block7"; do
        file_in_tcp=$folder_in""$block"/out_tcp/out.log"
	cat $file_in_tcp >> $file_tcp
	echo "Done tcp "$block >> $log_tcp
	# comment out if you want to keep per block out data
	#rm $file_in_tcp
	file_in_ssh=$folder_in""$block"/out_ssh/out.log"
	cat $file_in_ssh >> $file_ssh
	echo "Done ssh "$block >> $log_ssh
	# comment out if you want to keep per block out data
        #rm $file_in_ssh
done 

