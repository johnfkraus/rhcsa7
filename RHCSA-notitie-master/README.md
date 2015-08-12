# RHCSA-notitie
Persoonlijke notitie ter voorbereiding van RHCSA.

Bron: https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-rhcsa-exam

## Understand and use essential tools
* Access a shell prompt and issue commands with correct syntax
* Use input-output redirection (>, >>, |, 2>, etc.)
* Use grep and regular expressions to analyze text
* [Access remote systems using ssh](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/s1-ssh-clients.html#s2-ssh-clients-ssh)
* [Log in and switch users in multiuser targets](1-Understand and use essential tools/5-Log in and switch users in multiuser targets.md)
* Archive, compress, unpack, and uncompress files using tar, star, gzip, and bzip2
* Create and edit text files
* Create, delete, copy, and move files and directories
* Create hard and soft links
* List, set, and change standard ugo/rwx permissions
* Locate, read, and use system documentation including man, info, and files in /usr/share/doc

## Operate running systems
* [Boot, reboot, and shut down a system normally](2-Operate running systems/1-Boot, reboot, and shut down a system normally.md)
* [Boot systems into different targets manually](2-Operate running systems/2-Boot systems into different targets manually.md)
* [Interrupt the boot process in order to gain access to a system](2-Operate running systems/3-Interrupt the boot process in order to gain access to a system.md)
* [Identify CPU/memory intensive processes, adjust process priority with renice, and kill processes](2-Operate running systems/4-Identify CPU-memory intensive processes, adjust process priority with renice, and kill processes.md)
* [Locate and interpret system log files and journals](2-Operate running systems/5-Locate and interpret system log files and journals.md)
* Access a virtual machine's console
* Start and stop virtual machines
* Start, stop, and check the status of network services
* Securely transfer files between systems

## Configure local storage
* List, create, delete partitions on MBR and GPT disks
* Create and remove physical volumes, assign physical volumes to volume groups, and create and delete logical volumes
* Configure systems to mount file systems at boot by Universally Unique ID (UUID) or label
* Add new partitions and logical volumes, and swap to a system non-destructively

## Create and configure file systems
* Create, mount, unmount, and use vfat, ext4, and xfs file systems
* Mount and unmount CIFS and NFS network file systems
* Extend existing logical volumes
* [Create and configure set-GID directories for collaboration](4-Create and configure file systems/4-Create and configure set-GID directories for collaboration.md)
* Create and manage Access Control Lists (ACLs)
* Diagnose and correct file permission problems

## Deploy, configure, and maintain systems
* Configure networking and hostname resolution statically or dynamically
* Schedule tasks using at and cron
* [Start and stop services and configure services to start automatically at boot](5-Deploy, configure, and maintain systems/3-Start and stop services and configure services to start automatically at boot.md)
* [Configure systems to boot into a specific target automatically](5-Deploy, configure, and maintain systems/4-Configure systems to boot into a specific target automatically.md)
* Install Red Hat Enterprise Linux automatically using Kickstart
* Configure a physical machine to host virtual guests
* Install Red Hat Enterprise Linux systems as virtual guests
* Configure systems to launch virtual machines at boot
* Configure network services to start automatically at boot
* Configure a system to use time services
* [Install and update software packages from Red Hat Network, a remote repository, or from the local file system](5-Deploy, configure, and maintain systems/11-Install and update software packages from Red Hat Network, a remote repository, or from the local file system.md)
* Update the kernel package appropriately to ensure a bootable system
* Modify the system bootloader

## Manage users and groups
* [Create, delete, and modify local user accounts](6-Manage users and groups/1-Create, delete, and modify local user accounts.md)
* Change passwords and adjust password aging for local user accounts
* [Create, delete, and modify local groups and group memberships](6-Manage users and groups/3-Create, delete, and modify local groups and group memberships.md)
* Configure a system to use an existing authentication service for user and group information

## Manage security
* Configure firewall settings using firewall-config, firewall-cmd, or iptables
* [Configure key-based authentication for SSH](7-Manage security/2-Configure key-based authentication for SSH.md)
* Set enforcing and permissive modes for SELinux
* List and identify SELinux file and process context
* Restore default file contexts
* Use boolean settings to modify system SELinux settings
* Diagnose and address routine SELinux policy violations
