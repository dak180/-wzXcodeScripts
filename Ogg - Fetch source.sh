DirectorY="libogg-1.2.1"
OutDir="libogg"
FileName="libogg-1.2.1.tar.gz"
SourceDLP="http://downloads.xiph.org/releases/ogg/libogg-1.2.1.tar.gz"
MD5Sum="b998c2420721146df3b3d0e7776c97b9"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}