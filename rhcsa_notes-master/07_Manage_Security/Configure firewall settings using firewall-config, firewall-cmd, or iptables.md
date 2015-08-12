### Configure firewall settings using firewall-config, firewall-cmd, or iptables
---

Keep in mind that Firewalld and IPtables cannot be used at the same time.  Pick one and go with it!

#### Firewalld
---
##### Configuration Files
`/etc/firewalld`: Directory containing firewalld configuration files

`/usr/lib/firewalld`: Contains service and zone templates

##### General Commands
Keep in mind that commands that change rules and zones through the command line are temporary unless `--permanent` is used

`systemctl status firewalld`: Displays firewalld status

`firewall-cmd --get-default-zone`: Displays default zone

`firewall-cmd --zone=public --list-all`: 

`firewall-cmd --get-active-zones`: Displays active zones and the interfaces assigned to them

`firewall-cmd --get-zone-of-interface=eth0`: Displays zones assigned to a specific interface

`firewall-cmd --get-zones`: Displays all available zones

`firewall-cmd --permanent --new-zone=test`: Create new zone

`firewall-cmd --set-default-zone=home`: Sets default zone

`firewall-cmd --reload`: Reload firewall rules

##### Source Management
`firewall-cmd --permanent --zone=trusted --add-source=192.168.2.0/24`: Add source IP(s) to zone

`firewall-cmd --permanent --zone=trusted --remove-source=192.168.2.0/24`: Remove source IP(s) to zone

`firewall-cmd --permanent --zone=work --change-source=192.168.2.0/24`: Change source IP(s) to different zone

`firewall-cmd --zone=trusted --list-sources`: List source IP(s) for a given zone

##### Service Management

#### IPtables
---
`/etc/sysconfig/iptables`: IPtables configuration file