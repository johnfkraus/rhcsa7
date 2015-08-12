### Locate and interpret system log files and journals
---

Logs are located in `/var/log`

##### Boot Information

`systemd-analyze`: analyzes system boot performance
```
[user@centos-server ~]$ systemd-analyze
Startup finished in 353ms (kernel) + 2.200s (initrd) + 28.236s (userspace) = 30.790s
```

`systemd-analyze blame`: breaks down boot time by services
```
[slapula@centos-server ~]$ systemd-analyze blame
         24.507s kdump.service
          2.063s postfix.service
          1.626s plymouth-quit-wait.service
          1.279s firewalld.service
          1.014s tuned.service
           797ms ModemManager.service
           733ms accounts-daemon.service
           711ms network.service
           511ms systemd-logind.service
           465ms avahi-daemon.service
           407ms rhel-dmesg.service
           384ms rtkit-daemon.service
           381ms sysstat.service
           372ms dmraid-activation.service
           358ms lvm2-monitor.service
           357ms plymouth-start.service
		   [...]
```

##### Journal Analysis

`journalctl`: used to access systemd event logs

`journalctl -b`: access all event logs since last boot

`journalctl --since=today`: access all event logs from today

`journalctl -p err`: access all event logs related `err` priority

`journalctl -u <service/unit`: accesses event logs for a particular systemd unit

`journalctl -f`: access last 10 events and stream new ones (similar to `tail -f /var/log/messages`)