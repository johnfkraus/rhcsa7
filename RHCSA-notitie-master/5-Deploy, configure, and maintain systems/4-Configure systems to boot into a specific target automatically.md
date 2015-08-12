# Configure systems to boot into a specific target automatically
## 6.3. WORKING WITH SYSTEMD TARGETS
### 6.3.1. Viewing the Default Target
To determine which target unit is used by default, run the following command:

```shell
systemctl get-default
```

This command resolves the symbolic link located at /etc/systemd/system/default.target and displays the result.

**Example 6.8. Viewing the Default Target**

To display the default target unit, type:

```shell
~]$ systemctl get-default
graphical.target
```

### 6.3.2. Viewing the Current Target
To list all currently loaded target units, type the following command at a shell prompt:

```shell
systemctl list-units --type target
```

By default, the systemctl list-units command displays only active units. If you want to list all loaded units regardless of their state, run this command with the --all or -a command line option:

```shell
systemctl list-units --type target --all
```

**Example 6.9. Viewing the Current Target**

To list all currently loaded target units, run the following command:

```shell
~]$ systemctl list-units --type target
UNIT                  LOAD   ACTIVE SUB    DESCRIPTION
basic.target          loaded active active Basic System
cryptsetup.target     loaded active active Encrypted Volumes
getty.target          loaded active active Login Prompts
graphical.target      loaded active active Graphical Interface
local-fs-pre.target   loaded active active Local File Systems (Pre)
local-fs.target       loaded active active Local File Systems
multi-user.target     loaded active active Multi-User System
network.target        loaded active active Network
paths.target          loaded active active Paths
remote-fs.target      loaded active active Remote File Systems
sockets.target        loaded active active Sockets
sound.target          loaded active active Sound Card
spice-vdagentd.target loaded active active Agent daemon for Spice guests
swap.target           loaded active active Swap
sysinit.target        loaded active active System Initialization
time-sync.target      loaded active active System Time Synchronized
timers.target         loaded active active Timers

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.

17 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.
```

### 6.3.3. Changing the Default Target
To configure the system to use a different target unit by default, type the following at a shell prompt as root:

```shell
systemctl set-default name.target
```

This command replaces the /etc/systemd/system/default.target file with a symbolic link to /usr/lib/systemd/system/name.target, where name is the name of the target unit you want to use.

**Example 6.10. Changing the Default Target**

To configure the system to use the multi-user.target unit by default, run the following command as root:

```shell
~]# systemctl set-default multi-user.target
rm '/etc/systemd/system/default.target'
ln -s '/usr/lib/systemd/system/multi-user.target' '/etc/systemd/system/default.target'
```
