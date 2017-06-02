#!/bin/bash
apt-get -s upgrade | grep "^Inst" | wc -l