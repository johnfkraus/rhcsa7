### List, set, and change standard ugo/rwx permissions
---

##### ugo
What is meant by 'ugo'?
* u = User Permissions. This is the user that owns the file.
* g = Group Permissions. This is the group that owns the file.
* o = Others Permissions. This specifies the permissions for all others.

##### rwx
What is meant by 'rwx'?
* r = Read Permissions
* w = Write Permissions
* x = Execute Permissions

List permissions:
```
[user@server ntp]$ ls -lah
total 24K
drwxr-xr-x.   2 root root 4.0K Jul 15 20:38 .
drwxr-xr-x. 131 root root  12K Jul 15 20:46 ..
-rw-------.   1 root root   86 Jun 23 19:44 keys
-rw-r--r--.   1 root root   74 Jun 23 19:44 step-tickers
```

```
d r w x r w x r - x
| | | | | | | | | +---> Execute Permission for Others
| | | | | | | | +-----> Write Permission for Others
| | | | | | | +-------> Read Permission for Others
| | | | | | +---------> Execute Permission for Group
| | | | | +-----------> Write Permission for Group
| | | | +-------------> Read Permission for Group
| | | +---------------> Execute Permission for User
| | +-----------------> Write Permission for User
| +-------------------> Read Permission for User
+---------------------> File, Directory or Link
```