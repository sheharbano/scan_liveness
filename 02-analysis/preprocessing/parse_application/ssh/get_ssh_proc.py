# nOk if SSH response had a banner
# nNotOk otherwise
# Output
#if $1==ok:
#	$1: ok
# 	$2: -
#	$3: raw_banner
#	$4: IP
#	$5: -
#	$6: -
#
#elif $1==error:
#	$1: error
#	$2: except, except-unknown
#	$3: -
#	$4: IP
#	$5: ssh/banner error msg
#	$6: error description
# ===================
# error, except: when there was an exception, error was presnt in ssh body
# error, except-unknown: when there was an exception, no error description in ssh body
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
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/ssh/"
#folder_prefix="/home/bano/scripts/preprocessing/parse_application/ssh/"

out_prefix=folder_prefix+"proc/flat/"
cmd='mkdir -p %s' %(out_prefix)
os.system(cmd)

file_input=folder_prefix+"out_ssh/out.log"
file_output=out_prefix+"ssh.flat"
file_log=out_prefix+"ssh.flat.log"
file_output_stats=out_prefix+"ssh.flat.stats"

bufsize = 0
fOut = open(file_output, 'w', bufsize)

fLog = open(file_log, 'w')

nOk=0
nNotOk=0
total=0
dErrors={}
dStatus={}
# Keeps track of IPs that have responded before
dSeen_ok={}
dSeen_notok={}

fLog.write("Started at: "+str(datetime.datetime.now())+"\n")

def getErrorString(error_msg):
    if 'SSH protocol version invalid' in error_msg:
        return 'SSH protocol version invalid'
    elif 'read tcp' in error_msg and 'i/o timeout' in error_msg:
        return "read tcp: i/o timeout"
    elif 'dial tcp' in error_msg and 'i/o timeout' in error_msg:
        return "dial tcp: i/o timeout"
    elif 'EOF' in error_msg:
        return "EOF badness"
    elif 'read: connection reset by peer' in error_msg:
        return 'read: connection reset by peer'
    elif 'dial tcp' in error_msg and 'getsockopt: connection refused' in error_msg:
        return 'getsockopt: connection refused'
    elif 'dial tcp' in error_msg and 'getsockopt: no route to host' in error_msg:
        return 'getsockopt: no route to host'
    elif 'dial tcp' in error_msg and 'getsockopt: connection reset by peer' in error_msg:
        return 'getsockopt: connection reset by peer'
    elif 'dial tcp' in error_msg and 'getsockopt: broken pipe' in error_msg:
        return 'getsockopt: broken pipe'
    elif 'dial tcp' in error_msg and 'getsockopt: connection reset by peer' in error_msg:
        return 'getsockopt: connection reset by peer'
    elif 'dial tcp' in error_msg and 'getsockopt: network is unreachable' in error_msg:
        return 'getsockopt: network is unreachable'
    elif 'dial tcp' in error_msg and 'getsockopt: protocol not available' in error_msg:
        return 'getsockopt: protocol not available'
    else:
        return 'other'

def updateStatusStats(field_IP,status):
        global nOk
        global nNotOk
        global dStatus
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
                if not(status in dStatus):
                        dStatus[status]=0
                dStatus[status]+=1
                dSeen_ok[field_IP]=status

def updateErrStats(field_IP,errType):
        global nOk
        global nNotOk
        global dStatus
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
		line=line.strip()
		ssh = json.loads(line)

		field_label="ok"
		field_subLabel="-"
		field_banner="-"
		field_IP=str(ssh["ip"])
		field_err="-"
		field_err_desc="-"

		if not ('ssh' in ssh["data"]):
			# Update fields
			field_label="error"
			field_err=str(ssh["error"])
			field_err_desc="No SSH response"
			# Update err stats
			updateErrStats(field_IP,getErrorString(field_err))
	
		elif 'server_protocol' in ssh["data"]["ssh"]:
 			if 'raw_banner' in ssh["data"]["ssh"]["server_protocol"]:
				banner=str(ssh["data"]["ssh"]["server_protocol"]["raw_banner"])
				field_banner=banner.strip()

				if not (re.match("SSH", banner)):
					field_err_desc="Banner doesn't start with SSH"
					# Update stats
					updateStatusStats(field_IP,field_err_desc)
				else:
					# Update stats
					updateStatusStats(field_IP,"Banner ok")

			else:
				field_err=str(ssh["error"])
				field_label="error"
				field_err_desc="No banner"
				# Update err stats
				updateErrStats(field_IP,getErrorString(field_err))

		elif 'error' in ssh:
			field_label="error"
			field_err=str(ssh["error"])
	 		field_err_desc="No server_protocol"
			# Update err stats
			updateErrStats(field_IP,getErrorString(field_err))
		else:
			field_label="error"
			field_subLabel="unknown"
			field_err_desc="No error field"
			# Update err stats
                        updateErrStats(field_IP,getErrorString(''))

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
		field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
		field_banner=field_banner.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_banner+"\t"+field_IP+"\t"+field_err+"\t"+field_err_desc+"\n")

	except Exception as e:
		line=line.decode('unicode_escape').encode('ascii','ignore')
		
		field_label="error"
                field_subLabel="-"
                field_banner="-"
                field_IP="-"
                field_err="-"
                field_err_desc="-"

		mIP = re.search("\"ip\":\"(\d\d?\d?\.\d\d?\d?\.\d\d?\d?\.\d\d?\d?)", line)
		if mIP:
			field_IP = mIP.group(1)

                mError = re.search("\"error\":(.+)\"", line)
                if mError:
                        field_subLabel="except"
			field_err=mError.group(1)
		else:
			field_subLabel="except-unknown"
			field_err_desc=str(e)
		# Update err stats
                updateErrStats(field_IP,'other')

                # Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
                field_banner=field_banner.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_banner+"\t"+field_IP+"\t"+field_err+"\t"+field_err_desc+"\n")

fOut.close()

# Now produce stats
total=nOk+nNotOk
fOutStats = open(file_output_stats, 'w')
sshResponse=float(nOk)/total*100
nonSshResponse=float(nNotOk)/total*100

fOutStats.write("Total\t%d\tsshResponse\t%.2f pct\t%d\n" %(total,sshResponse, nOk))
sorted_dStatus = sorted(dStatus.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dStatus:
	pct=0.0
	if nOk>0:
        	pct=float(each[1])/nOk*100
        fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.write("\nTotal\t%d\tnonSshResponse\t%.2f pct\t%d\n" %(total,nonSshResponse,nNotOk))
sorted_dErrors = sorted(dErrors.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dErrors:
	pct=0.0
	if nNotOk>0:
        	pct=float(each[1])/nNotOk*100
        fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.close()

fLog.write("Finished at: "+str(datetime.datetime.now())+"\n")
fLog.close()


