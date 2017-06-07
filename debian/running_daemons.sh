#!/bin/bash
sudo netstat -plnt | awk 'NR > 2 { split($7,pid,"/"); printf $1" "$4" pid:"pid[1]" "; system("ps --pid "pid[1]" -o cmd= | awk {print\\ \\$1}") }'
