# Create, delete, and modify local groups and group memberships
## 3.3. USING COMMAND LINE TOOLS
### 3.3.2. Adding a New Group
To add a new group to the system, type the following at a shell prompt as root:

```shell
groupadd [options] group_name
```

…where options are command line options as described in Table 3.3, “groupadd command line options”.

**Table 3.3. groupadd command line options**

| Option                  	| Description                                                                                          	|
|-------------------------	|------------------------------------------------------------------------------------------------------	|
| -f, --force             	| When used with -g gid and gid already exists, groupadd will choose another unique gid for the group. 	|
| -g gid                  	| Group ID for the group, which must be unique and greater than 999.                                   	|
| -K, --key key=value     	| Override /etc/login.defs defaults.                                                                   	|
| -o, --non-unique        	| Allow to create groups with duplicate.                                                               	|
| -p, --password password 	| Use this encrypted password for the new group.                                                       	|
| -r                      	| Create a system group with a GID less than 1000.                                                     	|
