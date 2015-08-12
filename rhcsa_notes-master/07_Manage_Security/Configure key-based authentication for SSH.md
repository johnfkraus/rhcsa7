### Configure key-based authentication for SSH
---
#### Client-Side Configuration
##### Public-key Authentication:
###### Step One
- To generate DSA keys, on the command line, enter:
  `ssh-keygen -t dsa``
- To generate RSA keys, on the command line, enter:
  `ssh-keygen -t rsa`

The keygen process:
```
ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/user/.ssh/id_rsa.
Your public key has been saved in /home/user/.ssh/id_rsa.pub.
The key fingerprint is:
4a:dd:0a:c6:35:4e:3f:ed:27:38:8c:74:44:4d:93:67 demo@a
The key's randomart image is:
+--[ RSA 2048]----+
|          .oo.   |
|         .  o.E  |
|        + .  o   |
|     . = = .     |
|      = S = .    |
|     o + = +     |
|      . o + o .  |
|           . o   |
|                 |
+-----------------+
```

###### Step Two
Copy Public Key to host(s): `ssh-copy-id -i ~/.ssh/id_rsa.pub user@<IP_address or Hostname>`

#### Server-Side Configuration

The following options in the sshd configuration `/etc/ssh/sshd_config`:
```
PasswordAuthentication no
PubkeyAuthentication yes
```

If those settings need to be changed, change them, then restart sshd with `systemctl restart sshd`