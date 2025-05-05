#!/bin/bash
# Get storage info for root partition (change / to another mount point if needed)
USED=$(df -h / | tail -1 | awk '{print $3}')
TOTAL=$(df -h / | tail -1 | awk '{print $2}')
PERCENT=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')

echo " ${PERCENT}%"
echo " ${PERCENT}%"
echo "#FFFFFF"
echo "Used: ${USED} / Total: ${TOTAL}"
