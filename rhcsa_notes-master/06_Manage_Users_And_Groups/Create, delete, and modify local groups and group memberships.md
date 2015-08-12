### Create, delete, and modify local groups and group memberships
---
##### Group Management
`groupadd joe`: Display groups that include user joe

`groupadd group1`: Add group

`groupdel group1`: Delete group

`groupmod -n new_group_name group1`: Change group name

`groupmod -g 507 group1`: Change group's GID

`groupmems -g group1 -a joe`: Add user joe to group
	
##### Preventing User Creation/Modification Issues
`grpck`: Checks `/etc/passwd` for corruption and irregularities 

`vigr`: Customer verision of `vi` used to edit `/etc/passwd` which disables write access when in use

##### Shadowing
`grpconv`: Creates and updates the `/etc/gshadow` file and moves group passwords over from the `/etc/group` file

`grpunconv`: Moves `/etc/gshadow` passwords back to the `/etc/group` file