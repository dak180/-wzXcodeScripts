OUTDIR="bison"    # Dir in macosx/external to unpack Bison to
SYS_BISON="bison" # System Bison executable
BISON_BIN_DIR="${SRCROOT}/external/$OUTDIR/built" # Directory to install Bison to (relative to macosx/)
LOCAL_BISON="$BISON_BIN_DIR/bison" # Local Warzone Bison executable

# getLocalBison
# 
# Attempts to build and (if needed) download a version of Bison that is
# compatible with Warzone. Returns 0 if successful, else 1.
function getLocalBison
{
	local DIRECTORY="bison-2.4"
	local EXECUTABLE=$LOCAL_BISON
	local FILENAME="bison-2.4.tar.bz2"
	local SOURCE="http://ftp.gnu.org/gnu/bison/bison-2.3.tar.bz2"
	local MD5="2b9b088b46271c7fa902a7e85f503e1e"
	
	## Fetch source ##
	
	cd external
	
	if [ -d "$OUTDIR" ]; then
	  echo "$OUTDIR exists, skipping"
	  return 0
	fi
	
	if [ -d "$DIRECTORY" ]; then
	  echo "$DIRECTORY exists, probably from an earlier failed run" >&2
	  return 1
	fi
	
	if [ ! -r "$FILENAME" ]; then
	  echo "Fetching $SOURCE"
	  if ! curl -L -o "$FILENAME" "$SOURCE"; then
	    echo "Unable to fetch $SOURCE" >&2
	    return 1
	  fi
	fi
	
	local HAVEMD5=`md5 -q "$FILENAME"`
	
	if [ -z "$HAVEMD5" ]; then
	  echo "Unable to compute md5 for $FILENAME" >&2
	  return 1
	fi
	
	if [ "$HAVEMD5" != "$MD5" ]; then
	  echo "Md5 does not match for $FILENAME" >&2
	  return 1
	fi
	
	local EXTENSION=`echo $FILENAME | sed -e 's/^.*\.\([^.]*\)/\1/'`
	
	if [ "$EXTENSION" = "gz" ]; then
	  if ! tar -zxf "$FILENAME"; then
	    echo "Unpacking $FILENAME failed" >&2
	    return 1
	  fi
	elif [ "$EXTENSION" = "bz2" ]; then
	  if ! tar -jxf "$FILENAME"; then
	    echo "Unpacking $FILENAME failed" >&2
	    return 1
	  fi
	else
	  echo "Unable to unpack $FILENAME" >&2
	  return 1
	fi
	
	if [ ! -d "$DIRECTORY" ]; then
	  echo "Can't find $DIRECTORY to rename" >&2
	  return 1
	fi
	
	mv "$DIRECTORY" "$OUTDIR"
	
	## Build source ##
	
	cd "$OUTDIR"
	
	echo "Configuring GNU Bison"
	./configure --prefix "$BISON_BIN_DIR"
	
	if [ "$?" -ne 0 ]; then
		echo "GNU Bison configure operation failed" >&2
		return 1
	fi
	
	echo "Compiling GNU Bison"
	make && make install
	
	if [ "$?" -ne 0 ]; then
		echo "GNU Bison make operation failed" >&2
		return 1
	fi
	
	return 0
}

# isValidBison executable
#
# Determines if a version of Bison is compatible with Warzone. The argument
# 'executable' specifies the location of the Bison executable to test. Returns
# 1 if the version of Bison is valid, else 0
function isValidBison
{
	local BISON=$1            # Bison command to check version of
	local MIN_BISON_MAJOR=1   # Minimum major version of Bison to allow
	local MIN_BISON_MINOR=31  # Minimum minor version of Bison to allow
	local BISON_BLACKLIST=()  # Bison versions to blacklist (e.g. "2.1")
	
	# Expects the Bison version to be the only token of the form #.# on the first
	# line of the output from ./bison --version, where the first # is the major
	# version and the second # is the minor version
	local BISON_VER=`$BISON --version  | sed -En '1 s:.*([0-9]+\.[0-9]+):\1: p'`
	local BISON_MAJOR=`echo $BISON_VER | sed -E  's:([0-9]+)\.[0-9]+:\1:'`
	local BISON_MINOR=`echo $BISON_VER | sed -E  's:[0-9]+\.([0-9]+):\1:'`
	
	local VALID_BISON=$(( (BISON_MAJOR > MIN_BISON_MAJOR)
	                   || (  BISON_MAJOR == MIN_BISON_MAJOR
	                      && BISON_MINOR >= MIN_BISON_MINOR) ))
	
	# If version is valid so far, check the blacklist
	if [ $VALID_BISON -eq 1 ]; then
		for (( i = 0; i < ${#BISON_BLACKLIST[@]}; ++i )); do
			if [ $BISON_VER == ${BISON_BLACKLIST[${i}]} ]; then
				VALID_BISON=0
			fi
		done
	fi
	
	return $VALID_BISON
}

## Main ##
#
# If there is not already a local version of Bison (one in macosx/external/) and
# the version of Bison on the system is incompatible with the build process,
# attempt to download a compatible version of Bison.

# Check any local version of Bison
if [ -e "$LOCAL_BISON" ]; then
	isValidBison $LOCAL_BISON
	
	if [ $? -eq 1 ]; then
		# Local version is valid (nothing further needs to be done)
		echo "The local executable of GNU Bison is a compatible version and will be used."
		exit 0
	else
		# Local version is invalid
		echo "The local executable of GNU Bison is of an incompatible version" >&2
		exit 1
	fi
fi

# If the system version of Bison is incompatible, download a compatible version
isValidBison $SYS_BISON
if [ $? -ne 1 ]; then
	echo "The version of Bison on your system is not compatible with Warzone"
	echo "A compatible version will be attempted to be downloaded and used"
	
	getLocalBison
	if [ $? -ne 0 ]; then
		echo "Retrieval of a compatible version of Bison has failed" >&2
		exit 1
	fi
fi

exit 0
