DirectorY="QT_"
OutDir="QT"
FileName="QT.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/QT.tar.gz"
MD5Sum="51ec0bf082620bf8c379661b564c2f6d"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}

# tar -czf QT.tar.gz --exclude '.DS_Store' QT_