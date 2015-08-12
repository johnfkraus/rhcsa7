### Change passwords and adjust password aging for local user accounts
---
`passwd <user>`: Change password for user

`chage --list <username>`: Display password aging information on user

`chage -M 120 <username>`: Change password after maximum amount of days

`chage -m 120 <username>`: Change password every X amount of days

`chage -m 0 <username>`: Force user to change password on next login