function hfilter {
    sed -e 's:refs/heads/:branch/:' -e 's:master:Master:' -e 's:^v::' src/autorevision.h | sed -e 's:_beta: Beta :' -e 's:_rc: RC :' > "${OBJROOT}/autorevision.h"
}


export PATH=$PATH:/sw/bin:/opt/local/bin
cd ..

# Do not run if we will not get useful information
if [[ ! -d ".git" ]] && [[ ! -d ".hg" ]]; then
    if [ -f "src/autorevision.h" ]; then
        echo "Not a repo."
        hfilter
        exit 0
    fi
fi


if ! build_tools/autorevision.sh src/autorevision.h; then
    echo "error: Could not run Autorevision"
    exit 1
fi

hfilter
exit 0
