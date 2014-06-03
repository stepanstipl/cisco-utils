#!/bin/bash

FILE=$1
UNUSED_OBJECTS_3="name object-group"

for object in ${UNUSED_OBJECTS_3}; do

    for i in $(grep "^${object}" ${FILE} | awk '{print $3}' | sort | uniq); do 
        grep -E ${i} ${FILE} | grep -v -q "^${object}" || grep -E "^${object}.*${i}( description.*)?$" ${FILE} | sed 's/^/no /'
    done

done

UNUSED_ACL="access-list"
for object in ${UNUSED_ACL}; do

    for i in $(grep "^${object}" ${FILE} | awk '{print $2}' | sort | uniq); do 
        grep ${i} ${FILE} | grep -v -q "^${object}" || echo "clear configure access-list ${i}"; 
    done

done
