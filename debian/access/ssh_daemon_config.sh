#!/bin/bash
echo "/etc/ssh/sshd_config:"
if [ -e "/etc/ssh/sshd_config" ]; then
  cat /etc/ssh/sshd_config \
  | grep -v "^\s*#" \
  | grep "ChallengeResponseAuthentication\|PasswordAuthentication\|PermitRootLogin" \
  | diff -b - <(printf "ChallengeResponseAuthentication no\nPasswordAuthentication no\nPermitRootLogin no\n") \
  | grep "^<\|^>" \
  | sort -d
else
  echo "File does not exist"
fi