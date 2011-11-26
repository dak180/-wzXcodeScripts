# Config
export PATH=$PATH:/sw/bin:/opt/local/bin
function hfilter {
	sed -e 's:refs/heads/:branch/:' -e 's:master:Master:' -e 's:	v:	:' -e 's:v/::' src/autorevision.h | sed -e 's:_beta: Beta :' -e 's:_rc: RC :' > "${OBJROOT}/autorevision.h"
}
sauto="src/autorevision.h"
tauto="${OBJROOT}/autorev/autorevision.h"
function bauto {
	if ! build_tools/autorevision.sh "${tauto}"; then
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
elif [[ -f "${sauto}" ]] && [[ -f "${tauto}" ]]; then
	bauto
	mdck1=`md5 -q "${sauto}"`
	mdck2=`md5 -q "${tauto}"`
	if [ "${mdck1}" = "${mdck2}" ]; then
		exit 0
	else
		cp -a "${tauto}" "${sauto}"
	fi
else
	# Only update autorevision.h if something has changed
	mkdir "${OBJROOT}/autorev/"
	bauto
	cp -a "${tauto}" "${sauto}"
fi

hfilter
exit 0
