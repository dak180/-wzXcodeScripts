#!/bin/sh
export PATH=$PATH:/sw/bin:/opt/local/bin:/usr/local/bin

# Config
nowd=$(git rev-parse HEAD | cut -b 1-7)
mWarzoneHelp="macosx/WarzoneHelp/Contents/Resources"
mWarzoneHelpLproj="${mWarzoneHelp}/en.lproj"

cd "$(git rev-parse --show-toplevel 2>/dev/null)"
mkdir -p "${mWarzoneHelpLproj}"


# asciidoc based docs
if type -aP a2x; then
	# quickstartguide
	a2x -f chunked -D "${mWarzoneHelpLproj}" doc/quickstartguide.asciidoc
	cp -af ${mWarzoneHelpLproj}/quickstartguide.chunked/* ${mWarzoneHelpLproj}
	rm -fr ${mWarzoneHelpLproj}/quickstartguide.chunked

	# man page
	a2x -f xhtml -d manpage -D "${mWarzoneHelpLproj}" doc/warzone2100.6.asciidoc
	
	# Cleanup
    cp -af "${mWarzoneHelpLproj}/docbook-xsl.css" "${mWarzoneHelpLproj}/images" ${mWarzoneHelp}
    rm -fr "${mWarzoneHelpLproj}/docbook-xsl.css" "${mWarzoneHelpLproj}/images"
    sed -i '' -e 's:href="docbook-xsl.css:href="../docbook-xsl.css:g' ${mWarzoneHelpLproj}/*.html
    sed -i '' -e 's:src="images/:src="../images/:g' ${mWarzoneHelpLproj}/*.html
    sed -i '' -e 's:warzone2100:Warzone:g' ${mWarzoneHelpLproj}/warzone2100.6.html
else
	echo "error: no suitable a2x (asciidoc) in path"
	exit 1
fi

# LaTeX based docs
if type -aP pdflatex; then
	# javascript doc
	grep src/qtscript.cpp -e '//==' | sed 's://==::' > doc/globals.tex
	grep src/qtscript.cpp -e '//__' | sed 's://__::' > doc/events.tex
	grep src/qtscript.cpp -e '//--' | sed 's://--::' > doc/functions.tex
	grep src/qtscriptfuncs.cpp -e '//--' | sed 's://--::' >> doc/functions.tex
	grep src/qtscriptfuncs.cpp -e '//;;' | sed 's://;;::' > doc/objects.tex
	cd doc/
	pdflatex javascript.tex
	cd ..
	cp -af doc/javascript.pdf ${mWarzoneHelpLproj}
else
	echo "error: no suitable pdflatex (tetex) in path"
	exit 1
fi

# Build the index
rm -f "${mWarzoneHelpLproj}/WarzoneHelp.helpindex"
hiutil -Caf "${mWarzoneHelp}/WarzoneHelp.helpindex" "${mWarzoneHelpLproj}"
cp -af "${mWarzoneHelp}/WarzoneHelp.helpindex" "${mWarzoneHelpLproj}"
rm -f "${mWarzoneHelp}/WarzoneHelp.helpindex"

# Make the tarball
cd macosx
mv WarzoneHelp WarzoneHelp-${nowd}
tar -czf WarzoneHelp-${nowd}.tgz --exclude '.DS_Store' WarzoneHelp-${nowd}
rm -fr WarzoneHelp-${nowd}
echo ""
echo "WarzoneHelp-${nowd}: $(md5 -q WarzoneHelp-${nowd}.tgz)"

exit 0
