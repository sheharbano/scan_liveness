# Output
# Ok means that it's a legit HTTP response
# notOk when the response cannot be parsed via HTTP
#
#if $1=="ok"
#
#	$2: redirect,error-normal,except
#	$3: status code #all codes when ok-redirect
#	$4: status line #  all lines when ok-redirect
#	$5: status codes chain # chain of status codes for ok-redirect
#       $6: status lines chain # chain of status lines for ok-redirect
#	$7: IP
#	$8: -
#
#elif $1=="error"
# 	$2: normal,unknown,except-unknown
#	$3: -
#	$4: -
# 	$5: -
#	$6: -
# 	$7: -
#	$8: error description #full line when error-unknown
# ===================
# ok,redirect: http response with redirect response chain, so parse $3 (status codes) and $4 (status lines) accordingly
# ok,error-normal: error in normal http body, i still treat it as ok as it's still a valid http response 
# ok,except: json parser threw exception, but still valid http response that can be parsed with regex 
#
# error, normal: 
# error, unknown:
# error, except-unknown: 
# ===================
# I got repeated application layer probes here, I deal with it as follows. In summary, successful takes priority
#
# if successful:
# 	if previous unsuccessful response:
#		undo unsuccessful entry
#	if not previous successful entry:
#		enter successful
#if unsuccessful:
#	if not previous successful entry and not previous unsuccessful entry:
#		enter unsuccessful

import json
import datetime
import re
import os
import subprocess
import operator

# FIXME
#folder_prefix="/home/bano/my_media/nemesis/vertical/07-09-2017/http/"
folder_prefix="/home/bano/scripts/preprocessing/parse_application/http/"

out_prefix=folder_prefix+"proc/flat/"
cmd='mkdir -p %s' %(out_prefix)
os.system(cmd)

file_input=folder_prefix+"out_http/out.log"
file_output=out_prefix+"http.flat"
file_output_stats=out_prefix+"http.flat.stats"
file_log=out_prefix+"http.flat.log"

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
    else:
	return 'other'

def updateSuccessStats(field_IP,field_statusCode):
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
                if not(field_statusCode in dStatusCodes):
                	dStatusCodes[field_statusCode]=0
               	dStatusCodes[field_statusCode]+=1
                dSeen_ok[field_IP]=field_statusCode

def updateFailStats(field_IP,errType):
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
        	field_statusCode="-"

        	field_statusLine="-"
        	field_statusCodeChain="-"
        	field_statusLineChain="-"
        	field_IP="-"
        	field_err="-"

		line=line.strip()
		http = json.loads(line)

		field_IP=str(http["ip"])
		if 'response' in http["data"]["http"]:
			# Update fields
			field_subLabel="alive"
			field_statusCode=str(http["data"]["http"]["response"]["status_code"])	
			field_statusLine=str(http["data"]["http"]["response"]["status_line"])
			field_IP=str(http["ip"])
			
			# Update stats
			updateSuccessStats(field_IP,field_statusCode)
		
		elif 'redirect_response_chain' in http["data"]["http"]:
			# Update fields
                        field_subLabel="alive"
			# Prepare chain of status codes and status lines
			field_statusLineChain=""
			field_statusCodeChain=""
			flag_first=1
			for each in http["data"]["http"]["redirect_response_chain"]:
				if flag_first==1:
					field_statusCode=str(each["status_code"])
					field_statusLine=str(each["status_line"])
					flag_first=0
				else:
					field_statusCodeChain=field_statusCodeChain+str(each["status_code"])+";"
					field_statusLineChain=field_statusLineChain+str(each["status_line"])+";"

			# Update stats
			updateSuccessStats(field_IP,field_statusCode)

		elif 'error' in http:
			# Update fields 
			field_label="error"
			field_subLabel="normal"
			field_err=str(http["error"])

			# Check if it's Missing Location response
			error_msg=str(http["error"])
			if 'missing Location' in error_msg:
				# Update fields
        			words=error_msg.split()
        			field_statusCode=words[2].strip() 
				field_label="ok"
				field_subLabel="alive"
				field_err="response missing Location header"
                      
				# Update stats
				updateSuccessStats(field_IP,field_statusCode)

			elif 'malformed' in error_msg:
                                # Update fields
                                words=error_msg.split()
                                field_statusCode=words[2].strip()
                                field_label="ok"
				field_subLabel="active"
                                field_err="malformed response"

                                # Update stats
                                updateSuccessStats(field_IP,field_statusCode)

			else:
				# Update err stats
				errType=getErrorString(error_msg)
				updateFailStats(field_IP,errType)
		else:
			# Update fields
                        field_subLabel="unknown"
			field_err=str(line)
			
			# Update err stats
			errType=getErrorString(line)
			updateFailStats(field_IP,errType)

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
		field_statusLine=field_statusLine.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
		field_statusLineChain=field_statusLineChain.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')

		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_statusCode+"\t"+field_statusLine+"\t"+field_statusCodeChain+"\t"+field_statusLineChain+"\t"+field_IP+"\t"+field_err+"\n")

	except Exception as e:
		field_label="error"
                field_subLabel="-"
                field_statusCode="-"
                field_statusLine="-"
                field_statusCodeChain="-"
                field_statusLineChain="-"                
		field_IP="-"
                field_err="-"

		line=line.decode('unicode_escape').encode('ascii','ignore')
		mStatusCode = re.search("\"status_code\":(\d+)", line)
	
		mIP = re.search("\"ip\":\"(\d\d?\d?\.\d\d?\d?\.\d\d?\d?\.\d\d?\d?)", line)
		if mIP:
			field_IP = mIP.group(1)

        	if mStatusCode:
			# Update fields
			field_statusCode=mStatusCode.group(1)
			field_label="ok"
			field_subLabel="alive"
			field_err=line[0:500]
                		
			# Update stats
                        updateSuccessStats(field_IP,field_statusCode)
        	else:
			error_msg=""
                	mError = re.search("\"error\":(.+)\"", line)
                	if mError:
				# Update fields
				field_subLabel="except"
                        	field_err=mError.group(1)
				error_msg=mError.group(1)
			else:
				# Update fields
				field_subLabel="except-unknown"
				field_err=str(e)+";"+line[0:500]
				error_msg=line

			# Update err stats
                        errType=getErrorString(error_msg)
                        updateFailStats(field_IP,errType)

		# Normalize strings (Remove newlines sometimes as it breaks text parsing later)
                field_err=field_err.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
                field_statusLine=field_statusLine.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')          
		field_statusLineChain=field_statusLineChain.replace('\n', ' ').replace('\r', ' ').replace('\t',' ')
		
		fOut.write(field_label+"\t"+field_subLabel+"\t"+field_statusCode+"\t"+field_statusLine+"\t"+field_statusCodeChain+"\t"+field_statusLineChain+"\t"+field_IP+"\t"+field_err+"\n")

fOut.close()
#
# Now produce stats
total=nOk+nNotOk
fOutStats = open(file_output_stats, 'w')
httpResponse=float(nOk)/total*100
nonHttpResponse=float(nNotOk)/total*100

fOutStats.write("Total\t%d\thttpResponse\t%.2f\n" %(total,httpResponse))
sorted_dStatusCodes = sorted(dStatusCodes.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dStatusCodes:
	pct=0.0
	if nOk > 0:
		pct=float(each[1])/nOk*100
	fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.write("\nTotal\t%d\tnonHttpResponse\t%.2f\n" %(total,nonHttpResponse))
sorted_dErrors = sorted(dErrors.items(), key=operator.itemgetter(1), reverse=True)
for each in sorted_dErrors:
	pct=0.0
	if nNotOk > 0:
        	pct=float(each[1])/nNotOk*100
        fOutStats.write("%s\t%.2f\n" %(each[0],pct))

fOutStats.close()

fLog.write("Finished at: "+str(datetime.datetime.now())+"\n")
fLog.close()

