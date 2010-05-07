echo "Checking for moc..."
if ! type -aP moc; then
    echo "error: Fatal inability to properly moc the code." >&2
    exit 1
fi

exit 0