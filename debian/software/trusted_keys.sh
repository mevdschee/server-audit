#!/bin/bash
apt-key list | grep "^uid" | tr -s " " | cut -d\  -f2-