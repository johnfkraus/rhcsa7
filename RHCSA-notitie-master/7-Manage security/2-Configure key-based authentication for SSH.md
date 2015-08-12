# Configure key-based authentication for SSH
## 7.2. CONFIGURING OPENSSH
### 7.2.4. Using Key-based Authentication
To do so, open the /etc/ssh/sshd_config configuration file in a text editor such as vi or nano, and change the PasswordAuthentication option as follows:

```
PasswordAuthentication no
```
If you are working on a system other than a new default installation, check that PubkeyAuthentication no has **not** been set.

#### 7.2.4.1. Generating Key Pairs
To generate an RSA key pair for version 2 of the SSH protocol, follow these steps:

1. Generate an RSA key pair by typing the following at a shell prompt:

```shell
~]$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/john/.ssh/id_rsa):
```

2. Press <kb>Enter</kb> to confirm the default location (that is, ~/.ssh/id_rsa) for the newly created key.

3. Enter a passphrase, and confirm it by entering it again when prompted to do so. For security reasons, avoid using the same password as you use to log in to your account.

4. Change the permissions of the ~/.ssh/ directory:

```shell
~]$ chmod 700 ~/.ssh
```

5. To copy the public key to a remote machine, issue a command in the following format:

```shell
ssh-copy-id user@hostname
```

This will copy all ~/.ssh/id*.pub public keys. Alternatively, specify the public keys file name as follows:

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub user@hostname
```
