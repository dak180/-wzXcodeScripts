DirectorY="libpng-1.4.2"
OutDir="libpng"
FileName="libpng-1.4.2.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/01-libpng-master/1.4.2/libpng-1.4.2.tar.gz"
MD5Sum="89fd334dc5fc84ff146b9269c4fa452f"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}