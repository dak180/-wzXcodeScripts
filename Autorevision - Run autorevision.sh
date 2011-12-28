# Config
export PATH=$PATH:/sw/bin:/opt/local/bin
sauto="src/autorevision.h"
tauto="${OBJROOT}/autorev/autorevision.h"
function hfilter {
	rm -f "${OBJROOT}/autorevision.h"
	sed -e 's:refs/heads/:branch/:' -e 's:refs/remotes/:remote/:' -e 's:branch/master:Master:' -e 's:	v:	:' -e 's:v/::' "${tauto}" | sed -e 's:_beta: Beta :' -e 's:_rc: RC :' > "${OBJROOT}/autorevision.h"
}
function bauto {
	if ! ./build_tools/autorevision.sh "${tauto}"; then
		echo "error: Could not run Autorevision"
		exit 1
	fi
}

cd ..

if [[ ! -d ".git" ]] && [[ ! -d ".hg" ]] && [[ -f "${sauto}" ]]; then
	# Do not run if we will not get useful information
	echo "Not a repo."
	hfilter
	exit 0
elif [ -d "${OBJROOT}/autorev/" ]; then
	# Only update src/autorevision.h if something has changed
	bauto
	mdck1=`md5 -q "${sauto}"`
	mdck2=`md5 -q "${tauto}"`
	if [ "${mdck1}" = "${mdck2}" ]; then
		exit 0
	fi
else
	mkdir "${OBJROOT}/autorev/"
	bauto
fi

cp -a "${tauto}" "${sauto}"
hfilter
exit 0
