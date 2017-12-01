import json
import datetime
import os

#FIXME
file_prefix='/home/bano/my_media/nemesis/vertical/07-09-2017/http/'

folder_proc='proc/meta/'
cmd='mkdir -p %s' %(file_prefix+folder_proc)
os.system(cmd)

file_output=file_prefix+folder_proc+"http.meta"
fOut = open(file_output, 'w')

blocks=["block1","block2","block3","block4","block5","block6","block7"]

fOut.write("ZGRAB\n")

# ======== ZMAP (TCP) =========
for block in blocks:
	file_tcp=file_prefix+block+'/out_tcp/meta.log'
	file_http=file_prefix+block+'/out_http/meta.log'
	with open(file_tcp) as data_file:
	    tcp = json.load(data_file)
	
	# ======== ZGRAB (HTTP) =========
	fOut.write(block+"\n")
	with open(file_http) as data_file:
	    http = json.load(data_file)
	
	if tcp["success_unique"]-http["total"]==0:
		fOut.write("Unsent\tnil\n")
	else:
		fOut.write("Unsent\t%d\n" %(tcp["success_unique"]-http["total"]))
	fOut.write("200OK\t%0.2f%%\n" %(float(http["success_count"])/float(http["total"])*100))
	fOut.write("Other\t%0.2f%%\n" %(float(http["failure_count"])/float(http["total"])*100))
	fOut.write("Duration\t%d seconds\n" %(http["duration"]))
	fOut.write("\n=====\n\n")

fOut.close()
