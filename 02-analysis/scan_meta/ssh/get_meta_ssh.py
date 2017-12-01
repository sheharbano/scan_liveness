import json
import datetime
import os

#FIXME
file_prefix='/home/bano/my_media/nemesis/vertical/07-09-2017/ssh/'

folder_proc='proc/meta/'
cmd='mkdir -p %s' %(file_prefix+folder_proc)
os.system(cmd)

file_output=file_prefix+folder_proc+"ssh.meta"
fOut = open(file_output, 'w')

blocks=["block1","block2","block3","block4","block5","block6","block7"]

fOut.write("ZGRAB\n")

# ======== ZMAP (TCP) =========
for block in blocks:
	file_tcp=file_prefix+block+'/out_tcp/meta.log'
	file_ssh=file_prefix+block+'/out_ssh/meta.log'
	with open(file_tcp) as data_file:
	    tcp = json.load(data_file)
	
	# ======== ZGRAB (SSH) =========
	
	fOut.write(block+"\n")
	with open(file_ssh) as data_file:
	    ssh = json.load(data_file)
	
	if tcp["success_unique"]-ssh["total"]==0:
		fOut.write("Unsent\tnil\n")
	else:
		fOut.write("Unsent\t%d\n" %(tcp["success_unique"]-ssh["total"]))
	fOut.write("Success\t%0.2f%%\n" %(float(ssh["success_count"])/float(ssh["total"])*100))
	fOut.write("Failures\t%0.2f%%\n" %(float(ssh["failure_count"])/float(ssh["total"])*100))
	fOut.write("Duration\t%d seconds\n" %(ssh["duration"]))
	fOut.write("\n=====\n\n")	
fOut.close()
