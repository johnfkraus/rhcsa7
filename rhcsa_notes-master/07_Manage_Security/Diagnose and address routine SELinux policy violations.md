### Diagnose and address routine SELinux policy violations
---
SElinux logs messages to /var/log/audit/audit.log and will be labeled `type=AVC`.

`yum install setroubleshoot-server`: Installs packages related to troubleshooting SELinux policy violations

`sealert -a /var/log/audit/audit.log`: Displays SELinux policy violations

For example,
```
type=AVC msg=audit(1415714880.156:29): avc:  denied  { name_connect } for  pid=1349 \
  comm="nginx" dest=8080 scontext=unconfined_u:system_r:httpd_t:s0 \
  tcontext=system_u:object_r:http_cache_port_t:s0 tclass=tcp_socket
```

To get information from an audit.log entry:
```
grep 1415714880.156:29 /var/log/audit/audit.log | audit2why

        Was caused by:
        One of the following booleans was set incorrectly.
        Description:
        Allow httpd to act as a relay

        Allow access by executing:
        # setsebool -P httpd_can_network_relay 1
        Description:
        Allow HTTPD scripts and modules to connect to the network using TCP.

        Allow access by executing:
        # setsebool -P httpd_can_network_connect 1
```