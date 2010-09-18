#!/bin/bash

# Config
pathd="${HOME}/Applications/Build/wz2100/trunk"
urld="https://warzone2100.svn.sourceforge.net/svnroot/warzone2100/trunk/"
dmg_bn="warzone2100"
dmg_nv="-novideo.dmg"
dmg_lv="-lqvideo.dmg"
dmg_hv="-hqvideo.dmg"
tar_dS="-dSYM.tar.gz"


# Checkout
cd "${pathd}"
if ! svn checkout ${urld} .; then
    echo "Unable to fetch Trunk"
    svn cleanup
    exit 1
fi

# Get rev
rtag="r`svnversion -n`"

# Build
cd macosx
if ! xcodebuild -project Warzone.xcodeproj -parallelizeTargets -target "Make DMGs for Release" -configuration Release; then
    if ! xcodebuild -project Warzone.xcodeproj -parallelizeTargets -target "Make DMGs for Release" -configuration "Release" -PBXBuildsContinueAfterErrors=NO; then
	    echo "The build has failed with the preceding error."
	    exit 1
	fi
fi

# Rename and md5
cd build/dmgout/out

if [ -f "${dmg_bn}${dmg_nv}" ]; then
    mv "${dmg_bn}${dmg_nv}" "${dmg_bn}-${rtag}${dmg_nv}"
    md5 -q "${dmg_bn}-${rtag}${dmg_nv}">"${dmg_bn}-${rtag}${dmg_nv}.md5"
else
    echo "${dmg_bn}${dmg_nv} does not exist, skipping"
fi

if [ -f "${dmg_bn}${dmg_lv}" ]; then
    mv "${dmg_bn}${dmg_lv}" "${dmg_bn}-${rtag}${dmg_lv}"
    md5 -q "${dmg_bn}-${rtag}${dmg_lv}">"${dmg_bn}-${rtag}${dmg_lv}.md5"
else
    echo "${dmg_bn}${dmg_lv} does not exist, skipping"
fi

if [ -f "${dmg_bn}${dmg_hv}" ]; then
    mv "${dmg_bn}${dmg_hv}" "${dmg_bn}-${rtag}${dmg_hv}"
    md5 -q "${dmg_bn}-${rtag}${dmg_hv}">"${dmg_bn}-${rtag}${dmg_hv}.md5"
else
    echo "${dmg_bn}${dmg_hv} does not exist, skipping"
fi

if [ -f "${dmg_bn}${tar_dS}" ]; then
    mv "${dmg_bn}${tar_dS}" "${dmg_bn}-${rtag}${tar_dS}"
    md5 -q "${dmg_bn}-${rtag}${tar_dS}">"${dmg_bn}-${rtag}${tar_dS}.md5"
else
    echo "${dmg_bn}${tar_dS} does not exist, skipping"
fi
# Open upload app
open /Applications/FileZilla.app
