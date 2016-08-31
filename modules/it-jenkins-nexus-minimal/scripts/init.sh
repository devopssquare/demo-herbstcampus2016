#!/bin/bash

# Hotfix/TODO
unset LC_CTYPE

set -eu

dir=`dirname $0`

basedir="${dir}/.."

modulename=`dirname $basedir`
modulename=`dirname $modulename`
modulename=`basename $modulename`
cat<<EOM
======================================================================
Installing "${modulename}"
======================================================================
EOM

sudo=/usr/bin/sudo
test -x $sudo || sudo=

$sudo puppet apply ${basedir}/puppet/init.pp

set +u # Avoid hassles if $TEST_SKIP is not set!
if test -z "${TEST_SKIP}" -o "${TEST_SKIP}" != "false"
   then $dir/test-jenkins.pl
        $dir/test-nexus.pl
fi
set -u
