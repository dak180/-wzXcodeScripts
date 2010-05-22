DirectorY="SDL_"
OutDir="SDL"
FileName="SDL.tar.gz"
BuiltDLP="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/SDL.tar.gz"
MD5Sum="200bf42ff5118a57b26114248cc6b9fe"

configs/FetchPrebuilt.sh "${DirectorY}" "${OutDir}" "${FileName}" "${BuiltDLP}" "${MD5Sum}"
exit ${?}