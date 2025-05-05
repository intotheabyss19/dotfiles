#!/bin/bash
# Overall CPU usage
OVERALL=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
# Per-core usage from mpstat (assuming 12 cores)
CORES=$(mpstat -P ALL 1 1 | tail -n 12 | awk '{print "Core " $2 ": " int(100 - $12) "%"}' | tr '\n' ', ' | sed 's/, $//')

echo " ${OVERALL}%"
echo " ${OVERALL}%"
echo "#FFFFFF"
echo "Cores: ${CORES}"
