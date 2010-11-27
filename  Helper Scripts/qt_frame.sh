#!/bin/bash

# Config
go_dir=`dirname ${BASH_SOURCE}`
flist=`\ls -1 "${go_dir}" | sed -n 's:.framework$:&:p'`
mjrver="4.0"
olmjrver="4"


cd "${go_dir}"

for Qtframe in ${flist}; do
    cd "${Qtframe}"
    Qtname=`basename "${Qtframe}" ".framework"`
    echo "Fixing up ${Qtname}..."
    
    # Put the Info.plist in the right place
    mkdir -pm "0775" "Versions/${mjrver}/Resources"
    mv -n "Contents/Info.plist" "Versions/${mjrver}/Resources/"
    rmdir "Contents"
    
    # Correct the symlinks
    ln -sfh "Versions/Current/Headers" "Headers"
    ln -sfh "Versions/Current/Resources" "Resources"
    ln -sfh "Versions/Current/${Qtname}" "${Qtname}"
    
    # Set the executable bit
    sudo chmod u+r+w+x,g+r+w+x,o+r-w+x "Versions/${olmjrver}/${Qtname}"
    
    # Set the names correctly
    install_name_tool -id @executable_path/../Frameworks/${Qtframe}/Versions/${mjrver}/${Qtname} "${Qtname}"
    if [[ ! "${Qtname}" = "QtCore" ]]; then
        install_name_tool -change QtCore.framework/Versions/${olmjrver}/QtCore @executable_path/../Frameworks/QtCore.framework/Versions/${mjrver}/QtCore "${Qtname}"
    fi
    if [[ "${Qtname}" = "QtOpenGL" ]]; then
        install_name_tool -change QtGui.framework/Versions/${olmjrver}/QtGui @executable_path/../Frameworks/QtGui.framework/Versions/${mjrver}/QtGui "${Qtname}"
    fi
    if [[ "${Qtname}" = "Qt3Support" ]]; then
        install_name_tool -change QtGui.framework/Versions/${olmjrver}/QtGui @executable_path/../Frameworks/QtGui.framework/Versions/${mjrver}/QtGui "${Qtname}"
        install_name_tool -change QtNetwork.framework/Versions/${olmjrver}/QtNetwork @executable_path/../Frameworks/QtNetwork.framework/Versions/${mjrver}/QtNetwork "${Qtname}"
        install_name_tool -change QtSql.framework/Versions/${olmjrver}/QtSql @executable_path/../Frameworks/QtSql.framework/Versions/${mjrver}/QtSql "${Qtname}"
        install_name_tool -change QtXml.framework/Versions/${olmjrver}/QtXml @executable_path/../Frameworks/QtXml.framework/Versions/${mjrver}/QtXml "${Qtname}"
    fi
    
    cd ..
done

echo "Remember to check that the info.plist files are not borked."

exit 0