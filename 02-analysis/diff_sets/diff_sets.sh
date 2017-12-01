# From all *.set files in the target_folder, diff file_to_diff  
# output files have the same name as the original, except that
# they are output to a separate folder out_folder

#FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/05-09-2017/"
file_to_diff="/home/bano/my_media/nemesis/vertical/07-09-2017/blacklist_07Sep17.set"

# ====== HTTP ======

target_folder=$folder_prefix"http/out_tcp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder 

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done
   
# ====== SSH ======

target_folder=$folder_prefix"ssh/out_tcp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder 

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done

# ====== TLS ======

target_folder=$folder_prefix"tls/out_tcp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done



# ====== CWMP ======

target_folder=$folder_prefix"cwmp/out_tcp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done


# ====== Telnet ======

target_folder=$folder_prefix"telnet/out_tcp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done

# ====== DNS ======

target_folder=$folder_prefix"dns/out_udp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done


# ====== NTP ======

target_folder=$folder_prefix"ntp/out_udp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done


# ====== ICMP ======

target_folder=$folder_prefix"icmp/out_icmp/"

out_folder=$target_folder"diff_sets/"

mkdir -p $out_folder

# Write file_to_diff to out_folder
echo $file_to_diff > $out_folder"file_to_diff.txt"

find $target_folder -name "*.set" | while read line; do filename=`echo $line`; target_file=$filename; out_file=$out_folder`echo $filename | awk -F"/" '{print $NF}'`; rwsettool --difference $target_file $file_to_diff --output-path $out_file; done
