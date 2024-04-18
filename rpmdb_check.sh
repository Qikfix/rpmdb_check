#!/bin/bash

check_corrupt_rpmdb()
{
  # Checking if the rpmdb is corrupt
  echo -e "\n# Corrupt RPMdb"
  echo "---"
  rpm -qa &>/dev/null
  if [ $? -ne 0 ]; then
    echo "The RPMdb is corrupt"
  else
    echo "The RPMdb is NOT corrupt"
  fi
  echo "---"
}

count_rpmdb_entries()
{
  # Checking the number of entries on the rpmdb. We can for sure
  # improve this func to match some additional info
  echo -e "\n# RPMdb Entries"
  echo "---"
  count=$(rpm -qa | wc -l)
  echo "Total # of entries on RPMdb: $count"
  echo "---"
}

check_duplicate_entries()
{
  # Checking for some duplicate entries on rpmdb
  # https://access.redhat.com/solutions/3924551
  echo -e "\n# RPMdb Duplicate entries"
  echo "---"
  yum check &> /tmp/yumcheck
  grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep -v "\:"
  grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep ":" | awk -F':' '{ print $NF }'
  echo "---"
}

check_corrupt_rpmdb
count_rpmdb_entries
check_duplicate_entries