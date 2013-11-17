#!/bin/bash

# Config
rtag="${1}"
prerun="${2}"
pathd="${HOME}/Applications/Build/wz2100/hg/wz2100-git"
dmg_bn="warzone2100"
dmg_nv="-novideo.dmg"
dmg_lv="-lqvideo.dmg"
dmg_hv="-hqvideo.dmg"
tar_dS="-dSYM.tgz"

# Die if empty
if [ -z ${rtag} ]; then
  echo "Must supply a tag to build."
  exit 1
fi

# Checkout
cd "${pathd}"
if ! git checkout -f ${rtag}; then
	echo "Unable to checkout ${rtag}"
	exit 1
fi

# Build
cd ./macosx
if [ "${prerun}" == "pre" ]; then
	if ! xcodebuild -project Warzone.xcodeproj -target Warzone -configuration Release -PBXBuildsContinueAfterErrors=NO; then
		open .
	fi
	exit 0
elif ! xcodebuild -project Warzone.xcodeproj -parallelizeTargets -target "Make DMGs for Release" -configuration Release; then
	if ! xcodebuild -project Warzone.xcodeproj -parallelizeTargets -target "Make DMGs for Release" -configuration "Release" -PBXBuildsContinueAfterErrors=NO; then
		echo "The build has failed with the preceding error."
		exit 1
	fi
fi

# Rename and md5
rtag="$(echo ${rtag} | sed -e 's:/:_:g' -e 's:^v::')"
git_sr="$(../build_tools/autorevision -f -s VCS_SHORT_HASH -o ../src/autorevision.cache)"
cd build/dmgout/out

if [ -f "${dmg_bn}-${rtag}_[${git_sr}]${tar_dS}" ]; then
	md5 -q "${dmg_bn}-${rtag}_[${git_sr}]${tar_dS}">"${dmg_bn}-${rtag}_[${git_sr}]${tar_dS}.md5"
else
	echo "${dmg_bn}-${rtag}_[${git_sr}]${tar_dS} does not exist, skipping"
fi

if [ -f "${dmg_bn}-${rtag}_[${git_sr}]${dmg_nv}" ]; then
	md5 -q "${dmg_bn}-${rtag}_[${git_sr}]${dmg_nv}">"${dmg_bn}-${rtag}_[${git_sr}]${dmg_nv}.md5"
else
	echo "${dmg_bn}-${rtag}_[${git_sr}]${dmg_nv} does not exist, skipping"
fi

if [ -f "${dmg_bn}-${rtag}_[${git_sr}]${dmg_lv}" ]; then
	md5 -q "${dmg_bn}-${rtag}_[${git_sr}]${dmg_lv}">"${dmg_bn}-${rtag}_[${git_sr}]${dmg_lv}.md5"
else
	echo "${dmg_bn}-${rtag}_[${git_sr}]${dmg_lv} does not exist, skipping"
fi

if [ -f "${dmg_bn}-${rtag}_[${git_sr}]${dmg_hv}" ]; then
	md5 -q "${dmg_bn}-${rtag}_[${git_sr}]${dmg_hv}">"${dmg_bn}-${rtag}_[${git_sr}]${dmg_hv}.md5"
else
	echo "${dmg_bn}-${rtag}_[${git_sr}]${dmg_hv} does not exist, skipping"
fi
# Open upload app
open -b de.filezilla
