import json
import os
import datetime

#FIXME
file_prefix='/home/bano/my_media/nemesis/vertical/07-09-2017/http/'

folder_proc='proc/meta/'
cmd='mkdir -p %s' %(file_prefix+folder_proc)
os.system(cmd)

file_output=file_prefix+folder_proc+"tcp.meta"
fOut = open(file_output, 'w')

# ======== ZMAP (TCP) =========
fOut.write("ZMAP (TCP)\n")

blocks=["block1","block2","block3","block4","block5","block6","block7"]

for block in blocks:
	file_tcp=file_prefix+block+'/out_tcp/meta.log'
	with open(file_tcp) as data_file:
	    tcp = json.load(data_file)
	
	fOut.write(block+"\n")
	fOut.write("Hitrate\t%0.2f%%\n" % (tcp["hitrate"]))
	if tcp["pcap_drop"]==0 and tcp["pcap_ifdrop"]==0 and tcp["send_to_failures"]==0:
		fOut.write("Drops\tnil\n");
	else:
		fOut.write("Drops\tpcap:%s;interface:%s;sendToFailures:%s\n" %(tcp["pcap_drop"],tcp["pcap_ifdrop"],tcp["send_to_failures"]))
	
	# test 2016-08-06T11:59:39-0600
	# Note %z doesn't work in strptime, so manually adjust -0600 part
	tcpStart = datetime.datetime.strptime(tcp["send_start_time"], "%Y-%m-%dT%H:%M:%S+0100")
	tcpEnd = datetime.datetime.strptime(tcp["recv_end_time"], "%Y-%m-%dT%H:%M:%S+0100")
	tcpDuration = tcpEnd - tcpStart
	# full diff can be in days and seconds, as I don't currently anticipatea a delta which is over a day large, so I'll just stick to seconds 
	fOut.write("Duration\t%d days %d seconds\n" %(tcpDuration.days,tcpDuration.seconds))
	
	fOut.write("\n=====\n\n")

fOut.close()
