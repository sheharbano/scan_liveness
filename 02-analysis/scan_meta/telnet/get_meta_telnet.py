import json
import datetime
import os

#FIXME
file_prefix='/home/bano/my_media/nemesis/vertical/07-09-2017/telnet/'

folder_proc='proc/meta/'
cmd='mkdir -p %s' %(file_prefix+folder_proc)
os.system(cmd)

file_output=file_prefix+folder_proc+"telnet.meta"
fOut = open(file_output, 'w')

blocks=["block1","block2","block3","block4","block5","block6","block7"]

fOut.write("ZGRAB\n")

# ======== ZMAP (TCP) =========
for block in blocks:
	file_tcp=file_prefix+block+'/out_tcp/meta.log'
	file_telnet=file_prefix+block+'/out_telnet/meta.log'
	with open(file_tcp) as data_file:
	    tcp = json.load(data_file)
	
	# ======== ZGRAB (Telnet) =========
	fOut.write(block+"\n")
	with open(file_telnet) as data_file:
	    telnet = json.load(data_file)
	
	if tcp["success_unique"]-telnet["total"]==0:
		fOut.write("Unsent\tnil\n")
	else:
		fOut.write("Unsent\t%d\n" %(tcp["success_unique"]-telnet["total"]))
	fOut.write("200OK\t%0.2f%%\n" %(float(telnet["success_count"])/float(telnet["total"])*100))
	fOut.write("Other\t%0.2f%%\n" %(float(telnet["failure_count"])/float(telnet["total"])*100))
	fOut.write("Duration\t%d seconds\n" %(telnet["duration"]))
	fOut.write("\n=====\n\n")

fOut.close()
