DirectorY="quesoglc-0.7-r921"
OutDir="quesoglc"
FileName="quesoglc-0.7-r921.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/quesoglc-0.7-r921.tar.gz"
MD5Sum="ee73eebd23292dfb17365ff19eb15a0e"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}

# tar -czf quesoglc-0.7-r921.tgz --exclude '.svn' --exclude '.DS_Store' quesoglc-0.7-r921
