# Output
# Ok means that there's a ntp response (I look for banner)
# notOk when there is no ntp message
#
#if $1=="ok"
#
#	$2: error-normal,except
#	$3: IP
#	$4: -
#
#elif $1=="error"
# 	$2: normal,unknown,except-unknown
# 	$3: -
#	$4: error description #full line when error-unknown
# ===================
# ok,error-normal: error in normal ntp body, i still treat it as ok as it's still a valid ntp response 
# ok,except: json parser threw exception, but still valid ntp response that can be parsed with regex 
#
# error, normal: 
# error, unknown:
# error, except-unknown: 
# ===================

import json
import datetime
import re
import os
import subprocess
import operator

# FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/ntp/"
#folder_prefix="/home/bano/scripts/preprocessing/parse_application/ntp/"

out_prefix=folder_prefix+"proc/flat/"
cmd='mkdir -p %s' %(out_prefix)
os.system(cmd)

file_input=folder_prefix+"out_udp/out.log"
file_output=out_prefix+"ntp.flat"
file_log=out_prefix+"ntp.flat.log"

fOut = open(file_output, 'w')
fLog = open(file_log, 'w')

fLog.write("Started at: "+str(datetime.datetime.now())+"\n")

for line in open(file_input, 'r'):

	try:
		field_label="ok"
        	field_subLabel="-"
        	field_classification="-"	
		field_IP="-"
		field_ts="-"
		field_ipid="-"
		field_ttl="-"
		field_icmpType="-"
		field_icmpCode="-"
		field_icmpInnerDaddr="-"
		field_ntp_LI_VN_MODE="-"
		field_ntp_poll="-"
		field_ntp_stratum="-"
		field_err="-"

		line=line.strip()
		ntp = json.loads(line)

                field_IP=str(ntp["saddr"])
                field_ipid=str(ntp["ipid"])
                field_ttl=str(ntp["ttl"])
		field_ts=str(ntp["icmp_unreach_str"])
                field_err="-"

		if ('classification' in ntp):
                        # Update fields
			field_classification=str(ntp["classification"])

			if field_classification.strip() == "ntp":
				if str(ntp["success"])=="True":
                        		field_ntp_LI_VN_MODE=str(ntp["LI_VN_MODE"])
					field_ntp_LI_VN_MODE=str(ntp["stratum"])
					field_ntp_LI_VN_MODE=str(ntp["poll"])
				else:
					field_label="error"
					field_subLabel="normal"
			else:
                        	# Update fields 
                        	field_label="error"
                        	field_subLabel="normal"
                        	field_classification=str(ntp["classification"])
				field_icmpType=str(ntp["icmp_type"])
                		field_icmpCode=str(ntp["icmp_code"])
                		field_icmpInnerDaddr=str(ntp["icmp_responder"])			
	
		else:
			# Update fields
			field_label="error"
                        field_subLabel="unknown"
			field_err=str(line)
			
       		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_classification+"\t"+"\t"+field_IP+"\t"+field_ts+"\t"+field_ipid+"\t"+field_ttl+"\t"+field_icmpType+"\t"+field_icmpCode+"\t"+field_icmpInnerDaddr+"\t"+field_ntp_LI_VN_MODE+"\t"+field_ntp_stratum+"\t"+field_ntp_poll+"\t"+field_err+"\n")

	except Exception as e:
		field_label="error"
                field_classification="-"
                field_IP="-"
                field_ipid="-"
                field_ttl="-"
                field_icmpType="-"
                field_icmpCode="-"
                field_icmpInnerDaddr="-"
                field_ntp_LI_VN_MODE="-"
                field_err="-"

		line=line.decode('unicode_escape').encode('ascii','ignore')
		
		mIP = re.search("\"ip\":\"(\d\d?\d?\.\d\d?\d?\.\d\d?\d?\.\d\d?\d?)", line)
		if mIP:
			field_IP = mIP.group(1)

              
		error_msg=""

		# Update fields
		field_subLabel="except-unknown"
		field_err=str(e)+";"+line[0:500]

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_classification+"\t"+"\t"+field_IP+"\t"+field_ts+"\t"+field_ipid+"\t"+field_ttl+"\t"+field_icmpType+"\t"+field_icmpCode+"\t"+field_icmpInnerDaddr+"\t"+field_ntp_LI_VN_MODE+"\t"+field_ntp_stratum+"\t"+field_ntp_poll+"\t"+field_err+"\n")		


fOut.close()

fLog.write("Finished at: "+str(datetime.datetime.now())+"\n")
fLog.close()
