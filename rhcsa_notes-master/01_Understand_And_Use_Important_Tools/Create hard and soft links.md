### Create hard and soft links
---

Create a hard link (a hard link, the inodes are the same): `ln file.txt file1.txt`

Check inodes on the files: `ls -li`

Create a soft link (uses different inodes: `ln -s file.txt file1.txt`