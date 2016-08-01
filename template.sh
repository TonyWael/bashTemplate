#!/bin/sh
# Simple bash script template that creates a lock file and checks if a user is allowed to run that script

# Run permissions, only the Allowed user may run this script.
ALLOWED_USER="tony"
CURRENT_USER=`whoami`
if ! [ $CURRENT_USER = $ALLOWED_USER ] ; then
   echo "$CURRENT_USER is not allowed to run this script, only $ALLOWED_USER may run this script!"
   exit 1 # terminate and indicate error
fi

# Lock file
LOCKFILE=/tmp/deploy.lock
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "already running"
    exit
fi
# make sure the lockfile is removed when we exit and then claim it
trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

# Load external resources
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/.bashColors


# do stuff
clr_red "foobar"
clr_greenb "foobar"
clr_bold clr_cyan "foobar"
clr_red clr_blueb clr_reverse clr_underscore "foobar"
clr_redb clr_black "RED" -n; clr_blueb clr_black "BLUE" -n; clr_greenb clr_black "GREEN";
clr_escape "foobar" $CLR_BOLD $CLR_CYAN
clr_escape "foobar" 1 36
sleep 60

rm -f ${LOCKFILE}
