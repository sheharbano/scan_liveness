# Output
# Ok means that there's a telnet response (I look for banner)
# notOk when there is no telnet message
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
# ok,error-normal: error in normal telnet body, i still treat it as ok as it's still a valid telnet response 
# ok,except: json parser threw exception, but still valid telnet response that can be parsed with regex 
#
# error, normal: 
# error, unknown:
# error, except-unknown: 
# ===================
# I got repeated application layer probes here, I deal with it as follows. In summary, successful takes priority
#
# if successful:
#       if previous unsuccessful response:
#               undo unsuccessful entry
#       if not previous successful entry:
#               enter successful
#if unsuccessful:
#       if not previous successful entry and not previous unsuccessful entry:
#               enter unsuccessful

import json
import datetime
import re
import os
import subprocess
import operator

# FIXME
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/telnet/"
#folder_prefix="/home/bano/scripts/preprocessing/parse_application/telnet/"

out_prefix=folder_prefix+"proc/flat/"
cmd='mkdir -p %s' %(out_prefix)
os.system(cmd)

file_input=folder_prefix+"out_telnet/out.log"
file_output=out_prefix+"telnet.flat"
file_output_stats=out_prefix+"telnet.flat.stats"
file_log=out_prefix+"telnet.flat.log"

fOut = open(file_output, 'w')
fLog = open(file_log, 'w')

nOk=0
nNotOk=0
total=0
dStatusCodes={}
dErrors={}
# Keeps track of IPs that have responded before
dSeen_ok={}
dSeen_notok={}

fLog.write("Started at: "+str(datetime.datetime.now())+"\n")

def getErrorString(error_msg):
    if 'getsockopt' in error_msg:
        words=error_msg.split("getsockopt")
        n=len(words)
        return "getsockopt"+words[n-1].strip()
    elif 'read tcp' in error_msg and 'i/o timeout' in error_msg:
	return "read tcp: i/o timeout"
    elif 'dial tcp' in error_msg and 'i/o timeout' in error_msg:
        return "dial tcp: i/o timeout"
    elif 'EOF' in error_msg:
	return "EOF badness"
    elif 'malformed' in error_msg:
	return 'malformed response'
    elif 'Unsupported telnet IAC option' in error_msg:
	return 'Unsupported telnet IAC option'
    elif 'read: connection reset by peer' in error_msg:
	return 'read: connection reset by peer'
    else:
	return 'other'

def updateStatusStats(field_IP,status):
        global nOk
        global nNotOk
        global dStatusCodes
        global dErrors
        global dSeen_ok
        global dSeen_notok

        # if previous unsuccessful response, undo unsuccessful entry
        if field_IP in dSeen_notok:
                if dSeen_notok[field_IP] in dErrors and dErrors[dSeen_notok[field_IP]] > 0:
                        dErrors[dSeen_notok[field_IP]]-=1
                        if dErrors[dSeen_notok[field_IP]] == 0:
                                del dErrors[dSeen_notok[field_IP]]
                nNotOk-=1
                del dSeen_notok[field_IP]
        # if not previous successful entry, enter successful                
        if not field_IP in dSeen_ok:
                nOk+=1
                if not(status in dStatusCodes):
                        dStatusCodes[status]=0
                dStatusCodes[status]+=1
                dSeen_ok[field_IP]=status


def updateErrStats(field_IP,errType):
        global nOk
        global nNotOk
        global dStatusCodes
        global dErrors
        global dSeen_ok
        global dSeen_notok
        # if not previous successful entry and not previous unsuccessful entry, enter unsuccessful
        if not field_IP in dSeen_ok and not field_IP in dSeen_notok:
                nNotOk+=1
                if not(errType in dErrors):
                        dErrors[errType]=0
                dErrors[errType]+=1
                dSeen_notok[field_IP]=errType

for line in open(file_input, 'r'):

	#total+=1

	try:
		field_label="ok"
        	field_subLabel="-"
        	field_IP="-"
        	field_err="-"
		field_statusCode="dummy"

		line=line.strip()
		telnet = json.loads(line)

		field_IP=str(telnet["ip"])
		

		if ('banner' in telnet["data"]["telnet"] and len(telnet["data"]["telnet"]["banner"])>0) or ('will' in telnet["data"]["telnet"] and len(telnet["data"]["telnet"]["will"])>0) or ('do' in telnet["data"]["telnet"] and len(telnet["data"]["telnet"]["do"])>0):
                        # Update fields
                        field_IP=str(telnet["ip"])

                        # Update stats
			updateStatusStats(field_IP,field_statusCode)

		elif 'error' in telnet:
                        # Update fields 
                        field_label="error"
                        field_subLabel="normal"
                        field_err=str(telnet["error"])

                        # Check if it's Missing Location response
                        error_msg=str(telnet["error"])
                        
			# Update err stats
                        errType=getErrorString(error_msg)
			updateErrStats(field_IP,errType)

		else:
			# Update fields
                        field_subLabel="unknown"
			field_err=str(line)
			
			# Update err stats
			errType=getErrorString(field_err)
                        updateErrStats(field_IP,errType)

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_IP+"\t"+field_err+"\n")

	except Exception as e:
		field_label="error"
                field_subLabel="-"
		field_IP="-"
                field_err="-"
		field_statusCode="dummy"

		line=line.decode('unicode_escape').encode('ascii','ignore')
		
		mIP = re.search("\"ip\":\"(\d\d?\d?\.\d\d?\d?\.\d\d?\d?\.\d\d?\d?)", line)
		if mIP:
			field_IP = mIP.group(1)

              
		error_msg=""
                mError = re.search("\"error\":(.+)\"", line)
                if mError:
			# Update fields
			field_subLabel="except"
                        field_err=mError.group(1)
			# Update err stats
			error_msg=mError.group(1)
		else:
			# Update fields
			field_subLabel="except-unknown"
			field_err=str(e)+";"+line[0:500]
			# Update err stats
			error_msg=field_err

		# Update err stats
		errType=getErrorString(error_msg)
                updateErrStats(field_IP,errType)

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
		
		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_IP+"\t"+field_err+"\n")

fOut.close()
#
# Now produce stats
total=nOk+nNotOk
fOutStats = open(file_output_stats, 'w')
telnetResponse=float(nOk)/total*100
nonTelnetResponse=float(nNotOk)/total*100

fOutStats.write("Total\t%d\ttelnetResponse\t%.2f\n" %(total,telnetResponse))
sorted_dStatusCodes = sorted(dStatusCodes.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dStatusCodes:
	pct=float(each[1])/nOk*100
	fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.write("\nTotal\t%d\tnonTelnetResponse\t%.2f\n" %(total,nonTelnetResponse))
sorted_dErrors = sorted(dErrors.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dErrors:
        pct=float(each[1])/nNotOk*100
        fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.close()

fLog.write("Finished at: "+str(datetime.datetime.now())+"\n")
fLog.close()

