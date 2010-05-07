DirectorY="libogg-1.2.0"
OutDir="libogg"
FileName="libogg-1.2.0.tar.gz"
SourceDLP="http://downloads.xiph.org/releases/ogg/libogg-1.2.0.tar.gz"
MD5Sum="c95b73759acfc30712beef6ce4e88efa"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}