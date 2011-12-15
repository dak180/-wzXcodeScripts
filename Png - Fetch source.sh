DirectorY="libpng-1.5.7"
OutDir="libpng"
FileName="libpng-1.5.7.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng15/1.5.7/libpng-1.5.7.tar.gz"
MD5Sum="944b56a84b65d94054cc73d7ff965de8"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}
