#!/bin/bash
# Script to stop capturing flight logs to a log file.  

# If mount does not exist, exit
grep -qs '/extlogs' /proc/mounts || exit 0

ps -ef | grep 
NC_PID=`ps -ef | grep "nc localhost 50001" | grep -v grep | awk '{print $2}'`
kill $NC_PID
