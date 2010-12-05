DirectorY="glew-1.5.7"
OutDir="glew"
FileName="glew-1.5.7.tgz"
SourceDLP="http://downloads.sourceforge.net/project/glew/glew/1.5.7/glew-1.5.7.tgz"
MD5Sum="f913ce9dbde4cd250b932731b3534ded"

configs/FetchSource.sh "${DirectorY}" "${OutDir}" "${FileName}" "${SourceDLP}" "${MD5Sum}"
exit ${?}