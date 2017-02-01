#!/usr/bin/env python
from __future__ import print_function
from netaddr import IPAddress, EUI, AddrFormatError, mac_unix_expanded
from textwrap import dedent
import yaml

with open("hosts.yml", 'r') as stream:
    try:
        hosts = yaml.load(stream)['hosts']
    except yaml.YAMLError as exc:
        print(exc)

hosts_valid = []

for host in hosts:
    name = host.get('name')
    # normalize values
    try:
        host['ip'] = IPAddress(host.get('ip'))
        host['mac'] = EUI(host.get('mac'), dialect=mac_unix_expanded)
    except AddrFormatError as exc:
        print("Error parsing host '%(name)s': %(exc)s" % locals())
    hosts_valid.append(host)

preamble = ('''
  #!/bin/vbash
  source /opt/vyatta/etc/functions/script-template
  configure
  delete system static-host-mapping
  delete service dhcp-server shared-network-name LAN1 subnet 192.168.239.0/24 static-mapping
  ''').strip()
postamble = dedent('''
  commit
  save
  exit
  ''').strip()

print(preamble)
for host in hosts_valid:
    print(
        'set system static-host-mapping host-name %(name)s inet %(ip)s'
        '\nset service dhcp-server shared-network-name LAN1 subnet '
        '192.168.239.0/24 static-mapping %(name)s ip-address %(ip)s'
        '\nset service dhcp-server shared-network-name LAN1 subnet '
        '192.168.239.0/24 static-mapping %(name)s mac-address %(mac)s'
        % host)
print(postamble)
