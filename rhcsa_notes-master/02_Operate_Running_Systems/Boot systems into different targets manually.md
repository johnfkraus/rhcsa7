### Boot systems into different targets manually
---
Before Systemd, there were the following runlevels:

0 system shut down
1 single: maintenance level,
2 level without network resources (NFS, etc),
3 multi-user level without graphical interface,
4 multi-user level with graphical interface.
6 system reboot

Default runlevel is set in `/etc/inittab`

`runlevel`: Displays current runlevel

`init <runlevel>`: Changes current runlevel