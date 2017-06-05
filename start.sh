#!/bin/bash
grep "DISTRIB_DESCRIPTION" /etc/lsb-release | sed 's/"//g' | awk '{split($0,a,"="); print a[2]}'
for file in debian/*
do
    echo && echo ${file}:
    bash $file
done