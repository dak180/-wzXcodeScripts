cd ..
./macosx/build/${CONFIGURATION}/Autorevision +cstr . src/autorevision.h
sed -n 's:#define:&:p' src/autorevision.h | sed 's:"::g' | sed -e 's:tags/::' -e 's:branches/\(.*\)$:\1 (SVN_REV):' -e 's:trunk:Trunk (SVN_REV):' | sed -e 's:_beta: Beta :' -e 's:_rc: RC :' >macosx/build/autorevision.h