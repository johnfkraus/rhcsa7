# Start and stop services and configure services to start automatically at boot
## 6.2. MANAGING SYSTEM SERVICES
**Table 6.3. Comparison of the service Utility with systemctl**

| service                  	| systemctl                                                             	| Description                               	|
|--------------------------	|-----------------------------------------------------------------------	|-------------------------------------------	|
| service name start       	| systemctl start name.service                                          	| Starts a service.                         	|
| service name stop        	| systemctl stop name.service                                           	| Stops a service.                          	|
| service name restart     	| systemctl restart name.service                                        	| Restarts a service.                       	|
| service name condrestart 	| systemctl try-restart name.service                                    	| Restarts a service only if it is running. 	|
| service name reload      	| systemctl reload name.service                                         	| Reloads configuration.                    	|
| service name status      	| systemctl status name.service<br><br>systemctl is-active name.service 	| Checks if a service is running.           	|
| service --status-all     	| systemctl list-units --type service --all                             	| Displays the status of all services.      	|

**Table 6.4. Comparison of the chkconfig Utility with systemctl**

| chkconfig             	| systemctl                                                              	| Description                                        	|
|-----------------------	|------------------------------------------------------------------------	|----------------------------------------------------	|
| chkconfig name on     	| systemctl enable name.service                                          	| Enables a service.                                 	|
| chkconfig name off    	| systemctl disable name.service                                         	| Disables a service.                                	|
| chkconfig --list name 	| systemctl status name.service<br><br>systemctl is-enabled name.service 	| Checks if a service is enabled.                    	|
| chkconfig --list      	| systemctl list-unit-files --type service                               	| Lists all services and checks if they are enabled. 	|

### 6.2.1. Listing Services
To list all currently loaded service units, run the following command:

```shell
~]$ systemctl list-units --type service
UNIT                           LOAD   ACTIVE SUB     DESCRIPTION
abrt-ccpp.service              loaded active exited  Install ABRT coredump hook
abrt-oops.service              loaded active running ABRT kernel log watcher
abrt-vmcore.service            loaded active exited  Harvest vmcores for ABRT
abrt-xorg.service              loaded active running ABRT Xorg log watcher
abrtd.service                  loaded active running ABRT Automated Bug Reporting Tool
...
systemd-vconsole-setup.service loaded active exited  Setup Virtual Console
tog-pegasus.service            loaded active running OpenPegasus CIM Server

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.

46 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'
```

To list all installed service units to determine if they are enabled, type:

```shell
~]$ systemctl list-unit-files --type service
UNIT FILE                                   STATE
abrt-ccpp.service                           enabled
abrt-oops.service                           enabled
abrt-vmcore.service                         enabled
abrt-xorg.service                           enabled
abrtd.service                               enabled
...
wpa_supplicant.service                      disabled
ypbind.service                              disabled

208 unit files listed.
```

### 6.2.2. Displaying Service Status
**Table 6.5. Available Service Unit Information**

| Field    	| Description                                                                                                                       	|
|----------	|-----------------------------------------------------------------------------------------------------------------------------------	|
| Loaded   	| Information whether the service unit has been loaded, the absolute path to the unit file, and a note whether the unit is enabled. 	|
| Active   	| Information whether the service unit is running followed by a time stamp.                                                         	|
| Main PID 	| The PID of the corresponding system service followed by its name.                                                                 	|
| Status   	| Additional information about the corresponding system service.                                                                    	|
| Process  	| Additional information about related processes.                                                                                   	|
| CGroup   	| Additional information about related Control Groups.                                                                              	|

The service unit for the GNOME Display Manager is named gdm.service. To determine the current status of this service unit, type the following at a shell prompt:

```shell
~]# systemctl status gdm.service
gdm.service - GNOME Display Manager
   Loaded: loaded (/usr/lib/systemd/system/gdm.service; enabled)
   Active: active (running) since Thu 2013-10-17 17:31:23 CEST; 5min ago
 Main PID: 1029 (gdm)
   CGroup: /system.slice/gdm.service
           ├─1029 /usr/sbin/gdm
           ├─1037 /usr/libexec/gdm-simple-slave --display-id /org/gno...
           └─1047 /usr/bin/Xorg :0 -background none -verbose -auth /r...

Oct 17 17:31:23 localhost systemd[1]: Started GNOME Display Manager.
```

To only verify that a particular service unit is running, run the following command:

```shell
systemctl is-active name.service
```

Similarly, to determine whether a particular service unit is enabled, type:

```shell
systemctl is-enabled name.service
```

### 6.2.3. Starting a Service
To start a service unit that corresponds to a system service, type the following at a shell prompt as root:

```shell
systemctl start name.service
```

### 6.2.4. Stopping a Service
To stop a service unit that corresponds to a system service, type the following at a shell prompt as root:

```shell
systemctl stop name.service
```

### 6.2.5. Restarting a Service
To restart a service unit that corresponds to a system service, type the following at a shell prompt as root:

```shell
systemctl restart name.service
```

To tell systemd to restart a service unit only if the corresponding service is already running, run the following command as root:

```shell
systemctl try-restart name.service
```

Certain system services also allow you to reload their configuration without interrupting their execution. To do so, type as root:

```shell
systemctl reload name.service
```

### 6.2.6. Enabling a Service
To configure a service unit that corresponds to a system service to be automatically started at boot time, type the following at a shell prompt as root:

```shell
systemctl enable name.service
```

This command reads the [Install] section of the selected service unit and creates appropriate symbolic links to the /usr/lib/systemd/system/name.service file in the /etc/systemd/system/ directory and its subdirectories. This command does not, however, rewrite links that already exist. If you want to ensure that the symbolic links are re-created, use the following command as root:


```shell
systemctl reenable name.service
```
This command disables the selected service unit and immediately enables it again.

**Example 6.6. Enabling a Service**

To configure the Apache HTTP Server to start automatically at boot time, run the following command as root:

```shell
~]# systemctl enable httpd.service
ln -s '/usr/lib/systemd/system/httpd.service' '/etc/systemd/system/multi-user.target.wants/httpd.service'
```

### 6.2.7. Disabling a Service
To prevent a service unit that corresponds to a system service from being automatically started at boot time, type the following at a shell prompt as root:

```shell
systemctl disable name.service
```

This command reads the [Install] section of the selected service unit and removes appropriate symbolic links to the /usr/lib/systemd/system/name.service file from the /etc/systemd/system/ directory and its subdirectories. In addition, you can mask any service unit to prevent it from being started manually or by another service. To do so, run the following command as root:

```shell
systemctl mask name.service
```

This command replaces the /etc/systemd/system/name.service file with a symbolic link to /dev/null, rendering the actual unit file inaccessible to systemd. To revert this action and unmask a service unit, type as root:

```shell
systemctl unmask name.service
```

**Example 6.7. Disabling a Service**

To prevent this service unit from starting at boot time, type the following at a shell prompt as root:
```shell
~]# systemctl disable bluetooth.service
rm '/etc/systemd/system/dbus-org.bluez.service'
rm '/etc/systemd/system/bluetooth.target.wants/bluetooth.service'
```
