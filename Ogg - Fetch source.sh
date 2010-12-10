DirectorY="libogg-1.2.2"
OutDir="libogg"
FileName="libogg-1.2.2.tar.gz"
SourceDLP="http://downloads.xiph.org/releases/ogg/libogg-1.2.2.tar.gz"
MD5Sum="5a9fcabc9a1b7c6f1cd75ddc78f36c56"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}