#!/bin/bash
if [ -x "$(command -v ufw)" ]; then
  sudo ufw status
else
  sudo iptables -L
fi