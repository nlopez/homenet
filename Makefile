all: clean dnsmasq.conf test

dnsmasq.conf:
	@./dnsmasq.sh

clean:
	@rm -vf ./dnsmasq.conf

test: dnsmasq.conf
	@dnsmasq --test --conf-file=./dnsmasq.conf
