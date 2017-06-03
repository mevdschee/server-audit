#!/bin/bash
sudo netstat -plnt | awk 'NR > 2 { printf $1" "$4" "; split($7,pid,"/"); system("ps --pid "pid[1]" -o comm= | cat") }'