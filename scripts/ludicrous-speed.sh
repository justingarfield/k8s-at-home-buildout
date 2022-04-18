#!/bin/bash

# Run this from your home directory, as it's going to clone some GitHub repos down locally
# This script should only be used on brand-new WSL / Ubuntu 20.04 installs, or existing ones that you could care less about trashing.
# This is pretty much an "automated kitchen sink" installer

source "$(dirname "$0")/_env-vars.sh"

while true; do

read -p "Do you want to proceed? (y/n) " yn

case $yn in 
	[yY] ) echo ok, we will proceed;
		break;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac

done

echo doing stuff...

echo "=== Phase 1 - Prerequisites\n"

echo "=== Phase 1 - Step 1 - Windows Subsystem for Linux (WSL) Checks\n"
# Check if inside WSL
# Check to see if kernel needs recompiling

echo "=== Phase 1 - Step 2 - Outbound Ports Check"
# Run choeck-outgoing-ports.sh

echo "=== Phase 1 - "
echo "Checking minikube..."

