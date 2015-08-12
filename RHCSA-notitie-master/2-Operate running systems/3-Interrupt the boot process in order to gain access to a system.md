# Interrupt the boot process in order to gain access to a system
## 28.1. COMMON PROBLEMS
### 28.1.3. Resetting the Root Password
If you lost the root password to the system and you have access to the boot loader, you can reset the password by editing the GRUB2 configuration.

**Procedure 28.1. Resetting the Root Password**

1. Boot your system and wait until the GRUB2 menu appears.
2. In the boot loader menu, highlight any entry and press <kbd>e</kbd> to edit it.
3. Find the line beginning with linux. At the end of this line, append the following:
```shell
init=/bin/sh
```
4. Press <kbd>F10</kbd> or <kbd>Ctrl</kbd> + <kbd>X</kbd> to boot the system using the options you just edited.
Once the system boots, you will be presented with a shell prompt without having to enter any user name or password:
```shell
sh-4.2#
```
5. Load the installed SELinux policy:
```shell
sh-4.2# /usr/sbin/load_policy -i
```
6. Execute the following command to remount your root partition:
```shell
sh4.2# mount -o remount,rw /
```
7. Reset the root password:
```shell
sh4.2# passwd root
```
When prompted to, enter your new root password and confirm by pressing the <kbd>Enter</kbd> key. Enter the password for the second time to make sure you typed it correctly and confirm with <kbd>Enter</kbd> again. If both passwords match, a message informing you of a successful root password change will appear.

8. Remount the root partition again, this time as read-only:
```shell
sh4.2# mount -o remount,ro /
```
9. Reboot the system. From now on, you will be able to log in as the root user using the new password set up during this procedure.
