# Create and configure set-GID directories for collaboration
## 3.3. USING COMMAND LINE TOOLS
### 3.3.3. Creating Group Directories
However, with the UPG scheme, groups are automatically assigned to files created within a directory with the setgid bit set. The setgid bit makes managing group projects that share a common directory very simple because any files a user creates within the directory are owned by the group which owns the directory.

For example, a group of people need to work on files in the /opt/myproject/ directory. Some people are trusted to modify the contents of this directory, but not everyone.

1. As root, create the /opt/myproject/ directory by typing the following at a shell prompt:

```shell
mkdir /opt/myproject
```

2. Add the myproject group to the system:

```shell
groupadd myproject
```

3. Associate the contents of the /opt/myproject/ directory with the myproject group:

```shell
chown root:myproject /opt/myproject
```

Allow users to create files within the directory, and set the setgid bit:

```shell
chmod 2775 /opt/myproject
```

At this point, all members of the myproject group can create and edit files in the /opt/myproject/ directory without the administrator having to change file permissions every time users write new files. To verify that the permissions have been set correctly, run the following command:

```shell
~]# ls -l /opt
total 4
drwxrwsr-x. 3 root myproject 4096 Mar  3 18:31 myproject
```
