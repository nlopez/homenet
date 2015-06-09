all: clean dnsmasq.conf test

dnsmasq.conf:
	@sed '1d' hosts.csv | awk -F, '{print "dhcp-host=" $$3 "," $$2 "," $$1 }' > dnsmasq.conf
	@echo >> dnsmasq.conf
	@sed '1d' hosts.csv | awk -F, '{print "host-record=" $$1 "," $$1 ".radoncanyon.com," $$2 }' >> dnsmasq.conf
	@echo 'Generated dnsmasq.conf from hosts.csv'

clean:
	@rm -vf dnsmasq.conf

test: dnsmasq.conf
	@dnsmasq --test --conf-file=dnsmasq.conf
