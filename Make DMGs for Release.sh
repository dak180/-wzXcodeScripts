# Config
simgfl="http://downloads.sourceforge.net/project/warzone2100/build-tools/mac/wztemplate.sparseimage"
simgflnme="wztemplate.sparseimage"
simgflmd5="da10e06f2b9b2b565e70dd8e98deaaad"
sequence="http://downloads.sourceforge.net/project/warzone2100/warzone2100/Videos/2.2/high-quality-en/sequences.wz"
sequencenme="sequences.wz"
sequencelo="http://downloads.sourceforge.net/project/warzone2100/warzone2100/Videos/2.2/low-quality-en/sequences.wz"
sequencelonme="sequences-lo.wz"
relbuild="build/Release/"
dmgout="build/dmgout"

# Fail if not release
if [ ! -d "${relbuild}Warzone.app" ]; then
    echo "error: This should only be run as Release" >&2
    exit 1
fi

# Make a dir and get the sparseimage
mkdir -p "$dmgout"
cd  "$dmgout"
if [ ! -f "$simgflnme" ]; then
    echo "Fetching $simgfl"
    if ! curl -L -O --connect-timeout "30" "$simgfl"; then
        echo "error: Unable to fetch $simgfl" >&2
        exit 1
    fi
else
    echo "$simgflnme already exists, skipping"
fi

# Get the sequences

# Comment out the following to skip the high qual seq
# if [ ! -f "$sequencenme" ]; then
#     echo "Fetching $sequencenme"
#     if [ -f "${HOME}/Library/Application Support/Warzone 2100 Trunk/sequences.wz" ]; then
#         cp "${HOME}/Library/Application Support/Warzone 2100 Trunk/sequences.wz" "$sequencenme"
#     elif ! curl -L --connect-timeout "30" -o "$sequencenme" "$sequence"; then
#         echo "error: Unable to fetch $sequence" >&2
#         exit 1
#     fi
# else
#     echo "$sequencenme already exists, skipping"
# fi
#

# Comment out the following to skip the low qual seq
if [ ! -f "$sequencelonme" ]; then
    echo "Fetching $sequencelonme"
    if [ -f "${HOME}/Applications/Build/wz2100/dmgmaker/sequences-lo.wz" ]; then
        cp "${HOME}/Applications/Build/wz2100/dmgmaker/sequences-lo.wz" "$sequencelonme"
    elif [ -f "${HOME}/Library/Application Support/Warzone 2100 Trunk/sequences-lq.wz" ]; then
        cp "${HOME}/Library/Application Support/Warzone 2100 Trunk/sequences-lq.wz" "$sequencelonme"
    elif ! curl -L --connect-timeout "30" -o "$sequencelonme" "$sequencelo"; then
        echo "error: Unable to fetch $sequencelo" >&2
        exit 1
    fi
else
    echo "$sequencelonme already exists, skipping"
fi
# 

# Copy over the app
cd ../../
echo "Copying the app cleanly."
rm -r -f $dmgout/Warzone.app
if ! tar -c --exclude '.svn' --exclude 'Makefile*' --exclude 'makefile*' --exclude '.DS_Store' -C build/Release Warzone.app | tar -xC $dmgout; then
    echo "error: Unable to copy the app" >&2
    exit 1
fi
mkdir -p "${dmgout}/warzone2100-dSYM"
cp -pPR ${relbuild}*.dSYM "${dmgout}/warzone2100-dSYM"
cd "$dmgout"
tar -czf warzone2100-dSYM.tar.gz --exclude '.DS_Store' warzone2100-dSYM

# mkredist.bash

cd Warzone.app/Contents/Resources/data/

echo "== Compressing base.wz =="
if [ -d base/ ]; then
  cd base/
  zip -r ../base.wz *
  cd ..
  rm -rf base/
fi

echo "== Compressing mp.wz =="
if [ -d mp/ ]; then
  cd mp/
  zip -r ../mp.wz *
  cd ..
  rm -rf mp/
fi

cd mods/

modlst=`ls -1`
for moddr in ${modlst}; do
    if [ -d ${moddr} ]; then
        cd ${moddr}
        if [ "${moddr}" = "campaign" ]; then
            sbtyp=".cam"
        elif [ "${moddr}" = "global" ]; then
            sbtyp=".gmod"
        elif [ "${moddr}" = "multiplay" ]; then
            sbtyp=".mod"
        elif [ "${moddr}" = "music" ]; then
            sbtyp=".music"
        else
            sbtyp=""
        fi
        modlstd=`ls -1`
        for modwz in ${modlstd}; do
            if [ -d ${modwz} ]; then
                echo "== Compressing ${modwz}${sbtyp}.wz =="
                cd ${modwz}
                zip -r ../${modwz}${sbtyp}.wz *
                cd ..
                rm -rf "${modwz}/"
            fi
        done
        cd ..
    fi
done

cd ../../../../../

rm -rf ./out ./temp
mkdir temp/
mkdir out/
mv warzone2100-dSYM temp/warzone2100-dSYM
mv warzone2100-dSYM.tar.gz out/warzone2100-dSYM.tar.gz

echo "== Creating DMG =="
cp wztemplate.sparseimage temp/wztemplatecopy.sparseimage
hdiutil resize -size 150m temp/wztemplatecopy.sparseimage
mountpt=`hdiutil mount temp/wztemplatecopy.sparseimage | tr -d "\t" | sed -E 's:(/dev/disk[0-9])( +)(/Volumes/Warzone 2100):\1:'`
cp -r Warzone.app/* /Volumes/Warzone\ 2100/Warzone.app
# hdiutil detach `expr match "$mountpt" '\(^[^ ]*\)'`
hdiutil detach "$mountpt"
hdiutil convert temp/wztemplatecopy.sparseimage -format UDZO -o out/warzone2100-novideo.dmg

if [ -f "$sequencelonme" ]; then
    echo "== Creating LQ DMG =="
    hdiutil resize -size 350m temp/wztemplatecopy.sparseimage
    mountpt=`hdiutil mount temp/wztemplatecopy.sparseimage | tr -d "\t" | sed -E 's:(/dev/disk[0-9])( +)(/Volumes/Warzone 2100):\1:'`
    cp sequences-lo.wz /Volumes/Warzone\ 2100/Warzone.app/Contents/Resources/data/sequences.wz
    # hdiutil detach `expr match "$mountpt" '\(^[^ ]*\)'`
    hdiutil detach "$mountpt"
    hdiutil convert temp/wztemplatecopy.sparseimage -format UDZO -o out/warzone2100-lqvideo.dmg
else
    echo "$sequencelonme does not exist, skipping"
fi


if [ -f "$sequencenme" ]; then
    echo "== Creating HQ DMG =="
    hdiutil resize -size 700m temp/wztemplatecopy.sparseimage
    mountpt=`hdiutil mount temp/wztemplatecopy.sparseimage | tr -d "\t" | sed -E 's:(/dev/disk[0-9])( +)(/Volumes/Warzone 2100):\1:'`
    rm /Volumes/Warzone\ 2100/Warzone.app/Contents/Resources/data/sequences.wz
    cp sequences.wz /Volumes/Warzone\ 2100/Warzone.app/Contents/Resources/data/sequences.wz
    hdiutil detach "$mountpt"
    hdiutil convert temp/wztemplatecopy.sparseimage -format UDZO  -o out/warzone2100-hqvideo.dmg
else
    echo "$sequencenme does not exist, skipping"
fi

echo "== Cleaning up =="
rm -f temp/wztemplatecopy.sparseimage

# Open the dir
open "out"

exit 0