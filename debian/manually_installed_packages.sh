#!/bin/bash
comm -13 \
  <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort) \
  <(comm -23 \
    <(dpkg-query -W -f='${Package}\n' | sed 1d | sort) \
    <(apt-mark showauto | sort) \
  ) | while read NAME
do
    REPO=$(apt-cache policy "$NAME" | grep -io "http[^ ]* [^ /]*" | head -n1)
    echo "$NAME: $REPO"
done