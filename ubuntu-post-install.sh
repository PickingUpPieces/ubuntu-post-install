#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <sam@snwh.org>
#
# Description:
#   A post-installation bash script for Ubuntu
#
# Legal Preamble:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

# tab width
clear
  
# Title of script set
TITLE="Ubuntu System Setup Script"


# Main
function main {
	echo_message header "Starting 'main' function"
	# Draw window
	MAIN=$(eval `resize` && whiptail \
		--notags \
		--title "$TITLE" \
		--menu "\nWhat would you like to do?" \
		--cancel-button "Quit" \
		$LINES $COLUMNS $(( $LINES - 12 )) \
    'system_install'	    '(De)Install everything (un)important' \
		'system_setup'		    'Setup system and apps' \
		'system_update'       'Perform system updates' \
		'system_cleanup'      'Cleanup the system' \
		3>&1 1>&2 2>&3)
	# check exit status
	if [ $? = 0 ]; then
		echo_message header "Starting '$MAIN' function"
		$MAIN
	else
		# Quit
		quit
	fi
}


# Quit
function quit {
	echo_message header "Starting 'quit' function"
	echo_message title "Exiting $TITLE..."
	exit 99
}


# Import Functions
# $1 = directory path
#
function import_functions {
	DIR=$1
	
	# iterate through the files in the 'functions' folder
	for FUNCTION in $(dirname "$0")/$DIR/*; do
		# skip directories
		if [[ -d $FUNCTION ]]; then
			continue
		# exclude markdown readmes
		elif [[ $FUNCTION == *.md ]]; then
			continue
		elif [[ -f $FUNCTION ]]; then
			# source the function file
			. $FUNCTION
		fi
	done
}


# Import main functions
import_functions "functions"
import_functions "functions/script"
# Welcome message
echo_message welcome "$TITLE"
# Run system checks
system_checks
# main
while :
do
	main
done
#END OF SCRIPT
