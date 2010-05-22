DirectorY="QT_"
OutDir="QT"
FileName="QT.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/QT.tar.gz"
MD5Sum="6af9bd2badda7ece940a54f3e24e5ce5"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}