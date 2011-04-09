DirectorY="libpng-1.4.6"
OutDir="libpng"
FileName="libpng-1.4.6.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng14/1.4.6/libpng-1.4.6.tar.gz"
MD5Sum="061c30db9be127b0abfdd468fa27528f"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}