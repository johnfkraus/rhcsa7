### Boot, reboot, and shut down a system normally
---
Reboot system:
```
reboot
shutdown -r now
init 6
systemctl reboot
```

Shutdown system:
```
halt
shutdown -h now
init 0
systemctl halt
```

Or:
```
poweroff
systemctl poweroff
```