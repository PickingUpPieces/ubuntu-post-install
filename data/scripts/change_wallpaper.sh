#!/bin/bash

# Script to randomly set Background from files in a directory

# Directory Containing Pictures
DIR="$HOME/Pictures"

# Command to Select a random jpg file from directory
# Delete the *.jpg to select any file but it may return a folder
PIC=$(ls $DIR/*.jpg | shuf -n1)

echo "file:/$PIC"
# Command to set Background Image
gsettings set org.gnome.desktop.background picture-uri "file://$PIC"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$PIC"
