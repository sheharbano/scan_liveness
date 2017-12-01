# Note: Tune to ICMP

import json
import os
import datetime

#FIXME
file_prefix='/home/bano/my_media/nemesis/vertical/07-09-2017/icmp/first/'

folder_proc='proc/meta/'
cmd='mkdir -p %s' %(file_prefix+folder_proc)
os.system(cmd)

file_output=file_prefix+folder_proc+"icmp.meta"
fOut = open(file_output, 'w')

fOut.write("ZMAP (ICMP) first\n")

blocks=["block1","block2","block3","block4","block5","block6","block7"]

# ======== ZMAP (ICMP) first =========
for block in blocks:
	file_icmp1=file_prefix+block+'/meta.log'
	with open(file_icmp1) as data_file:
	    icmp = json.load(data_file)
	
	fOut.write("Hitrate\t%0.2f%%\n" % (icmp["hitrate"]))
	if icmp["pcap_drop"]==0 and icmp["pcap_ifdrop"]==0 and icmp["send_to_failures"]==0:
	        fOut.write("Drops\tnil\n");
	else:
	        fOut.write("Drops\tpcap:%s;interface:%s;sendToFailures:%s\n" %(icmp["pcap_drop"],icmp["pcap_ifdrop"],icmp["send_to_failures"]))
	
	# test 2016-08-06T11:59:39-0600
	# Note %z doesn't work in strptime, so manually adjust -0600 part
	icmpStart = datetime.datetime.strptime(icmp["send_start_time"], "%Y-%m-%dT%H:%M:%S+0100")
	icmpEnd = datetime.datetime.strptime(icmp["recv_end_time"], "%Y-%m-%dT%H:%M:%S+0100")
	icmpDuration = icmpEnd - icmpStart
	# full diff can be in days and seconds, as I don't currently anticipatea a delta which is over a day large, so I'll just stick to seconds 
	fOut.write("Duration\t%d days %d seconds\n" %(icmpDuration.days,icmpDuration.seconds))
	
	fOut.write("\n=====\n\n")

fOut.close()
