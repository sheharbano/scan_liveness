import sys
import re
import ipaddress

if __name__ == "__main__":
	if len(sys.argv) < 3:
		print "usage: %s blacklist_file output_file" % (sys.argv[0])
		sys.exit(1)

	file_bl=sys.argv[1]
	out_file=sys.argv[2]

	f = open(file_bl, 'r')
	f_out = open(out_file, 'w')

	for line in f:
		li=line.lstrip()
		if not li.startswith("#"):
			nw=re.split('\s+', li)[0].strip()
			arr=re.split('/',nw)
			if arr[1]=="32":
				f_out.write(arr[0]+"\n")
			else:
				net4=ipaddress.ip_network(unicode(nw),strict=False)
				for x in net4.hosts():
					f_out.write(str(x)+"\n")

