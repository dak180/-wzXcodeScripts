cd ..
export PATH=$PATH:/sw/bin:/opt/local/bin

# Wait a bit if Autorevision does not exist
tick=0
while [ ! -s "./macosx/build/${CONFIGURATION}/Autorevision" ]; do
    let tick=${tick}+1
    if [ ${tick} == 11 ]; then
        break
    fi
    sleep 1
done


if ! ./macosx/build/${CONFIGURATION}/Autorevision +cstr . src/autorevision.h; then
    echo "error: Could not run Autorevision"
    exit 1
fi

sed -n 's:#define:&:p' src/autorevision.h | sed 's:"::g' | sed -e 's:refs/heads/:branch/:' -e 's:master:Master:' -e 's:^v::' | sed -e 's:_beta: Beta :' -e 's:_rc: RC :' >macosx/build/autorevision.h
