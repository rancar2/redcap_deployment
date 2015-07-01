#!/bin/bash

export REDCAP_ROOT=/var/www/redcap
export REDCAP_HOOKS=$REDCAP_ROOT/hooks
export INPUT=$1

if [ ! -e $REDCAP_ROOT ]; then
    echo "Error: REDCAP_ROOT, $REDCAP_ROOT, does not exist.  Exiting."
    exit
fi

# Pull repo and copy scripts into library folder
MYTEMP=`mktemp -d`
cd $MYTEMP
git clone https://github.com/ctsit/redcap-extras.git
cd redcap-extras/hooks
# checkout develop because we have not yet released the code we need
git checkout develop
cp redcap_hooks.php $REDCAP_HOOKS/
mkdir $REDCAP_HOOKS/library
cp -r examples/* $REDCAP_HOOKS/library/
rm -rf $MYTEMP

# Make required directories for hook deployment
awk -F"," '{ OFS = "/" } ; NR!=1{print $1,$2}' $INPUT | xargs -I % mkdir -p $REDCAP_HOOKS/%

# Create sym links for hooks to be executed
awk -F"," 'NR!=1{printf "ln -s %s/%s %s/%s/%s/\n",ENVIRON["REDCAP_HOOKS"],$3,ENVIRON["REDCAP_HOOKS"],$1,$2}' $INPUT | sh

#