DirectorY="libpng-1.5.4"
OutDir="libpng"
FileName="libpng-1.5.4.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng15/1.5.4/libpng-1.5.4.tar.gz"
MD5Sum="dea4d1fd671160424923e92ff0cdda78"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}
