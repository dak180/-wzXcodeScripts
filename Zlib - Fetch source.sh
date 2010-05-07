DirectorY="zlib-1.2.5"
OutDir="zlib"
FileName="zlib-1.2.5.tar.gz"
SourceDLP="http://zlib.net/zlib-1.2.5.tar.gz"
MD5Sum="c735eab2d659a96e5a594c9e8541ad63"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}