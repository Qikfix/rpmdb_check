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
  rpm -qa &>/tmp/full_list.log
  count=$(cat /tmp/full_list.log | wc -l)
  echo "Total # of entries on RPMdb: $count"
  echo "el6 packages ..: $(grep el6 /tmp/full_list.log | wc -l)"
  echo "el7 packages ..: $(grep el7 /tmp/full_list.log | wc -l)"
  echo "el8 packages ..: $(grep el8 /tmp/full_list.log | wc -l)"
  echo "el9 packages ..: $(grep el9 /tmp/full_list.log | wc -l)"
  echo ""
  echo "Packages with no version ..: $(grep -v -E '(el6|el7|el8|el9)' /tmp/full_list.log | wc -l)"
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

check_basesystem_yumhistory()
{
  # Checking the yum history and basesystem
  echo -e "\n# Checking the yum history and basesystem rpm package"
  echo "---"
  yum history info 1 | grep -E '(^Transaction ID|^Begin time|^Releasever)'
  echo
  rpm -q --last basesystem
  echo
  echo
  date_from_yum_history=$(yum history info 1 | grep -E '(^Begin time)' | cut -d: -f2 | sed 's/^ //g')
  date_from_rpm=$(rpm -q --last basesystem | awk '{print $2, $3, $4, $5, $6}' | cut -d: -f1)
  if [ "$date_from_yum_history" == "$date_from_rpm" ]; then
    echo "They match: $date_from_rpm"
  else
    echo "Something is weird, basesystem and first installation are not matching"
  fi
  echo "---"
}

check_required_files_around()
{
  PACKAGES_FILE="/var/lib/rpm/Packages"
  # Checking the Packages file
  echo -e "\n# Checking the Packages file"
  echo "---"
  if [ -f $PACKAGES_FILE ]; then
    ls -l $PACKAGES_FILE
    echo
    du  -ks $PACKAGES_FILE
    echo
    du -hs $PACKAGES_FILE
    echo
    file $PACKAGES_FILE
    echo
    stat $PACKAGES_FILE
  else
    echo "No '$PACKAGES_FILE' around"
  fi
  echo "---"
}


# Main section here
# check_requirements
# check_corrupt_rpmdb
# count_rpmdb_entries
# check_duplicate_entries
# check_duplicate_entries_package_cleanup
# lsof_rpmdb_files
# check_dependencies_problems
# check_basesystem_yumhistory
check_required_files_around