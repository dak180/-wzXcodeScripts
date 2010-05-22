#!/bin/bash

# Config
rtag="$1"
pathd="${HOME}/Applications/Build/wz2100/tags"
dmg_bn="warzone2100"
dmg_nv="-novideo.dmg"
dmg_lv="-lqvideo.dmg"
dmg_hv="-hqvideo.dmg"

# Die if empty
if [ -z ${rtag} ]; then
  echo "Must supply a tag to build."
  exit 1
fi

# Checkout
cd ${pathd}
if ! svn checkout https://warzone2100.svn.sourceforge.net/svnroot/warzone2100/tags/${rtag} ${rtag}; then
    echo "Unable to fetch ${rtag}"
    cd ${rtag}
    svn cleanup
    exit 1
fi

# Build
cd ${rtag}/macosx
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
# Open upload app
open /Applications/FileZilla.app