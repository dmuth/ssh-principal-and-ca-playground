#!/bin/bash
#
# This script will show the logs of all servers or a specific server.
#

# Errors are fatal
set -e

CONTAINER=""

if test "$1" == "-h" -o "$1" == "--help"
then
	echo "! "
	echo "! Syntax: $0 [ [ options ] [ CONTAINER_NAME [ CONTAINER_NAME ] ]"
	echo "! "
	echo "! This script will show the logs of 1 or more of our containers."
	echo "! "
	echo "! "
	exit 1

fi

docker-compose logs $@



