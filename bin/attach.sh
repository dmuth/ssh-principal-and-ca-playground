#!/bin/bash
#
# This script will attach to a container with a bash shell.
#

# Errors are fatal
set -e

CONTAINER=""

if test "$1" == "" -o "$1" == "-h" -o "$1" == "--help"
then
	echo "! "
	echo "! Syntax: $0 [ CONTAINER_NAME ]"
	echo "! "
	echo "! This script will kill, remove, (re)build, and run all containers, or a"
	echo "! specific container if named."
	echo "! "
	exit 1

fi

CONTAINER=$1

docker-compose exec ${CONTAINER} bash


