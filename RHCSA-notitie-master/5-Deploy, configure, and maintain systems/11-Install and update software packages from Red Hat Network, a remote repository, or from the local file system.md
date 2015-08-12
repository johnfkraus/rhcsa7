# Install and update software packages from Red Hat Network, a remote repository, or from the local file system
## 5.2. WORKING WITH PACKAGES
### 5.2.1. Searching Packages
```shell
~]$ yum search vi nano
```

### 5.2.2. Listing Packages
```shell
~]$ yum list all
~]$ yum list kernel* libvirt*
~]$ yum list installed kernel* libvirt*
~]$ yum list available kernel* libvirt*
~]$ yum repolist
```

To list both enabled and disabled repositories use the following command. A status column is added to the output list to show which of the repositories are enabled.

```shell
~]$ yum repolist all
~]$ yum repoinfo
```

### 5.2.3. Displaying Package Information
```shell
~]$ yum info nano
```

### 5.2.4. Installing Packages
```shell
~]# yum install nano
~]# yum provides "*bin/named"
~]# yum localinstall path
```

### 5.2.5. Downloading Packages
Downloaded packages are saved in one of the subdirectories of the cache directory, by default /var/cache/yum/$basearch/$releasever/packages/ directory.

### 5.2.6. Removing Packages
```shell
~]# yum remove totem
```

## 5.3. WORKING WITH PACKAGE GROUPS
### 5.3.1. Listing Package Groups
```shell
~]$ yum groups summary

~]$ yum group list ids

~]# yum group install "KDE Desktop"
~]# yum group install kde-desktop
~]# yum install @"KDE Desktop"
~]# yum install @kde-desktop

~]# yum group remove "KDE Desktop"
~]# yum group remove kde-desktop
~]# yum remove @"KDE Desktop"
~]# yum remove @kde-desktop
```

## 5.4. WORKING WITH TRANSACTION HISTORY
All history data is stored in the history DB in the /var/lib/yum/history/ directory.

### 5.4.1. Listing Transactions
```shell
~]# yum history list
~]# yum history list all
~]# yum history list 1..5
~]# yum history package-list kernel*
```

### 5.4.2. Examining Transactions
```shell
~]# yum history info 4..5
~]# yum history addon-info 4
~]# yum history addon-info 4 config-main
```

### 5.4.3. Reverting and Repeating Transactions
```shell
~]# yum history undo 4
~]# yum history redo 4
```

When managing several identical systems, yum also allows you to perform a transaction on one of them, store the transaction details in a file, and after a period of testing, repeat the same transaction on the remaining systems as well. To store the transaction details to a file, type the following at a shell prompt as root:

```shell
~]# yum -q history addon-info id saved_tx > file_name
```

Once you copy this file to the target system, you can repeat the transaction by using the following command as root:
```shell
~]# yum load-transaction file_name
```

### 5.4.4. Starting New Transaction History
This will create a new, empty database file in the /var/lib/yum/history/ directory. The old transaction history will be kept, but will not be accessible as long as a newer database file is present in the directory.

```shell
~]# yum history new
```

## 5.5. CONFIGURING YUM AND YUM REPOSITORIES
### 5.5.2. Setting [repository] Options
The following is a bare-minimum example of the form a [repository] section takes:
```ini
[repository]
name=repository_name
baseurl=repository_url
```

Replace repository_url with a URL to the directory where the repodata directory of a repository is located:
* If the repository is available over HTTP, use: http://path/to/repo
* If the repository is available over FTP, use: ftp://path/to/repo
* If the repository is local to the machine, use: file:///path/to/local/repo

### 5.5.5. Adding, Enabling, and Disabling a Yum Repository
```shell
~]# yum-config-manager --add-repo repository_url
~]# yum-config-manager --disable repository
```

### 5.5.6. Creating a Yum Repository
1. Install the createrepo package. To do so, type the following at a shell prompt as root:
```shell
~]# yum install createrepo
```

2. Copy all packages that you want to have in your repository into one directory, such as /mnt/local_repo/.

3. Change to this directory and run the following command:
```shell
~]$ cd /mnt/local_repo/
~]$ createrepo --database /mnt/local_repo
```
