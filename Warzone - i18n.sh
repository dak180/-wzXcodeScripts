# Config
export PATH=$PATH:/sw/bin:/opt/local/bin
podir="../po"
disfile="configs/LangDis"
aresdir="${CONFIGURATION_BUILD_DIR}/Warzone.app/Contents/Resources/"
bresdir="locale/"
messdir="LC_MESSAGES/"
monme="warzone2100.mo"
polist=`ls -1 ${podir} | sed -n 's:\.po$:&:p' | sed -e 's:\.po::'`
dislist=`cat ${disfile} | sed -n 's:^<::p'`

# 1st san check
echo "Checking for msgfmt..."
if [ -f build/notrans.dis ]; then
    rm build/notrans.dis
    echo "warning: Gettext support has been disabled for this build because we could not find a binary." >&2
    exit 0
elif ! type -aP msgfmt; then
    echo "error: Fatal inability to properly translate messages." >&2
    exit 1
fi

# Get the path
msgfmtpth=`type -P msgfmt`

# 2nd san check
echo "Checking for sanity..."
if ! $msgfmtpth --version; then
    echo "error: Fatal failure of san check." >&2
    exit 1
fi

# Disable selected langs
for dislang in ${dislist}; do
    echo "Cleaning up for ${dislang} ..."
    rm -rfv "${aresdir}${dislang}.lproj"
done

# Make .mo
for lang in ${polist}; do
    if [ -d "${aresdir}${lang}.lproj" ]; then
        echo "Setting up for ${lang} ..."
        mkdir -p "${aresdir}${bresdir}${lang}/${messdir}"
        $msgfmtpth -v -o "${aresdir}${bresdir}${lang}/${messdir}${monme}" "${podir}/${lang}.po"
    fi
done

exit 0

perdone=`msgfmt --statistics -o /dev/null "${podir}/${lang}.po" 2>&1 | awk 'ORS {print 100*$1/($1+$4+$7)}'`

polishd=`echo "${perdone} >= 80" | bc`