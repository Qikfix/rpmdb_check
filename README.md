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
```

Please, check the [Issues page](https://github.com/Qikfix/rpmdb_check/issues) for the features that will be around soon, if your request is not there, please, feel free to create a [new issue](https://github.com/Qikfix/rpmdb_check/issues/new).


We hope you enjoy it.