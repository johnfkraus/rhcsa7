### Start, stop, and check the status of network services
---
`systemctl start httpd`: Start apache web server

`systemctl restart httpd`: Restart process

`systemctl reload httpd`: Reload config for process

`systemctl stop httpd`: Stop process

`systemctl is-active httpd`: Check if process is running

`systemctl enable httpd`: Start process on boot

`systemctl is-enabled httpd`: Check if process starts at boot

`systemctl status httpd`: Check status of process

`systemctl mask httpd`: Permanently disable process
