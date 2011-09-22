DirectorY="libpng-1.5.5"
OutDir="libpng"
FileName="libpng-1.5.5.tar.gz"
SourceDLP="http://downloads.sourceforge.net/project/libpng/libpng15/1.5.5/libpng-1.5.5.tar.gz"
MD5Sum="003bcac022125029bae4818d74c42a94"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}
