#!/bin/bash
STEPS="8"
echo "1/$STEPS List apt's upgradable packages"
echo
echo -n "Uninstalled security updates: " 
apt-get -s upgrade | grep "^Inst" | grep -i "security" | wc -l
echo -n "Uninstalled updates in total: " 
apt-get -s upgrade | grep "^Inst" | wc -l
read any_key
echo "2/$STEPS List apt's repository URLs"
echo
apt-cache policy | grep -io "http[^ ]* [^ /]*" | sort | uniq
read any_key
echo "3/$STEPS List apt's list of trusted keys"
echo
apt-key list | grep "^uid"
read any_key
echo "4/$STEPS List apt manual installed packages"
echo
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
read any_key
echo "5/$STEPS Check SSH config"
echo
cat /etc/ssh/sshd_config | grep -v "^\s*#" | grep "PermitRootLogin\|PermitEmptyPasswords\|PasswordAuthentication"
read any_key
echo "6/$STEPS List SSH authorized keys"
echo
for X in $(cut -f6 -d ':' /etc/passwd |sort |uniq); do
    if [ -s "${X}/.ssh/authorized_keys" ]; then
        echo "### ${X}: "
        cat "${X}/.ssh/authorized_keys"
        echo ""
    fi
done
read any_key
echo "Bye!"
