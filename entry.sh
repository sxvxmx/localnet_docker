#!/bin/bash
ssh-keygen -A

# start sshd 
/usr/sbin/sshd

user cassandra

# original cassandra entrypoint
exec /usr/local/bin/docker-entrypoint.sh "$@"
