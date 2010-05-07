#Config
destdata="build/${CONFIGURATION}/Warzone.app/Contents/Resources/data"
datadir="../data"
svnrevtag=`svnversion -c "${datadir}"`
mtag=`echo "${svnrevtag}" | sed -ne 's:\(.*\)M$:true:p'`

if [ -d "${destdata}" ]; then
    testsvnrevtag=`svnversion -c "${destdata}"`
    if [[ "${testsvnrevtag}" = "${svnrevtag}" ]] && [[ ! "${mtag}" = "true" ]]; then
        echo "Data directory is up to date"
        exit 0
    else
        echo "Data directory is out of date or has local modifications; recopying"
        rm -rf "${destdata}"
        mkdir -p "${destdata}"
        cp -af "${datadir}/" "${destdata}/"
        exit 0
    fi
else
    mkdir -p "${destdata}"
    cp -af "${datadir}/" "${destdata}/"
fi

exit 0