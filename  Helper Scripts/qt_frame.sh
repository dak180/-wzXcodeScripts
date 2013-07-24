#!/bin/bash

# Config
go_dir="$(dirname ${BASH_SOURCE})"
flist="$(\ls -1 "${go_dir}" | sed -n 's:.framework$:&:p')"
mjrver="4.0"
olmjrver="4"


cd "${go_dir}"

if [ ! -z "$(\ls -1 "${go_dir}/moc*")" ]; then
    mkdir -p usr/bin
    mv moc* usr/bin/
else
    echo "warning: moc binary not found." >&2
fi

for Qtframe in ${flist}; do
	cd "${Qtframe}"
	Qtname="$(basename "${Qtframe}" ".framework")"
	echo "Fixing up ${Qtname}..."
	
	# Put the Info.plist in the right place
	if [ ! -d "Versions/${mjrver}/Resources" ]; then
		mkdir -pm "0775" "Versions/${mjrver}/Resources"
	fi
	mv -n "Contents/Info.plist" "Versions/${mjrver}/Resources/"
	rmdir "Contents"
	
	# Correct the symlinks
	ln -sfh "Versions/Current/Headers" "Headers"
	ln -sfh "Versions/Current/Resources" "Resources"
	ln -sfh "Versions/Current/${Qtname}" "${Qtname}"
	
	# Set the executable bit
	sudo chmod u+r+w+x,g+r+w+x,o+r-w+x "Versions/${olmjrver}/${Qtname}"
	
	# Set the names correctly
	install_name_tool -id @rpath/${Qtframe}/Versions/${mjrver}/${Qtname} "${Qtname}"
	install_name_tool -add_rpath @loader_path "${Qtname}"
	install_name_tool -add_rpath @loader_path/. "${Qtname}"
	if [[ ! "${Qtname}" = "QtCore" ]]; then
		# Link everything but QtCore to QtCore
		install_name_tool -change QtCore.framework/Versions/${olmjrver}/QtCore @rpath/QtCore.framework/Versions/${mjrver}/QtCore "${Qtname}"
	fi
	if [[ "${Qtname}" = "QtOpenGL" ]] || [[ "${Qtname}" = "QtScriptTools" ]] || [[ "${Qtname}" = "Qt3Support" ]]; then
		# Link up QtGui for those things that need it
		install_name_tool -change QtGui.framework/Versions/${olmjrver}/QtGui @rpath/QtGui.framework/Versions/${mjrver}/QtGui "${Qtname}"
	fi
	if [[ "${Qtname}" = "QtScriptTools" ]]; then
		# Extra links for QtScriptTools
		install_name_tool -change QtScript.framework/Versions/${olmjrver}/QtScript @rpath/QtScript.framework/Versions/${mjrver}/QtScript "${Qtname}"
	fi
	if [[ "${Qtname}" = "Qt3Support" ]]; then
		# Extra links for Qt3Support
		install_name_tool -change QtNetwork.framework/Versions/${olmjrver}/QtNetwork @rpath/QtNetwork.framework/Versions/${mjrver}/QtNetwork "${Qtname}"
		install_name_tool -change QtSql.framework/Versions/${olmjrver}/QtSql @rpath/QtSql.framework/Versions/${mjrver}/QtSql "${Qtname}"
		install_name_tool -change QtXml.framework/Versions/${olmjrver}/QtXml @rpath/QtXml.framework/Versions/${mjrver}/QtXml "${Qtname}"
	fi
	
	edit -b "Versions/${mjrver}/Resources/Info.plist"
	cd ..
done

echo "Remember to check that the info.plist files are not borked."

exit 0
