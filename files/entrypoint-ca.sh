#!/bin/bash
#
# Entrypoint for our ca container.
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

cp -v /profile /root/.profile
cp -v /profile /home/user1/.profile
cp -v /profile /home/user2/.profile
cp -v /profile /home/user3/.profile

chown -R user1 /home/user1/
chown -R user2 /home/user2/
chown -R user3 /home/user3/

#
# Set up our Principals so that only certain Principals can log in as certain users.
#
mkdir -p /etc/ssh/auth_principals/
echo -e "root\n" > /etc/ssh/auth_principals/root
echo -e "root\nuser1\n" > /etc/ssh/auth_principals/user1
echo -e "user2\n" > /etc/ssh/auth_principals/user2

exec /entry.sh /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config


