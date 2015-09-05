#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

awk -F, 'NR>1 {mac=$3; ip=$2; hostname=$1} {printf "dhcp-host=%s,%s,%s\n", mac, ip, hostname}' hosts.csv > dnsmasq.conf
echo >> dnsmasq.conf
sed '1d' hosts.csv | awk -F, '{print "host-record=" $1 "," $1 ".radoncanyon.com," $2}' >> dnsmasq.conf
echo 'Generated dnsmasq.conf from hosts.csv'

exit 0
