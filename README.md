# rpmdb_check

**Disclaimer**: This project scripts are `NOT` delivered and/or released by Red Hat. This is an independent project to help customers and Red Hat Support team to analyze the `rpmdb` for troubleshooting purposes.

This script will do some queries, just to check the integrity of RPMdb.

Note that you can run this script in a local server, or run it against a 3rd party `rpmdb`

To Deploy
```
wget https://raw.githubusercontent.com/Qikfix/rpmdb_check/main/rpmdb_check.sh
chmod +x rpmdb_check.sh
```
And that's it! :-)


Now, let' s take a look on how this works.
```
./rpmdb_check.sh 
# Missing parameters

Please, call the script passing the parameter as presented below

./rpmdb_check.sh --local

or

./rpmdb_check.sh --data <path_to_the_rpmdb>
```
Note: In the `path_to_the_rpmdb`, you need to keep the structure, for example `/var/lib/rpm/`, so, assuming that you are using your `/tmp`, you can pass the path `/tmp`, but the tree should be something like `/tmp/var/lib/rpm/*`.


Here you can see an example consuming the local `rpmdb`
```
./rpmdb_check.sh --local

# Corrupt RPMdb

    # rpm -qa &>/dev/null
---
The RPMdb is NOT corrupt
---

# RPMdb Entries

   # rpm -qa &>/tmp/full_list.log
   # grep el6 /tmp/full_list.log | wc -l
   # grep el7 /tmp/full_list.log | wc -l
   # grep el8 /tmp/full_list.log | wc -l
   # grep el9 /tmp/full_list.log | wc -l
   # grep -v -E '(el6|el7|el8|el9)' /tmp/full_list.log | wc -l
---
Total # of entries on RPMdb: 1213
el6 packages ..: 0
el7 packages ..: 0
el8 packages ..: 1211
el9 packages ..: 0

Packages with no version ..: 2
---

# RPMdb Duplicate entries (this can take some time ...)

   # yum check &> /tmp/yumcheck
   # grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep -v "\:"
   # grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep ":" | awk -F':' '{ print $NF }'
---
---

# RPMdb Duplicate entries using package-cleanup

    # package-cleanup --dupes
---
Updating Subscription Management repositories.
Last metadata expiration check: 0:35:17 ago on Mon 29 Apr 2024 09:43:57 AM UTC.
---

# Processes on RPMdb files
---
---

# Checking the dependencies problems on RPMdb

    # package-cleanup --problems
---
Updating Subscription Management repositories.
Last metadata expiration check: 0:35:36 ago on Mon 29 Apr 2024 09:43:57 AM UTC.
---

# Checking the yum history and basesystem rpm package

    # yum history info 1 | grep -E '(^Transaction ID|^Begin time|^Releasever)'
    # rpm -q --last basesystem
---
Transaction ID : 1
Begin time     : Fri 09 Jun 2023 12:19:11 AM UTC
Releasever     : 8.6

basesystem-11-5.el8.noarch                    Fri 09 Jun 2023 12:19:28 AM UTC


They match: Fri 09 Jun 2023 12
---

# Checking the Packages file

    # ls -l /var/lib/rpm/Packages
    # du -ks /var/lib/rpm/Packages
    # file /var/lib/rpm/Packages
    # stat /var/lib/rpm/Packages
---
-rw-r--r--. 1 root root 242688000 Apr 29 08:50 /var/lib/rpm/Packages

237004  /var/lib/rpm/Packages

232M    /var/lib/rpm/Packages

/var/lib/rpm/Packages: , created: Thu Jan  1 00:34:08 1970, modified: Thu Jan  1 05:24:18 1970

  File: /var/lib/rpm/Packages
  Size: 242688000       Blocks: 474008     IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 201326727   Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:rpm_var_lib_t:s0
Access: 2024-04-29 08:50:09.969942343 +0000
Modify: 2024-04-29 08:50:09.832938624 +0000
Change: 2024-04-29 08:50:09.832938624 +0000
 Birth: 2023-06-09 00:19:00.141728502 +0000
---
```

And here, consuming a 3rd party `rpmdb`
```
./rpmdb_check.sh --data /test

# Corrupt RPMdb

    # rpm --root=/test -qa &>/dev/null
---
The RPMdb is NOT corrupt
---

# RPMdb Entries

   # rpm --root=/test -qa &>/tmp/full_list.log
   # grep el6 /tmp/full_list.log | wc -l
   # grep el7 /tmp/full_list.log | wc -l
   # grep el8 /tmp/full_list.log | wc -l
   # grep el9 /tmp/full_list.log | wc -l
   # grep -v -E '(el6|el7|el8|el9)' /tmp/full_list.log | wc -l
---
Total # of entries on RPMdb: 437
el6 packages ..: 0
el7 packages ..: 0
el8 packages ..: 435
el9 packages ..: 0

Packages with no version ..: 2
---

# RPMdb Duplicate entries (this can take some time ...)

   # yum --installroot=/test check &> /tmp/yumcheck
   # grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep -v "\:"
   # grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep ":" | awk -F':' '{ print $NF }'
---
---

# RPMdb Duplicate entries using package-cleanup

    # package-cleanup --installroot=/test --dupes
---
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use subscription-manager to register.

Last metadata expiration check: 0:35:15 ago on Mon 29 Apr 2024 09:46:22 AM UTC.
---

# Processes on RPMdb files
    ## Nothing to do! Checking in non local rpmdb

# Checking the dependencies problems on RPMdb

    # package-cleanup --installroot=/test --problems
---
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use subscription-manager to register.

Last metadata expiration check: 0:35:23 ago on Mon 29 Apr 2024 09:46:22 AM UTC.
---

# Checking the yum history and basesystem rpm package

    # yum --installroot=/test history info 1 | grep -E '(^Transaction ID|^Begin time|^Releasever)'
    # rpm --root=/test -q --last basesystem
---
No transactions
Error: Failed history info

basesystem-11-5.el8.noarch                    Tue 24 Oct 2023 04:37:57 PM UTC


No transactions
Error: Failed history info
Something is weird, basesystem and first installation are not matching
---

# Checking the Packages file

    # ls -l /test/var/lib/rpm/Packages
    # du -ks /test/var/lib/rpm/Packages
    # file /test/var/lib/rpm/Packages
    # stat /test/var/lib/rpm/Packages
---
-rw-r--r--. 1 root root 28954624 Apr 23 18:30 /test/var/lib/rpm/Packages

28276   /test/var/lib/rpm/Packages

28M     /test/var/lib/rpm/Packages

/test/var/lib/rpm/Packages: , created: Thu Jan  1 00:34:08 1970, modified: Thu Jan  1 01:07:09 1970

  File: /test/var/lib/rpm/Packages
  Size: 28954624        Blocks: 56552      IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 1006733016  Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: unconfined_u:object_r:default_t:s0
Access: 2024-04-29 08:56:42.272590292 +0000
Modify: 2024-04-23 18:30:48.000000000 +0000
Change: 2024-04-29 08:56:35.300401057 +0000
 Birth: 2024-04-29 08:56:35.211398641 +0000
---
```

Please, check the [Issues page](https://github.com/Qikfix/rpmdb_check/issues) for the features that will be around soon, if your request is not there, please, feel free to create a [new issue](https://github.com/Qikfix/rpmdb_check/issues/new).


We hope you enjoy it.