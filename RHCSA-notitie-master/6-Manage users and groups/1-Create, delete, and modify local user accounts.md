# Create, delete, and modify local user accounts
## 3.2. USING THE USER MANAGER TOOL
The User utility allows you to view, modify, add, and delete local users in the graphical user interface.

### 3.2.1. Viewing Users and Groups
Press the <kbd>Super</kbd> key to enter the Activities Overview, type Users and then press <kbd>Enter</kbd>. The Users utility appears. The <kbd>Super</kbd> key appears in a variety of guises, depending on the keyboard and other hardware, but often as either the Windows or Command key, and typically to the left of the Spacebar.
To make changes to the user accounts first select the **Unlock** button and authenticate yourself as indicated by the dialog box that appears. Note that unless you have superuser privileges, the application will prompt you to authenticate as root. To add and remove users select the + and - button respectively. To edit a users language setting, select the language and a drop-down menu appears.

## 3.3. USING COMMAND LINE TOOLS
**Table 3.1. Command line utilities for managing users and groups**

| Utilities | Description |
|------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| useradd, usermod, userdel | Standard utilities for adding, modifying, and deleting user accounts. |
| groupadd, groupmod, groupdel | Standard utilities for adding, modifying, and deleting groups. |
| gpasswd | Standard utility for administering the /etc/group configuration file. |
| pwck, grpck | Utilities that can be used for verification of the password, group, and associated shadow files. |
| pwconv, pwunconv | Utilities that can be used for the conversion of passwords to shadow passwords, or back from shadow passwords to standard passwords. |

### 3.3.1. Adding a New User
To add a new user to the system, typing the following at a shell prompt as root:

```shell
useradd [options] username
```

…where options are command line options as described in Table 3.2, “useradd command line options”.

By default, the useradd command creates a locked user account.

**Table 3.2. useradd command line options**

| Option | Description |
|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| -c 'comment' | comment can be replaced with any string. This option is generally used to specify the full name of a user. |
| -d home_directory | Home directory to be used instead of default /home/username/. |
| -e date | Date for the account to be disabled in the format YYYY-MM-DD. |
| -f days | Number of days after the password expires until the account is disabled. If 0 is specified, the account is disabled immediately after the password expires. If -1 is specified, the account is not be disabled after the password expires. |
| -g group_name | Group name or group number for the user's default group. The group must exist prior to being specified here. |
| -G group_list | List of additional (other than default) group names or group numbers, separated by commas, of which the user is a member. The groups must exist prior to being specified here. |
| -m | Create the home directory if it does not exist. |
| -M | Do not create the home directory. |
| -N | Do not create a user private group for the user. |
| -p password | The password encrypted with crypt. |
| -r | Create a system account with a UID less than 1000 and without a home directory. |
| -s | User's login shell, which defaults to /bin/bash. |
| -u uid | User ID for the user, which must be unique and greater than 999. |

