#!/bin/bash

set -e

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

$sudo apt-get update
$sudo apt-get install -qq puppet
$sudo apt-get update

test -r /etc/puppet/modules/etckeeper || $sudo puppet module install thomasvandoren-etckeeper
test -r /etc/puppet/modules/stdlib || $sudo puppet module install puppetlabs-stdlib

# Avoid warning from initial puppet run
test -r /etc/puppet/hiera.yaml || $sudo touch /etc/puppet/hiera.yaml

$sudo puppet apply "$basedir/puppet/init.pp"
