#!/bin/bash

# Secure OpenVPN server installer for Debian, Ubuntu, CentOS, Fedora and Arch Linux
# https://github.com/angristan/openvpn-install

function isRoot () {
	if [ "$EUID" -ne 0 ]; then
		return 1
	fi
}

function initialCheck () {
	if ! isRoot; then
		echo "Sorry, you need to run this as root"
		exit 1
	fi
}

function checkClient () {
	NUMBEROFCLIENTS=$(tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep -c "^V")
	if [[ "$NUMBEROFCLIENTS" = '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo "Existing client certificates"
	echo "Total clients = $NUMBEROFCLIENTS"
	tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '
}

function checkUsage () {
	
}

function manageMenu () {
	clear
	echo "Welcome to OpenVPN Audit"
	echo "The git repository is available at: https://github.com/angristan/openvpn-install"
	echo ""
	echo "It looks like OpenVPN is already installed."
	echo ""
	echo "What do you want to do?"
	echo "   1) Check Clients"
	echo "   2) Check Usage"
	echo "   3) Option 3"
	echo "   4) Exit"

	until [[ "$MENU_OPTION" =~ ^[1-4]$ ]]; do
		read -rp "Select an option [1-4]: " MENU_OPTION
	done

	case $MENU_OPTION in
		1)
			checkClient
		;;
		2)
			echo "Working on Option"
		;;
		3)
			echo "Working on Option"
		;;
		4)
			exit 0
		;;
	esac
}


# Check for root, TUN, OS...
initialCheck

# Check if OpenVPN is already installed
if [[ -e /etc/openvpn/server.conf ]]; 
	then manageMenu
else
	echo "Please install OpenVPN"
fi