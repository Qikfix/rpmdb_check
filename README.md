# rpmdb_check

**Disclaimer**: This project scripts are `NOT` delivered and/or released by Red Hat. This is an independent project to help customers and Red Hat Support team to analyze the `rpmdb` for troubleshooting purposes.

This script will do some queries, just to check the integrity of RPMdb.

Here you can see an example
```
# ./rpmdb_check.sh 

# Corrupt RPMdb
---
The RPMdb is NOT corrupt
---

# RPMdb Entries
---
Total # of entries on RPMdb: 1212
el6 packages ..: 0
el7 packages ..: 0
el8 packages ..: 1210
el9 packages ..: 0

Packages with no version ..: 2
---

# RPMdb Duplicate entries (this can take some time ...)
---
---

# RPMdb Duplicate entries using package-cleanup
---
Updating Subscription Management repositories.
Last metadata expiration check: 3:26:18 ago on Thu 18 Apr 2024 09:28:09 PM UTC.
---

# Processes on RPMdb files
---
---

# Checking the dependencies problems on RPMdb
---
Updating Subscription Management repositories.
Last metadata expiration check: 3:26:35 ago on Thu 18 Apr 2024 09:28:09 PM UTC.
---

# Checking the yum history and basesystem rpm package
---
Transaction ID : 1
Begin time     : Fri 09 Jun 2023 12:19:11 AM UTC
Releasever     : 8.6

basesystem-11-5.el8.noarch                    Fri 09 Jun 2023 12:19:28 AM UTC


They match: Fri 09 Jun 2023 12
---

# Checking the Packages file
---
-rw-r--r--. 1 root root 242688000 Apr 22 17:43 /var/lib/rpm/Packages

237004  /var/lib/rpm/Packages

232M    /var/lib/rpm/Packages

/var/lib/rpm/Packages: , created: Thu Jan  1 00:34:08 1970, modified: Thu Jan  1 05:24:22 1970

  File: /var/lib/rpm/Packages
  Size: 242688000       Blocks: 474008     IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 201326727   Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:rpm_var_lib_t:s0
Access: 2024-04-22 19:53:42.175803315 +0000
Modify: 2024-04-22 17:43:53.824862577 +0000
Change: 2024-04-22 19:53:34.851601620 +0000
 Birth: 2023-06-09 00:19:00.141728502 +0000
---
```

Please, check the [Issues page](https://github.com/Qikfix/rpmdb_check/issues) for the features that will be around soon, if your request is not there, please, feel free to create a [new issue](https://github.com/Qikfix/rpmdb_check/issues/new).


We hope you enjoy it.