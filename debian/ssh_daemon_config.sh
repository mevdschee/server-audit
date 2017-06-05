#!/bin/bash
if [ -e "/etc/ssh/sshd_config" ]; then
  echo "/etc/ssh/sshd_config:" && cat /etc/ssh/sshd_config \
  | grep -v "^\s*#" \
  | grep "ChallengeResponseAuthentication\|PasswordAuthentication\|PermitRootLogin" \
  | diff -b - <(printf "ChallengeResponseAuthentication no\nPasswordAuthentication no\nPermitRootLogin no\n") \
  | grep "^<\|^>" \
  | sort -d
fi