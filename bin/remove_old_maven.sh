#!/usr/bin/env bash
M2_REPO=${HOME}/.m2
OLDFILES=/tmp/deleted_artifacts.txt
DAYS=${1:-60}

echo "Removing artifacts not used in the last ${DAYS} days"
echo "Calculating current M2 size"
size=`du -sm ${M2_REPO}`
size=${size//[[:space:]]*/}
echo "The current size is: ${size} Mb"
echo "Cleaning up ..."

if [ -f ${OLDFILES} ]
	then
		rm ${OLDFILES}
	fi

find "${M2_REPO}" -name '*.pom' -atime +${DAYS} -exec dirname {} \; >> ${OLDFILES}
for x in `cat ${OLDFILES}`;
	do
	#echo "deleting $x"
	rm -rf "$x";
done

new_size=`du -sm ${M2_REPO}`
new_size=${new_size//[[:space:]]*/}
echo "Size after cleanup: ${new_size} Mb"
echo "You've saved $(($size-$new_size)) Mb"

#clean up
rm ${OLDFILES}
