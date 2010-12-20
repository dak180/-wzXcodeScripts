DirectorY="libpng-1.4.5"
OutDir="libpng"
FileName="libpng-1.4.5.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng14/1.4.5/libpng-1.4.5.tar.gz"
MD5Sum="dd4175393720ae041c67ace87cf6d212"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}