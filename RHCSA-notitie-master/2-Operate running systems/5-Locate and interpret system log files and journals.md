# Locate and interpret system log files and journals
## http://www.certdepot.net/rhel7-interpret-system-log-files/
### General presentation
Most of system log files are located in the /var/log directory due to SYSLOG default configuration (see /etc/rsyslog.conf file).

In addition, all SELinux events are written into the /var/log/audit/audit.log file.

With Systemd, new commands have been created to analyse logs at boot time and later.

### Boot process
Systemd primary task is to manage the boot process and provides informations about it.
To get the boot process duration, type:
```shell
# systemd-analyze
Startup finished in 422ms (kernel) + 2.722s (initrd) + 9.674s (userspace) = 12.820s
```
To get the time spent by each task during the boot process, type:
```shell
# systemd-analyze blame
7.029s network.service
2.241s plymouth-start.service
1.293s kdump.service
1.156s plymouth-quit-wait.service
1.048s firewalld.service
632ms postfix.service
621ms tuned.service
460ms iprupdate.service
446ms iprinit.service
344ms accounts-daemon.service
...
7ms systemd-update-utmp-runlevel.service
5ms systemd-random-seed.service
5ms sys-kernel-config.mount
```

### Journal analysis
In addition, Systemd handles the system event log, a syslog daemon is not mandatory any more.
To get the content of the Systemd journal, type:
```shell
# journalctl
```
To get all the events related to the crond process in the journal, type:
```shell
# journalctl /sbin/crond
```
Note: You can replace /sbin/crond by `which crond`.

To get all the events since the last boot, type:
```shell
# journalctl -b
```
To get all the events that appeared today in the journal, type:
```shell
# journalctl --since=today
```
To get all the events with a syslog priority of err, type:
```shell
# journalctl -p err
```
To get the 10 last events and wait for any new one (like tail -f /var/log/messages), type:
```shell
# journalctl -f
```
