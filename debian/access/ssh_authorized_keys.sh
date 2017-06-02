#!/bin/bash
for X in $(cut -f6 -d ':' /etc/passwd |sort |uniq); do
    if [ -s "${X}/.ssh/authorized_keys" ]; then
        echo "### ${X}: "
        cat "${X}/.ssh/authorized_keys"
        echo ""
    fi
done