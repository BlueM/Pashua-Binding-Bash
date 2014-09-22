#!/bin/bash

#
# USAGE INFORMATION:
# As you can see this text, you obviously have opened the file in a text editor.
# 
# If you would like to *run* this example rather than *read* it, you
# should open Terminal.app, drag this document's icon onto the terminal
# window, bring Terminal.app to the foreground (if necessary) and hit return.
# 

# Wrapper function for interfacing to Pashua. Written by Carsten
# Bluem <carsten@bluem.net> in 10/2003, modified in 12/2003 (including
# a code snippet contributed by Tor Sigurdsson), 08/2004 and 12/2004.
# As 1st argument, you must pass a configuration string
# As 2nd argument, you may pass the encoding to use (see documentation)
# As 3rd argument, you may pass the path to the Pashua application,
#                  if it's not in one of the standard locations.
pashua_run() {

	# Write config file
	local pashua_configfile=`/usr/bin/mktemp /tmp/pashua_XXXXXXXXX`
	echo "$1" > $pashua_configfile

	# Find Pashua binary. We do search both . and dirname "$0"
	# , as in a doubleclickable application, cwd is /
	# BTW, all these quotes below are necessary to handle paths
	# containing spaces.
	local bundlepath="Pashua.app/Contents/MacOS/Pashua"
	local pashuapath=""
	if [ "$3" = "" ]
	then
		mypath=`dirname "$0"`
		for searchpath in "$mypath/Pashua" \
		                  "$mypath/$bundlepath" \
		                  "./$bundlepath" \
						  "/Applications/$bundlepath" \
						  "$HOME/Applications/$bundlepath"
		do
			if [ -f "$searchpath" -a -x "$searchpath" ]
			then
				pashuapath=$searchpath
				break
			fi
		done
	else
		# Directory given as argument
		pashuapath="$3/$bundlepath"
	fi

	if [ "" = "$pashuapath" ]
	then
		>&2 echo "Error: Pashua could not be found"
		exit 1
	fi

	# Manage encoding
	if [ "$2" = "" ]
	then
		local encoding=""
	else
		local encoding="-e $2"
	fi

	# Get result
	local result=$("$pashuapath" $encoding $pashua_configfile | perl -pe 's/ /;;;/g;')

	# Remove config file
	rm $pashua_configfile

	# Parse result
	for line in $result
	do
		key=$(echo $line | sed 's/^\([^=]*\)=.*$/\1/')
		value=$(echo $line | sed 's/^[^=]*=\(.*\)$/\1/' | sed 's/;;;/ /g')
		varname=$key
		varvalue="$value"
		eval $varname='$varvalue'
	done
}

# Define what the dialog should be like
# Take a look at Pashua's Readme file for more info on the syntax

conf="
# Set transparency: 0 is transparent, 1 is opaque
*.transparency=0.95

# Set window title
*.title = Introducing Pashua

# Introductory text
tb.type = text
tb.default = Pashua is an application for generating dialog windows from programming languages which lack support for creating native GUIs on Mac OS X. Any information you enter in this example window will be returned to the calling script when you hit “OK”; if you decide to click “Cancel” or press “Esc” instead, no values will be returned.[return][return]This window demonstrates nine of the GUI widgets that are currently available. You can find a full list of all GUI elements and their corresponding attributes in the documentation that is included with Pashua.
tb.height = 276
tb.width = 310
tb.x = 340
tb.y = 44

# Add a text field
tx.type = textfield
tx.label = Example textfield
tx.default = Textfield content
tx.width = 310

# Add a filesystem browser
ob.type = openbrowser
ob.label = Example filesystem browser (textfield + open panel)
ob.width=310
ob.tooltip = Blabla filesystem browser

# Define radiobuttons
rb.type = radiobutton
rb.label = Example radiobuttons
rb.option = Radiobutton item #1
rb.option = Radiobutton item #2
rb.option = Radiobutton item #3
rb.option = Radiobutton item #4
rb.default = Radiobutton item #2

# Add a popup menu
pop.type = popup
pop.label = Example popup menu
pop.width = 310
pop.option = Popup menu item #1
pop.option = Popup menu item #2
pop.option = Popup menu item #3
pop.default = Popup menu item #2

# Add a checkbox
chk1.type = checkbox
chk1.label = Pashua offers checkboxes, too
chk1.rely = -18
chk1.default = 1

# Add another one
chk2.type = checkbox
chk2.label = But this one is disabled
chk2.disabled = 1

# Add a cancel button with default label
cb.type=cancelbutton
"

# Set the images' paths relative to this file's path / 
# skip images if they can not be found in this file's path
icon=$(dirname "$0")'/.icon.png'
bgimg=$(dirname "$0")'/.demo.png'

if [ -e "$icon" ]
then
	# Display Pashua's icon
	conf="$conf
	     img.type = image
	     img.x = 530
	     img.y = 255
	     img.path = $icon"
fi

if [ -e "$bgimg" ]
then
 	# Display background image
	conf="$conf
	      bg.type = image
	      bg.x = 30
	      bg.y = 2
	      bg.path = $bgimg"
fi

pashua_run "$conf" 'utf8'

echo "Pashua created the following variables:"
echo "  tb  = $tb"
echo "  tx  = $tx"
echo "  ob  = $ob"
echo "  pop = $pop"
echo "  rb  = $rb"
echo "  cb  = $cb"
echo ""
