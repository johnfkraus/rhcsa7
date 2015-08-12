# Boot systems into different targets manually
## 6.3. WORKING WITH SYSTEMD TARGETS
Previous versions of Red Hat Enterprise Linux, which were distributed with SysV init or Upstart, implemented a predefined set of runlevels that represented specific modes of operation. These runlevels were numbered from 0 to 6 and were defined by a selection of system services to be run when a particular runlevel was enabled by the system administrator. In Red Hat Enterprise Linux 7, the concept of runlevels has been replaced with systemd targets.
Systemd targets are represented by target units. Target units end with the .target file extension and their only purpose is to group together other systemd units through a chain of dependencies. For example, the graphical.target unit, which is used to start a graphical session, starts system services such as the GNOME Display Manager (gdm.service) or Accounts Service (accounts-daemon.service) and also activates the multi-user.target unit. Similarly, the multi-user.target unit starts other essential system services such as NetworkManager (NetworkManager.service) or D-Bus (dbus.service) and activates another target unit named basic.target.
Red Hat Enterprise Linux 7 is distributed with a number of predefined targets that are more or less similar to the standard set of runlevels from the previous releases of this system. For compatibility reasons, it also provides aliases for these targets that directly map them to SysV runlevels. Table 6.6, “Comparison of SysV Runlevels with systemd Targets” provides a complete list of SysV runlevels and their corresponding systemd targets.

**Table 6.6. Comparison of SysV Runlevels with systemd Targets**

| Runlevel 	| Target Units                        	| Description                               	|
|----------	|-------------------------------------	|-------------------------------------------	|
| 0        	| runlevel0.target, poweroff.target   	| Shut down and power off the system.       	|
| 1        	| runlevel1.target, rescue.target     	| Set up a rescue shell.                    	|
| 2        	| runlevel2.target, multi-user.target 	| Set up a non-graphical multi-user system. 	|
| 3        	| runlevel3.target, multi-user.target 	| Set up a non-graphical multi-user system. 	|
| 4        	| runlevel4.target, multi-user.target 	| Set up a non-graphical multi-user system. 	|
| 5        	| runlevel5.target, graphical.target  	| Set up a graphical multi-user system.     	|
| 6        	| runlevel6.target, reboot.target     	| Shut down and reboot the system.          	|

**Table 6.7. Comparison of SysV init Commands with systemctl**

| Old Command      	| New Command                        	| Description                          	|
|------------------	|------------------------------------	|--------------------------------------	|
| runlevel         	| systemctl list-units --type target 	| Lists currently loaded target units. 	|
| telinit runlevel 	| systemctl isolate name.target      	| Changes the current target.          	|

### 6.3.4. Changing the Current Target
To change to a different target unit in the current session, type the following at a shell prompt as root:

```shell
systemctl isolate name.target
```

This command starts the target unit named name and all dependent units, and immediately stops all others.

**Example 6.11. Changing the Current Target**

To turn off the graphical user interface and change to the multi-user.target unit in the current session, run the following command as root:

```shell
~]# systemctl isolate multi-user.target
```

### 6.3.5. Changing to Rescue Mode
Rescue mode provides a convenient single-user environment and allows you to repair your system in situations when it is unable to complete a regular booting process. In rescue mode, the system attempts to mount all local file systems and start some important system services, but it does not activate network interfaces or allow more users to be logged into the system at the same time. In Red Hat Enterprise Linux 7, rescue mode is equivalent to single user mode and requires the root password.

To change the current target and enter rescue mode in the current session, type the following at a shell prompt as root:

```shell
systemctl rescue
```

This command is similar to systemctl isolate rescue.target, but it also sends an informative message to all users that are currently logged into the system. To prevent systemd from sending this message, run this command with the --no-wall command line option:

```shell
systemctl --no-wall rescue
```

### 6.3.6. Changing to Emergency Mode
Emergency mode provides the most minimal environment possible and allows you to repair your system even in situations when the system is unable to enter rescue mode. In emergency mode, the system mounts the root file system only for reading, does not attempt to mount any other local file systems, does not activate network interfaces, and only starts few essential services. In Red Hat Enterprise Linux 7, emergency mode requires the root password.

To change the current target and enter emergency mode, type the following at a shell prompt as root:

```shell
systemctl emergency
```

This command is similar to systemctl isolate emergency.target, but it also sends an informative message to all users that are currently logged into the system.
