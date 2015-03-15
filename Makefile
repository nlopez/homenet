dnsmasq.conf:
	awk -F, '{print "dhcp-host=" $$3 "," $$2 "," $$1 ",infinte" }' hosts.csv > dnsmasq.conf
	echo >> dnsmasq.conf
	awk -F, '{print "host-record=" $$1 "," $$1 ".radoncanyon.com," $$2 }' hosts.csv >> dnsmasq.conf

clean:
	rm -vf dnsmasq.conf

test: dnsmasq.conf
	dnsmasq --test --conf-file=dnsmasq.conf
