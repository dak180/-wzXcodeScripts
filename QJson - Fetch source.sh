DirectorY="qjson"
OutDir="qjson-out"
FileName="qjson-0.7.1.tar.bz2"
SourceDLP="http://downloads.sourceforge.net/project/qjson/qjson/0.7.1/qjson-0.7.1.tar.bz2"
MD5Sum="5a833ad606c164ed8aa69f0873366ace"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}
