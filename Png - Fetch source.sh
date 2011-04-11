DirectorY="libpng-1.4.7"
OutDir="libpng"
FileName="libpng-1.4.7.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng14/1.4.7/libpng-1.4.7.tar.gz"
MD5Sum="aa4231874e4a16cbc8daae81a1fd04e6"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}