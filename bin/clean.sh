#!/bin/bash
#
# This script will remove all traces of a container, rebuild it, and start it up.
#

# Errors are fatal
set -e

CONTAINER=""

if test "$1" == "-h" -o "$1" == "--help"
then
	echo "! "
	echo "! Syntax: $0 [ CONTAINER_NAME ]"
	echo "! "
	echo "! This script will kill, remove, (re)build, and run all containers, or a"
	echo "! specific container if named."
	echo "! "
	exit 1

elif test "$1"
then
	CONTAINER=$1
fi

docker-compose kill ${CONTAINER} || true
docker-compose rm -f ${CONTAINER} || true
docker-compose build ${CONTAINER}
docker-compose up -d ${CONTAINER}



