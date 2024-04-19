#!/bin/bash

check_requirements()
{
  # Check the requirements
  which lsof &>/dev/null
  if [ $? -ne 0 ]; then
    echo "Please, install the lsof package"
    echo "exiting ..."
    exit 1
  fi

  which package-cleanup &>/dev/null
  if [ $? -ne 0 ]; then
    echo "Please, install the yum-utils package"
    echo "exiting ..."
    exit 1
  fi

}

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
  echo -e "\n# RPMdb Duplicate entries (this can take some time ...)"
  echo "---"
  yum check &> /tmp/yumcheck
  grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep -v "\:"
  grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep ":" | awk -F':' '{ print $NF }'
  echo "---"
}

check_duplicate_entries_package_cleanup()
{
  # Checking for some duplicate entries on rpmdb
  echo -e "\n# RPMdb Duplicate entries using package-cleanup"
  echo "---"
  package-cleanup --dupes
  echo "---"
}

lsof_rpmdb_files()
{
  # Checking the processes on the /var/lib/rpm/*
  echo -e "\n# Processes on RPMdb files"
  echo "---"
  lsof /var/lib/rpm/*
  echo "---"
}

check_dependencies_problems()
{
  # Checking the dependencies problems
  echo -e "\n# Checking the dependencies problems on RPMdb"
  echo "---"
  package-cleanup --problems
  echo "---"
}

# Main section here
check_requirements
check_corrupt_rpmdb
count_rpmdb_entries
check_duplicate_entries
check_duplicate_entries_package_cleanup
lsof_rpmdb_files
check_dependencies_problems