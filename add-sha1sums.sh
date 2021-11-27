#!/bin/bash 
#
# For crude generation of proprietary-files.txt
#

if [ -e $PWD/proprietary-files.txt.tmp ]; then

  rm $PWD/proprietary-files.txt.tmp

fi

for file in $(find $* -type f); do

  if SHA1SUM=$(sha1sum ${file} ||true); then

    SHA1SUM=$(sha1sum ${file})
	SHA1SUM=$(echo "${file}|${SHA1SUM}" |cut -d ' ' -f 1)
    echo ${SHA1SUM}
    echo ${SHA1SUM} >> proprietary-files.txt.tmp

  fi

done

if [ -e $PWD/proprietary-files.txt.tmp ]; then

  echo
  echo "READ FROM TMP FILE:"
  echo
  cat proprietary-files.txt.tmp
  echo

  fi

read -p "Press ENTER to append CTRL+C to cancel"
cat proprietary-files.txt.tmp >> proprietary-files.txt
