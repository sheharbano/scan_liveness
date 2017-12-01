import json
import os
import datetime

#FIXME
file_prefix='/home/bano/my_media/nemesis/vertical/06-09-2017/ntp/'

folder_proc='proc/meta/'
cmd='mkdir -p %s' %(file_prefix+folder_proc)
os.system(cmd)

file_output=file_prefix+folder_proc+"udp.meta"
fOut = open(file_output, 'w')

# ======== ZMAP (UDP) =========
fOut.write("ZMAP (UDP)\n")

blocks=["block1","block2","block3","block4","block5","block6","block7"]

for block in blocks:
	file_udp=file_prefix+block+'/out_udp/meta.log'
	with open(file_udp) as data_file:
	    udp = json.load(data_file)
	
	fOut.write(block+"\n")
	fOut.write("Hitrate\t%0.2f%%\n" % (udp["hitrate"]))
	if udp["pcap_drop"]==0 and udp["pcap_ifdrop"]==0 and udp["send_to_failures"]==0:
		fOut.write("Drops\tnil\n");
	else:
		fOut.write("Drops\tpcap:%s;interface:%s;sendToFailures:%s\n" %(udp["pcap_drop"],udp["pcap_ifdrop"],udp["send_to_failures"]))
	
	# test 2016-08-06T11:59:39-0600
	# Note %z doesn't work in strptime, so manually adjust -0600 part
	udpStart = datetime.datetime.strptime(udp["send_start_time"], "%Y-%m-%dT%H:%M:%S+0100")
	udpEnd = datetime.datetime.strptime(udp["recv_end_time"], "%Y-%m-%dT%H:%M:%S+0100")
	udpDuration = udpEnd - udpStart
	# full diff can be in days and seconds, as I don't currently anticipatea a delta which is over a day large, so I'll just stick to seconds 
	fOut.write("Duration\t%d days %d seconds\n" %(udpDuration.days,udpDuration.seconds))
	
	fOut.write("\n=====\n\n")

fOut.close()
