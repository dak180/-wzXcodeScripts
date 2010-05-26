DirectorY="QT_"
OutDir="QT"
FileName="QT.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/QT.tar.gz"
MD5Sum="17d495f6ab3921e00096895cab786462"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}