cd ../3rdparty/miniupnpc

sed -e "s:OS/version:Mac OS:" miniupnpcstrings.h.in >"${DERIVED_FILE_DIR}/miniupnpcstrings.h"
exit ${?}
