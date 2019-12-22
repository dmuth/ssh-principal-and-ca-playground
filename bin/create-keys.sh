#!/bin/bash
#
# This script will create all of our SSH keys.
#

# Errors are fatal
set -e

# Go to our main directory
pushd $(dirname $0/)/.. > /dev/null


#
# Set write access to any existing keys. (they are set to 400 by our containers)
#
echo "# "
echo "# Setting any existing keys to writeable"
echo "# "
mkdir -p keys/
chmod u+w keys/* || true

echo "# "
echo "# Generating user key."
echo "# "
yes | ssh-keygen -t ecdsa -C "My key" -N "" -f keys/my-key

echo "# "
echo "# Generating CA key."
echo "# "
yes | ssh-keygen -t ecdsa -C "CA" -N "" -f keys/ca

echo "# Done!"

