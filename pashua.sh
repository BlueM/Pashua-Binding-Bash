
# Tries to find the Pashua executable in one of a few default search locations or in
# a custom path passed as optional argument. When it can be found, the filesystem
# path will be in $pashuapath, otherwise $pashuapath will be empty. The return value
# is 0 if it can be found, 1 otherwise.
#
# Argument 1: Path to a folder containing Pashua.app (optional)
locate_pashua() {

    local bundlepath="Pashua.app/Contents/MacOS/Pashua"
    local mypath=`dirname "$0"`

    pashuapath=""

    if [ ! "$1" = "" ]
    then
        searchpaths[0]="$1/$bundlepath"
    fi
    searchpaths[1]="$mypath/Pashua"
    searchpaths[2]="$mypath/$bundlepath"
    searchpaths[3]="./$bundlepath"
    searchpaths[4]="/Applications/$bundlepath"
    searchpaths[5]="$HOME/Applications/$bundlepath"

    for searchpath in "${searchpaths[@]}"
    do
        if [ -f "$searchpath" -a -x "$searchpath" ]
        then
            pashuapath=$searchpath
            return 0
        fi
    done

    return 1
}

# Function for communicating with Pashua
#
# Argument 1: Configuration string
# Argument 2: Path to a folder containing Pashua.app (optional)
pashua_run() {

    # Write config file
    local pashua_configfile=`/usr/bin/mktemp /tmp/pashua_XXXXXXXXX`
    echo "$1" > "$pashua_configfile"

    locate_pashua "$2"

    if [ "" = "$pashuapath" ]
    then
        >&2 echo "Error: Pashua could not be found"
        exit 1
    fi

    # Get result
    local result=$("$pashuapath" "$pashua_configfile")

    # Remove config file
    rm "$pashua_configfile"

    oldIFS="$IFS"
    IFS=$'\n'

    # Parse result
    for line in $result
    do
        local name=$(echo $line | sed 's/^\([^=]*\)=.*$/\1/')
        local value=$(echo $line | sed 's/^[^=]*=\(.*\)$/\1/')
        eval $name='$value'
    done

    IFS="$oldIFS"
}
