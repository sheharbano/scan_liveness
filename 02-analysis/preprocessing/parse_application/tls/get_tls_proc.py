# Output
# Ok means that a server hello was received
# Error otherwise
#
#if $1=="ok"
#       $2: -
#       $3: version number of server TLS
#       $4: IP
#       $5: -
#
#elif $1=="error"
#       $2: unknwon,except
#       $3: -
#       $4: IP
#       $5: error
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
folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/tls/"
#folder_prefix="/home/bano/scripts/preprocessing/parse_application/tls/"

out_prefix=folder_prefix+"proc/flat/"
cmd='mkdir -p %s' %(out_prefix)
os.system(cmd)

file_input=folder_prefix+"out_tls/out.log"
file_output=out_prefix+"tls.flat"
file_output_stats=out_prefix+"tls.flat.stats"
file_log=out_prefix+"tls.flat.log"

fOut = open(file_output, 'w')
fLog = open(file_log, 'w')

nOk=0
nNotOk=0
total=0
dOkTypes={}
dErrors={}
# Keeps track of IPs that have responded before
dSeen_ok={}
dSeen_notok={}

fLog.write("Started at: "+str(datetime.datetime.now())+"\n")

def getErrorString(error_msg):
    if 'remote error: handshake failure' in error_msg:
        return 'remote error: handshake failure'
    elif 'remote error: insufficient security level' in error_msg:
        return 'remote error: insufficient security level'
    elif 'remote error: expired certificate' in error_msg:
        return 'remote error: expired certificate'
    elif 'remote error: decryption failed' in error_msg:
        return 'remote error: decryption failed'
    elif 'local error: internal error' in error_msg:
        return 'local error: internal error'
    elif 'dial tcp' in error_msg and 'getsockopt: connection reset by peer' in error_msg:
        return 'getsockopt: connection reset by peer'
    elif 'dial tcp' in error_msg and 'getsockopt: broken pipe' in error_msg:
        return 'getsockopt: broken pipe'
    elif 'dial tcp' in error_msg and 'context deadline exceeded' in error_msg:
        return 'context deadline exceeded'
    elif 'dial tcp' in error_msg and 'getsockopt: network is unreachable' in error_msg:
        return 'getsockopt: network is unreachable'
    elif 'dial tcp' in error_msg and 'getsockopt: protocol not available' in error_msg:
        return 'getsockopt: protocol not available'
    elif 'read tcp' in error_msg and 'i/o timeout' in error_msg:
        return "read tcp: i/o timeout"
    elif 'dial tcp' in error_msg and 'i/o timeout' in error_msg:
        return "dial tcp: i/o timeout"
    elif 'EOF' in error_msg:
        return "EOF badness"
    elif 'tls: oversized record received' in error_msg:
        return 'oversized record received'
    elif 'record does not look like a TLS handshake' in error_msg:
	return 'record does not look like a TLS handshake'
    elif 'read: connection reset by peer' in error_msg:
	return 'read: connection reset by peer'
    elif 'received unexpected handshake message' in error_msg:
        return 'received unexpected handshake message'
    elif 'remote error: alert' in error_msg:
        return 'remote error: alert'
    elif 'remote error: protocol version not supported' in error_msg:
        return 'remote error: protocol version not supported'
    elif 'remote error: access denied' in error_msg:
        return 'remote error: access denied'
    elif 'remote error: illegal parameter' in error_msg:
        return 'remote error: illegal parameter'
    elif 'local error: unexpected message' in error_msg:
        return 'local error: unexpected message'
    elif 'unsupported SSLv2 handshake received' in error_msg:
        return 'unsupported SSLv2 handshake received'
    elif 'remote error: internal error' in error_msg:
        return 'remote error: internal error'
    elif 'dial tcp' in error_msg and 'getsockopt: connection refused' in error_msg:
        return 'getsockopt: connection refused'
    elif 'dial tcp' in error_msg and 'getsockopt: no route to host' in error_msg:
        return 'getsockopt: no route to host'
    elif 'remote error: unexpected message' in error_msg:
        return 'remote error: unexpected message'
    else:
        return 'other'


def updateStatusStats(field_IP, okType):
        global nOk
        global nNotOk
        global dErrors
        global dOkTypes
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
                dSeen_ok[field_IP]=1
		if not(okType in dOkTypes):
                        dOkTypes[okType]=0
                dOkTypes[okType]+=1

def updateErrStats(field_IP,errType):
        global nOk
        global nNotOk
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
		field_version="-"
		field_IP="-"
		field_err="-"

		line=line.strip()
		tls = json.loads(line)

		field_IP=str(tls["ip"])
			
		if not ('tls' in tls["data"]) or len(tls["data"]["tls"])==0:
			if 'error' in tls:
                        	error_msg=str(tls["error"])
                        	if 'remote error' in error_msg:
					field_label="ok"
                			field_subLabel="alive"
                        		updateStatusStats(field_IP, "remote error")

				elif 'oversized record received' in error_msg:
					field_label="ok"
                                        field_subLabel="active"
                                        updateStatusStats(field_IP, "oversized record received")

				elif 'received unexpected handshake message' in error_msg:
                                        field_label="ok"
                                        field_subLabel="active"
					updateStatusStats(field_IP, "received unexpected handshake message")

				elif 'record does not look like a TLS handshake' in error_msg:
                                        field_label="ok"
                                        field_subLabel="active"
					updateStatusStats(field_IP, "record does not look like a TLS handshake")

				elif 'unsupported SSLv2 handshake received' in error_msg:
					field_label="ok"
                                        field_subLabel="alive"
                                        updateStatusStats(field_IP, "unsupported SSLv2 handshake received")

				else:
					field_label="error"
					field_subLabel="emptyNo_TLS_response"
					field_err=tls["error"]
					# Update err stats
                        		updateErrStats(field_IP,getErrorString(tls["error"]))
					
			else:
				field_label="error"
				field_subLabel="unknown"
				# Update err stats
                        	updateErrStats(field_IP,getErrorString(''))

		elif 'server_hello' in tls["data"]["tls"]:
 			if 'version' in tls["data"]["tls"]["server_hello"]:
				field_version=tls["data"]["tls"]["server_hello"]["version"]["name"]
			# Update stats
			updateStatusStats(field_IP,"ALIVE")
		else:
			field_label="error"
			field_subLabel="unknown"
			# Update err stats
                        updateErrStats(field_IP,getErrorString(''))

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_version+"\t"+field_IP+"\t"+field_err+"\n")
	except Exception as e:
		field_label="error"
		field_subLabel="except"
                field_version="-"
                field_IP="-"
		field_err=str(e)

		# Update err stats
                updateErrStats(field_IP,getErrorString(''))
	
		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
		
		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_version+"\t"+field_IP+"\t"+field_err+"\n")


fOut.close()
#
# Now produce stats
total=nOk+nNotOk
fOutStats = open(file_output_stats, 'w')
tlsResponse=float(nOk)/total*100
nonTlsResponse=float(nNotOk)/total*100

fOutStats.write("Total\t%d\ttlsResponse\t%.2f\n" %(total,tlsResponse))

sorted_dOkTypes = sorted(dOkTypes.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dOkTypes:
        pct=float(each[1])/nOk*100
        fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.write("\nTotal\t%d\tnonTlsResponse\t%.2f\n" %(total,nonTlsResponse))

sorted_dErrors = sorted(dErrors.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dErrors:
        pct=float(each[1])/nNotOk*100
        fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.close()

fLog.write("Finished at: "+str(datetime.datetime.now())+"\n")
fLog.close()
	
