DirectorY="libpng-1.4.1"
OutDir="libpng"
FileName="libpng-1.4.1.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/01-libpng-master/1.4.1/libpng-1.4.1.tar.gz"
MD5Sum="fa0b2a84733463f90d3ac9f43ccafabc"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}