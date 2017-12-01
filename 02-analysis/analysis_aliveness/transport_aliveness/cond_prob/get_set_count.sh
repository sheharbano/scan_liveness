folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"
out_prefix=$folder_prefix"analysis/nw_aliveness/cond_prob_byProto/"

mkdir -p $out_prefix

out_file=$out_prefix"sets.count"
>$out_file

log_file=$out_prefix"sets.count.log"
>$log_file

echo "Started at: "`date` >>$log_file
# FIXME this will cut first 8 characters from file name
find $out_prefix -name '*.set' | while read line; do name=`echo $line | awk -F"/" '{print $NF}' | cut -c 1-8` >>$out_file; count=`rwsetcat $line | wc -l`; echo $name" "$count  >>$out_file; done
echo "Finished at: "`date` >>$log_file
