export PATH=$PATH:/sw/bin:/opt/local/bin
echo "Checking for moc..."
if ! type -aP moc; then
    echo "error: Fatal inability to properly moc the code. (Insure you have installed Qt or risk more mocing.)" >&2
    open ./README.BUILD.txt
    exit 1
elif ! moc -v; then
    echo "error: Moc is not properly installed" >&2
    exit 1
fi
exit 0