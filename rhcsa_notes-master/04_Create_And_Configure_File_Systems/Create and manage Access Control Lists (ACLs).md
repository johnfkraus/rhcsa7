Create and manage Access Control Lists (ACLs)

Edit fstab to enable ACLs and remount filesystem
# vim /etc/fstab
##  /dev/mapper/vg_rhel01-lv_root /                       ext4    defaults,acl        1 1
# mount -o remount /

List ACLs on a particular file:
# getfacl <file>

Set ACL for user:
# setfacl -m u:user1:rwx <file>

Sef ACL for group:

# setfacl -m g:group1:rwx <file>