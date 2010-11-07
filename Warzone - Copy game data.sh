# Config
export PATH=$PATH:/sw/bin:/opt/local/bin
destdata="build/${CONFIGURATION}/Warzone.app/Contents/Resources/data"
datadir="../data"
revckf="build/revck.tmp"
tsthg="../.hg"
tstgit="../.git"

# Check for hg or git
if [ -d "${tstgit}" ]; then
    revck=`git rev-parse HEAD`
    mck=`git status --porcelain ${datadir}`
elif [ -d "${tsthg}" ]; then
    revck=`hg ident | sed -e 's:+::'`
    mck=`hg status ${datadir}`
else
    revck="false"
fi

# Try to figure out if the data dir needs updating
if [ -d "${destdata}" ]; then
    revtst=`cat ${revckf}`
    if [[ "${revck}" == "false" ]] || [[ -z "${revck}" ]];then
        echo "Warning: State of the data directory cannot be determined; recopying"
        rm -rf "${destdata}"
        mkdir -p "${destdata}"
        cp -pPRf "${datadir}/" "${destdata}/"
    elif [[ ! -z "${mck}" ]] || [[ ! "${revck}" = "${revtst}" ]];then
        echo "Data directory is out of date or has local modifications; recopying"
        rm -rf "${destdata}"
        mkdir -p "${destdata}"
        cp -pPRf "${datadir}/" "${destdata}/"
    else
        echo "Data directory is up to date"
        exit 0
    fi
else
    mkdir -p "${destdata}"
    cp -pPRf "${datadir}/" "${destdata}/"
fi

# Write out revckf
echo "${revck}" > ${revckf}

exit 0