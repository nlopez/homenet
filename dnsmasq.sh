#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

awk -F, 'NR>1{
  domain="radoncanyon.com"
  mac=$3
  ip=$2
  hostname=$1
  printf "dhcp-host=%s,%s,%s\n", mac, ip, hostname
  printf "host-record=%s,%s,%s\n", hostname, (hostname "," domain), ip}' hosts.csv > dnsmasq.conf
echo 'Generated dnsmasq.conf from hosts.csv'

exit 0
