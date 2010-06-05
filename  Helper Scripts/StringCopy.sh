#!/bin/sh

# Run from "macosx/Resources/wzlocal"

# Config
argd="$1"
podir="../../../po"
polist=`ls -1 ${podir} | sed -n 's:\.po$:&:p' | sed -e 's:\.po$::'`
stringslist=`ls -1 "./English.lproj" | sed -n 's:\.strings$:&:p'`

# Make .lproj
for lang in ${polist}; do
    if [ ! -d "${lang}.lproj" ]; then
        echo "Setting up for ${lang} ..."
        mkdir -p ./${lang}.lproj
        for strgs in ${stringslist}; do
            cp -npv "./English.lproj/${strgs}" "./${lang}.lproj/"
        done
    elif [  ${argd} = "update" ]; then
        echo "Updating ${lang} ..."
        for strgs in ${stringslist}; do
            cp -fpv "./English.lproj/${strgs}" "./${lang}.lproj/"
        done
    else
        for strgs in ${stringslist}; do
            if [ -s "./${lang}.lproj/${strgs}" ]; then
                cp -fpv "./English.lproj/${strgs}" "./${lang}.lproj/"
            else
                echo "${lang}.lproj/${strgs} exists, skipping ..."
            fi
        done
    fi
done

exit 0