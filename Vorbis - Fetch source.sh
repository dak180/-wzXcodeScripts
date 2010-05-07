DirectorY="libvorbis-1.3.1"
OutDir="libvorbis"
FileName="libvorbis-1.3.1.tar.gz"
SourceDLP="http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.1.tar.gz"
MD5Sum="016e523fac70bdd786258a9d15fd36e9"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}