cd external/quesoglc

if [ ! -r src/database.c ]; then
	cd database
	/usr/bin/python buildDB.py
	exit ${?}
fi
exit 0
