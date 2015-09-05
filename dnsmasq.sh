#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sed '1d' hosts.csv | awk -F, '{print "dhcp-host=" $3 "," $2 "," $1 }' > dnsmasq.conf
echo >> dnsmasq.conf
sed '1d' hosts.csv | awk -F, '{print "host-record=" $1 "," $1 ".radoncanyon.com," $2}' >> dnsmasq.conf
echo 'Generated dnsmasq.conf from hosts.csv'

exit 0
