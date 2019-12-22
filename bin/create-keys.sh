#!/bin/bash
#
# This script will create all of our SSH keys.
#

# Errors are fatal
set -e

# Go to our main directory
pushd $(dirname $0/)/.. > /dev/null

if test "$1" == "-h" -o "$1" == "--help"
then
	echo "! "
	echo "! Syntax: $0 [ -v ] "
	echo "! "
	echo "! -v Print output from underlying SSH key generation commands."
	echo "! "
	exit 1
fi

VERBOSE=""
if test "$1" == "-v"
then
	VERBOSE=1
fi


#
# Wrapper function to run our command, and /dev/null the output unless we're in verbose mode.
#
function cmd() {

	if test ! "$VERBOSE"
	then
		$@ > /dev/null
	else
		$@
	fi

} # End of cmd()


#
# Wrapper function that will run ssh-keygen with a supplied command and no
# password.
#
# If this function seems unecessary and dumb, so is how bash handles trying to
# escape quotes sent into functions.
#
function cmd_comment_no_pass() {

	COMMENT=$1
	shift

	if test ! "$VERBOSE"
	then
		ssh-keygen -t ecdsa -C "${COMMENT}" -N "" $@ > /dev/null
	else
		ssh-keygen -t ecdsa -C "${COMMENT}" -N "" $@
	fi

} # End of cmd_comment_no_pass()


#
# Set write access to any existing keys. (they are set to 400 by our containers)
#
echo "# "
echo "# Setting any existing keys to writeable"
echo "# "
mkdir -p keys/
cd keys/
rm -fv * > /dev/null
touch empty

echo "# "
echo "# Generating user key."
echo "# "
cmd_comment_no_pass "My key" -f my-key

echo "# "
echo "# Generating CA key."
echo "# "
cmd_comment_no_pass "CA" -f ca

echo "# "
echo "# Signing user key with CA key"
echo "# "
cmd ssh-keygen -s ca -I playground -n root,user2 -V +1w -z 1 my-key.pub

cmd ssh-keygen -L -f ./my-key-cert.pub

echo "# Done!"



