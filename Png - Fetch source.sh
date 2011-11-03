DirectorY="libpng-1.5.6"
OutDir="libpng"
FileName="libpng-1.5.6.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng15/1.5.6/libpng-1.5.6.tar.gz"
MD5Sum="8b0c05ed12637ee1f060ddfbbf526ea3"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}
