### Archive, compress, unpack, and uncompress files using tar, star, gzip, and bzip2
---
##### Archive
To archive files, type:
```
tar -cf archive.tgz file1 file2 file3
```

To archive a directory, type:
```
tar -cf archive.tgz directory/
```

##### Compression
To compress a file, type:
```
gzip file1
bzip2 file1
````
To uncompress a file, type:
```
gunzip file1.gz
bunzip2 file1.bz2
```

##### Archive & Compress
To archive and compress a directory, type:
```
tar -cvzf directory.tgz directory/
tar -cvjf directory.bz2 directory/
```

To archive and compress a directory while maintaining SELinux contexts, type:
```
tar --selinux -cvzf archive.tgz directory/
tar --selinux -cvjf archive.bz2 directory/
```

To uncompress and unarchive a tgz file, type:
```
tar -xvzf archive.tgz
tar -xvzf archive.tgz -C /path/to/where/you/want/the/files/
```

##### Star
To archive a directory with the star command with the SELinux contexts, type:
```
yum install -y star
star -xattr -H=exustar -c -f=archive.star directory/
```

To unpack a archive file, type:
```
star -x -f=archive.star
```