#!/bin/bash
#
# Entrypoint for our server container.
#


# Errors are fatal
set -e

/usr/sbin/adduser -D user1
/usr/sbin/adduser -D user2
/usr/sbin/adduser -D user3

/usr/bin/passwd -d user1
/usr/bin/passwd -d user2
/usr/bin/passwd -d user3

mkdir -p /home/user1/.ssh
mkdir -p /home/user2/.ssh
mkdir -p /home/user3/.ssh

cp -v /root/.ssh/authorized_keys /home/user1/.ssh/
cp -v /root/.ssh/authorized_keys /home/user2/.ssh/
cp -v /root/.ssh/authorized_keys /home/user3/.ssh/

chown -R user1 /home/user1/
chown -R user2 /home/user2/
chown -R user3 /home/user3/

exec /entry.sh /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config


