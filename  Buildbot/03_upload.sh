#!/bin/bash

# Note:
# This script is meant to be run from the root of the working copy.
# 
# This script sets the name of the .dmg and dSYM bundle and then uploads them.

# Config
bran="-2.3svn"
revt="-r`svnversion -n`"
dmg_bn="warzone2100"
dmg_nv="-novideo.dmg"
tar_dS="-dSYM.tar.gz"


# Upload the dSYM bundle
if ! scp -l 160 macosx/build/dmgout/out/${dmg_bn}${tar_dS} buildbot@buildbot.pc-dummy.net:public_html/${dmg_bn}${bran}${revt}${tar_dS}; then
	exit ${?}
fi

# Upload the .dmg
if ! scp -l 160 macosx/build/dmgout/out/${dmg_bn}${dmg_nv} buildbot@buildbot.pc-dummy.net:public_html/${dmg_bn}${bran}${revt}.dmg; then
	exit ${?}
fi


# Link up the current .dmg
ssh buildbot@buildbot.pc-dummy.net -C "cd public_html/ && ln -fs ${dmg_bn}${bran}${revt}.dmg ${dmg_bn}${bran}-current.dmg"