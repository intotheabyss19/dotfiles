#!/bin/bash
USED=$(free -h | awk '/^Mem:/ {print $3}')
TOTAL=$(free -h | awk '/^Mem:/ {print $2}')
PERCENT=$(free -m | awk '/^Mem:/ {print int($3*100/$2)}')

echo " ${PERCENT}%"
echo " ${PERCENT}%"
echo "#FFFFFF"
echo "Used: ${USED} / Total: ${TOTAL}"
