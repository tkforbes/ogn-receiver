#!/bin/bash
# Script to start capturing flight logs to a log file.  

# If mount does not exist, exit
grep -qs '/data' /proc/mounts || exit 0

# Need this hack to allow sourcing from a file in dos format
source /dev/stdin < <(dos2unix < /boot/OGN-receiver.conf)

# magic delay because the service does not seem to be able to coordinate
# with system time being set properly
sleep 60

# Timestamp log file
current_time=$(date -u "+%Y%m%dT%H%M%SZ")
new_fileName=/data/ogn/log/${ReceiverName}-${current_time}.log

# Start netcat and capture log output
nc localhost 50001 >> $new_fileName
