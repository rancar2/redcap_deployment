#!/bin/bash
set -e

export MYTARGETDIR=$1

# determine the directory where this script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# get source files
TEMPDIR=`mktemp -d`
git clone https://github.com/ctsit/form_render_skip_logic.git $TEMPDIR

# If you need to checkout code from another branch, uncomment and adjust this line
# git --git-dir=$TEMPDIR/.git --work-tree=$TEMPDIR checkout develop

# copy files to the correct target locations
mkdir -p $MYTARGETDIR
cp $TEMPDIR/frsl_data_collection_instruments.php $MYTARGETDIR
cp $TEMPDIR/frsl_record_home_page.php $MYTARGETDIR
cp $TEMPDIR/frsl_dashboard.php $MYTARGETDIR

rm -rf $TEMPDIR
