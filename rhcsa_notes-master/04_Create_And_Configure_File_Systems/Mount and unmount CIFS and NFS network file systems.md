Mount and unmount CIFS and NFS network file systems

Mount CIFS share:
# mount -t cifs //server/share /mnt --verbose -o user=username

Mount NFS share:
# mount  -o rw -t nfs hostname:/share /mnt

Unmount share:

# umount /mnt