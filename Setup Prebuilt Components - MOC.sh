export PATH=/sw/lib/qt4-mac/bin:/sw/lib/qt4-x11/bin:/opt/local/bin:${PATH}
echo "Checking for moc..."
if ! type -aP moc; then
    echo "error: Fatal inability to properly moc the code. (Insure you have installed Qt or risk more mocing.)" >&2
    open ./README.BUILD.txt
    exit 1
elif [[ `moc -v 2>&1 | sed -e 's:.*Qt \(4\.6\)\..)$:\1:'` < "4.6" ]]; then
    echo "error: Moc is not properly installed" >&2
    exit 1
fi
moc -v
exit 0
