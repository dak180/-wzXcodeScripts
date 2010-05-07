# SDL
DirectorY="SDL_"
OutDir="SDL"
FileName="SDL.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/SDL.tar.gz"
MD5Sum="200bf42ff5118a57b26114248cc6b9fe"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}

# QT
DirectorY="QT_"
OutDir="QT"
FileName="QT.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/QT.tar.gz"
MD5Sum="6af9bd2badda7ece940a54f3e24e5ce5"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}

# msgfmt
DirectorY="gettext-0.17.mpkg_"
OutDir="gettext-0.17.mpkg"
FileName="gettext-0.17.mpkg.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/gettext-0.17.mpkg.tar.gz"
MD5Sum="ba7984918fe0b36e2e7c786693e005f2"

# Checks
export PATH=$PATH:/sw/bin:/opt/local/bin
if type -aP msgfmt; then
    echo "msgfmt exists, skipping"
    exit 0
elif [ -x "/opt/local/bin/port" ]; then
  echo "warning: Please run the following command in the terminal: 'sudo port install gettext'." >&2
  open -b com.apple.Terminal
  exit 1
elif [ -d "${SRCROOT}/external/${OutDir}" ]; then
    touch build/notrans.dis
    echo "warning: Gettext support has been disabled because we could not find a binary." >&2
    exit 0
elif [ ! `sw_vers -productVersion | sed -e 's:^...\(.\)..$:\1:'` -ge "6" ]; then
    touch build/notrans.dis
    echo "warning: Gettext support has been disabled because we could not find a binary." >&2
    exit 0
fi

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
FetchExitStatus=$?

# Install
if [ ! "${FetchExitStatus}" = "0" ]; then
    exit "${FetchExitStatus}"
elif [ -d "${SRCROOT}/external/${OutDir}" ]; then
    echo " Please install the gettext package before continuing." >&2
    open "${SRCROOT}/external/${OutDir}"
    exit 1
fi