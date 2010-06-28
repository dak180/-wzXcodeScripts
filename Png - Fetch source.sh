DirectorY="libpng-1.4.3"
OutDir="libpng"
FileName="libpng-1.4.3.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/01-libpng-master/1.4.3/libpng-1.4.3.tar.gz"
MD5Sum="df3521f61a1b8b69489d297c0ca8c1f8"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}