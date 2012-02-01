# Config
export PATH=$PATH:/sw/bin:/opt/local/bin
destdata="${CONFIGURATION_BUILD_DIR}/Warzone.app/Contents/Resources/"
datadir="../data"

if ! rsync -vcrlpt --del ${datadir} "${destdata}"; then
    exit ${?}
fi

exit 0