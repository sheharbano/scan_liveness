print "folder_prefix=\"/home/bano/my_media/nemesis/vertical/05-09-2017/\""

print "folder_out=$folder_prefix\"analysis/nw_aliveness/cond_prob_byProto/\""
print "mkdir -p $folder_out"

print "log_file=$folder_out\"log_condProb.log\""
print ">$log_file"

print "tmp_union=$folder_out\"tmp_union.set\""
print "tmp_intersect=$folder_out\"tmp_intersect.set\""

print "in_icmp=$folder_prefix\"icmp/out_icmp/diff_sets/out_srcIP.set\""

print "in_http=$folder_prefix\"http/out_tcp/diff_sets/out_srcIP.set\""

print "in_ssh=$folder_prefix\"ssh/out_tcp/diff_sets/out_srcIP.set\""

print "in_tls=$folder_prefix\"tls/out_tcp/diff_sets/out_srcIP.set\""

print "in_cwmp=$folder_prefix\"cwmp/out_tcp/diff_sets/out_srcIP.set\""

print "in_telnet=$folder_prefix\"telnet/out_tcp/diff_sets/out_srcIP.set\""

print "in_dns=$folder_prefix\"dns/out_udp/diff_sets/out_srcIP.set\""

print "in_ntp=$folder_prefix\"ntp/out_udp/diff_sets/out_srcIP.set\""

# FIXME
protocols={1:"$in_icmp", 2:"$in_http", 3:"$in_ssh", 4:"$in_tls", 5:"$in_cwmp", 6:"$in_telnet", 7:"$in_dns", 8:"$in_ntp"}

n_combinations=pow(2,len(protocols))-1

for i in range(1,n_combinations):
	state=str(bin(i))[2:].zfill(len(protocols))
	str_union=""
	str_intersect=""
	n_intersect=0
	n_union=0
	idx=1
	for ch in state:
		if ch == '0':
			str_union = str_union + protocols[idx] + " "
			n_union+=1
		else:
			str_intersect = str_intersect + protocols[idx] + " "
			n_intersect+=1
		idx+=1

	print "\n#=========== %s ============"%state
	
	out_file="$folder_out\""+state+".set\""
	
	print "echo 'Started at: '`date` >>$log_file"

	if n_intersect > 1:	
		cmd = "rwsettool --intersect " + str_intersect + "--output-path=$tmp_intersect"
		print cmd
	elif n_intersect == 1:
		cmd = "cp "+str_intersect+" $tmp_intersect"
		print cmd

	if n_union > 1:
                cmd = "rwsettool --union " + str_union + "--output-path=$tmp_union"
		print cmd
        elif n_union == 1:
                cmd = "cp "+str_union+" $tmp_union"
		print cmd
	
	cmd="rwsettool --difference $tmp_intersect $tmp_union --output-path="+out_file
	print cmd

	print "rm $tmp_intersect"
	print "rm $tmp_union"

	print "echo 'Finished at: '`date` >>$log_file"


print "\n# ============ UNION ============"

print "out_UNION=$folder_out\"UNION.set\""
print "echo 'Started UNION at: '`date` >>$log_file"

str_union=""
for each in protocols:
	str_union = str_union + protocols[each] + " "

cmd = "rwsettool --union " + str_union + "--output-path=$out_UNION"
print cmd

print "echo 'Finished UNION at: '`date` >>$log_file"

print "\n# ============ INTERSECT ============"

print "out_INTERSECT=$folder_out\"INTERSECT.set\""
print "echo 'Started INTERSECT at: '`date` >>$log_file"

str_intersect=""
for each in protocols:
        str_intersect = str_intersect + protocols[each] + " "

cmd = "rwsettool --intersect " + str_intersect + "--output-path=$out_INTERSECT"
print cmd

print "echo 'Finished INTERSECT at: '`date` >>$log_file"
