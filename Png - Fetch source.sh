DirectorY="libpng-1.4.4"
OutDir="libpng"
FileName="libpng-1.4.4.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/01-libpng-master/1.4.4/libpng-1.4.4.tar.gz"
MD5Sum="297b38f925e745061489b41b1f7c4bb1"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}