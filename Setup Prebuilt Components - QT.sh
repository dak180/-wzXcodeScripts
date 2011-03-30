DirectorY="QT_"
OutDir="QT"
FileName="QT.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/QT.tar.gz"
MD5Sum="8bd5dd347b391ab4a29105f144c64b4d"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}

# tar -czf QT.tar.gz --exclude '.DS_Store' QT_