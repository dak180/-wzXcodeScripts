cd external/quesoglc

if [ ! -r src/database.c ]; then
  cd database
  python buildDB.py
fi
