DirectorY="glew-1.6.0"
OutDir="glew"
FileName="glew-1.6.0.tgz"
SourceDLP="http://downloads.sourceforge.net/project/glew/glew/1.6.0/glew-1.6.0.tgz"
MD5Sum="7dfbb444b5a4e125bc5dba0aef403082"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}
