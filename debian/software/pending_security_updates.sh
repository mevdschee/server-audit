#!/bin/bash
apt-get -s upgrade | grep "^Inst" | grep -i "security" | wc -l
