#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

awk -F, 'NR>1{
  ip6prefix="2604:2000:14c4:a1ed::"
  domain="radoncanyon.com"
  mac=$3
  ip=$2
  hostname=$1
  n=split(ip,arr,".");
  ip6=arr[n]
  printf "dhcp-host=%s,%s,%s,%s\n", mac, ip, ("[" ip6prefix ip6 "]"), hostname
  printf "host-record=%s,%s,%s,%s\n", hostname, (hostname "," domain), ip, (ip6prefix ip6)
}' hosts.csv > dnsmasq.conf
echo 'Generated dnsmasq.conf from hosts.csv'

exit 0
