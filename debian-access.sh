#!/bin/bash
STEPS="8"
echo "1/$STEPS Check SSH config"
echo
cat /etc/ssh/sshd_config | grep -v "^\s*#" | grep "PermitRootLogin\|PermitEmptyPasswords\|PasswordAuthentication"
echo
echo "Press any key to continue..."
read any_key
echo "2/$STEPS List SSH authorized keys"
echo
for X in $(cut -f6 -d ':' /etc/passwd |sort |uniq); do
    if [ -s "${X}/.ssh/authorized_keys" ]; then
        echo "### ${X}: "
        cat "${X}/.ssh/authorized_keys"
        echo ""
    fi
done
echo
echo "Press any key to continue..."
read any_key
echo "Bye!"
