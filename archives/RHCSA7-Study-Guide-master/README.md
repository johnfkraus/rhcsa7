# RHCSA7-Study-Guide
## Things I need to go over


###Attaching a system to centralized LDAP and Kerberos servers

1 . Install packages

```bash
yum -y install authconfig-gtk sssd krb5-workstation
```

2. Launch authconfig-gtk

3. Fill in the information, and remember that the base DN needs to be in this format: 

```shell
dc=example,dc=com
```

###Special Permissions

1. u+s (suid) - File executes as the user that owns the file, not the user that ran the file. 

2. g+s (sgid) - Files newly created in the directory have their group owner set to match the group owner of the directory.

3. o+t (sticky) - Users with write on the directory can only remove files that they own; they cannot remove or force saves to files owned by other users. 

###POSIX Access Control Lists

1. File system mount option - the 'acl' mount option is included by default on RHEL7 for ext4 file systems

2. ls -l outputs ACL setting details. The "+" at the end of the permission string indicates that there are ACL settings on the file

3. getfacl <file> displays all ACL setings

4. Commands: 

```bash
setfacl -m g:name:rw <file>
```

```bash
setfacl -m o::- <file>
```

```bash
setfacl -m u::rwx,g:sodor:rX,o::- <file>
```

```bash
getfacl <file-a> | setfacl --set-file=- <file-b>
```

```bash
setfacl -m m::r file
```

```bash
setfacl -R -m u:name:rX <directory>
```
Delete an ACL
```bash
setfacle -x u:<username>,g:<groupname> <file>
```
Delete all ACL
```bash
setfacl -b <file>
```

###SELinux

####SELinux Modes

1. Enforcing - SELinux both logs and protects 

2. Permissive - Allows all actions, logs interactions it would have denied in enforcing mode

3. disabled - completely disables SELinux

4. Commands

```bash
getenforce
```

```bash
setsebool -a
```

```bash
setenforce <Enforcing|Permissive| 1 | 0 >
```

#####Changing the default SELinux mode

* /etc/selinux/config

#####Changing the SELinux Contexts

* man -k '_selinux' to checkout selinux booleans

```bash
chcon -t <type_t> <file>
```

```bash
restorecon -v <directory>
```

Change the default context rule of a direcotry and everything in the directory

```bash
semanage fcontext -a -t <context_type> '<dirctory>(/.*)?'
```

#####Troubleshooting SeLinux
THe most common SELInux issues is an incorrect file context. This can occur when a file is created in a location with one file context and moved into a place where a different context is expected. In most cases, running restorecon will correct the issue.

Product reports for all incidents in that file. 
```bash
yum install setroubleshoot-server -y
sealert -a /var/log/audit/audit.log
```

###Yum
Summary of Commands:
```bash
#List installed and available packges by name
yum list 

#List installed and available groups
yum grouplist

#Search for a package by keyword
yum search <Keyword>

#Show details of a package
yum info <package-name>

#install a package
yum install <package-name>

#install a package group
yum install <package-group>

#Update all packages
yum update

#Remove a package
yum remove <package-name>

#Display transaction history
yum history

#Enalbing thrid party software repositories
yum-config-manager --add-repo="repo-name"


###GPT Partitions

* Use gdisk <device name> instead of fdisk

###Mounting file systems
```bash
mount /dev/vdb1 /mnt
```

Persistently mounting file systmes
/etc/fstab
```shell
UUID=<UUID>	<mount-target> <file-system-type> <mount-options> <dump-flag> <fsck-order>
```
User the blkid to determine the UUID of a block device
```bash
blkid /dev/vdb1
```

###Activating Swap space
```bash
mkswap <device>
swapon <device>
```
####Persistantly Activating swap space
/etc/fstab
```shell
UUID=<device-uuid> swap swap defaults 0 0
```
###Boot Process

1. The machine is powered on. The system firmware (either modern UEFI or more old fashioned BIOS) runs a POST, and starts to initialize some of the hardware. 

2. The system firware searches for a bootable device, either configured in the UEFI boot firmware or by searching for a Master boot record(MBR) on all disks, in the order configured in the BIOS. 

3. The system fimware reads a boot loader from disk, then passes control of the system to the boot loader.

4. The boot loader loads its configuration from disk, and presents the user with a menu of possible configurations to boot. 

5. After the user has made a choice (or an automatic timeout has happend), the boot loader loads the configured kernel and initramfs from disk and places them in memory. An initframfs is a gzip-ed cpio archive containing kernel modules for all hardware necessary at boot, init scripts, and more. 

6. The boot loader hands control of the system over to the kernel, passing in any options specified on the kernel command line in the boot loader, and the location of the initramfs in memeory. 

7. The kernel initializes all hardware for which it can find a driver in the initramfs, then executes /sbin/init from the initramfs as PID 1. on RHEL7, the initramfs contains a working copy of systemd as /sbin/init, as well as a udev daemon. 

8. THe systemd instance from the initramfs executes all units from the initrd.target target. This includes mounting the actual root file system on /sysroot

9. THe kernel root file system is switched (pivoted) from the initramfs root file system to the system root file system that was previously mounted on /sysroot. systemd then re-executes itself using the copy of systemd installed on the system.

10. systemd looks for a default target, either passed in the kernel command line or configured on the system, then starts (and stops) units to comply with the configuration for that target, solving dependencies between units automatically. In its essence, a systemd target is a set of units that should be activated to reach a desired system state. These targets will typically include at least a text-based login or a graphical login screen being spawned.

###Troubleshooting ports and services
```bash
ss -ta
-t = show tcp packets
-a = show all(listening and established)
```

###System Log Architecture

* systemd-journald

* rsyslogd

####Reviewing systemd Journal Entries
```bash
journalctl
journalctl -n 5
journalctl --since today
journalctl --since "2014-03-10 20:30:00" --until "2014-02-13 12:00:00"
```

###Perserving the systemd Journal
The systemd journal can be made persistent by creating the directory /var/log/journal as user root. 


###Mounting Network Storage with NFS

* /etc/krb5.keytab must be present for NFS exports using kerberos

* enable and start nfs-secure

* fstab for nfs mounts
```shell
serverx:/share /mountpoint nfs sync 0 0
```

###Automounting Network Storage with NFS

* install autofs package


```shell
yum install autofs
```

* Add a master-map file to /etc/auto.master.d. Must have an extenstion of .autofs


```shell
vi /etc/auto.master.d/demo.autofs
/shares /etc/auto.demo
```

* Create the mapping file

```shell
vim /etc/auto.demo
work   -rw,sync   serverX:/shares/work
```
In the above case, the fully qualified mount point will be /shares/work
Mount options start with "-"

* Mapping file with wildcard maps
```shell
* -rw,sync serverX:/shares/&
```


###Kickstart Files

* system-config-kickstart



