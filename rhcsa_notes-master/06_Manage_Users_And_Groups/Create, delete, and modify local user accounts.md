### Create, delete, and modify local user accounts
---

`/etc/default/useradd`: File contains useradd default parameters (also viewable using `useradd -D`)

`/etc/skel`: Directory contains default files added to new user accounts upon creation

`/etc/login.defs`: File containts default parameters for other user and group management tools

##### User Management
`useradd joe`: Add user joe

`useradd -G group1 joe`: Add user joe to group1

`useradd -s /bin/sh joe`: Add sh to user joe

`useradd -u 504 -g  505 joe`: Set UID and GID for user joe

`useradd -a -G group2 joe`: Add additional group to user joe

`passwd joe`: Change user joe's password

`userdel joe`: Delete user joe

`userdel -f joe`: Force delete user joe (even if he/she is logged in)

##### Preventing User Creation/Modification Issues
`pwck`: Checks `/etc/passwd` for corruption and irregularities 

`vipw`: Customer verision of `vi` used to edit `/etc/passwd` which disables write access when in use

##### Shadowing
`pwconv`: Creates and updates the `/etc/shadow` file and moves user passwords over from the `/etc/passwd` file

`pwunconv`: Moves `/etc/shadow` passwords back to the `/etc/passwd` file
