dnsmasq.conf:
	sed '1d' hosts.csv | awk -F, '{print "dhcp-host=" $$3 "," $$2 "," $$1 ",infinte" }' > dnsmasq.conf
	echo >> dnsmasq.conf
	sed '1d' hosts.csv | awk -F, '{print "host-record=" $$1 "," $$1 ".radoncanyon.com," $$2 }' >> dnsmasq.conf

clean:
	rm -vf dnsmasq.conf

test: dnsmasq.conf
	dnsmasq --test --conf-file=dnsmasq.conf
