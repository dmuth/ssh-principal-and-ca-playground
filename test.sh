#!/bin/bash
#
# Thie script runs a full test of our Snowdrift functionality.
#
# AFAIK, testing frameworks for bash don't really exist, so 
# I'm gonna have to improvise here.
#

# Errors are fatal
set -e

#
# Define ANSI for our colors (and turning off the color)
#
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"

NUM_PASS=0
NUM_FAIL=0

#
# Print success message.
#
function pass() {
	NUM_PASS=$(( NUM_PASS + 1 ))
	printf "[ ${GREEN}PASS${NC} ] "
	echo $@
}


#
# Print a fail message
#
function fail() {
	NUM_FAIL=$(( NUM_FAIL + 1 ))
	printf "[ ${RED}FAIL${NC} ] "
	echo $@
}


#
# Turn off fatal errors, run the command, get the return value, turn fatal errors
# back on, and check the return value.
#
function run() {
	
	# 
	# See if we're inverting the logic.
	# fail_ok means that we expect this command to fail, and if it doesn't, THAT is a failure.
	#
	local FAIL_OK=""
	if test "$1" == "fail_ok"
	then
		FAIL_OK=1
		shift
	fi

	set +e
	$@ > /dev/null
	RETVAL=$?
	set -e

	if test $RETVAL -eq 0
	then
		if test "$FAIL_OK" == ""
		then
			pass $@
		else
			fail $@
		fi

	else
		if test "$FAIL_OK" == ""
		then
			fail $@
		else
			pass $@
		fi

	fi

} # End of test()


run docker-compose exec client ssh root@server whoami
run docker-compose exec client ssh user1@server whoami
run docker-compose exec client ssh user2@server whoami
run docker-compose exec client ssh user3@server whoami
run fail_ok docker-compose exec client ssh userFAIL@server whoami

run docker-compose exec client ssh root@ca whoami
run docker-compose exec client ssh user1@ca whoami
run docker-compose exec client ssh user2@ca whoami
run fail_ok docker-compose exec client ssh user3@ca whoami
run fail_ok docker-compose exec client ssh userFAIL@ca whoami

printf "Results:  Num Passes: ${GREEN}%d${NC}     Num Fails: ${RED}%d${NC}\n" $NUM_PASS $NUM_FAIL

if test $NUM_FAIL -eq 0
then
	printf "Overall: ${GREEN}PASS${NC}\n"

else
	printf "Overall: ${RED}FAIL${NC}\n"

fi



# TODO:
# - ssh to server with each user (root, user1-3)
# - test bad users as well
# - ssh to ca with each user (root, user1, user2)
# - test bad users as well
# - keygen
# - stand up docker


echo "# Done!"



