#!/bin/bash

# If we can't find the automatically start comment, add following to .bashrc
BASHRC_LOCATION="/home/$SUDO_USER/.bashrc"
if ! grep -q "# Automatically start minikube on login" $BASHRC_LOCATION; then
  echo ""
  echo "Adding minikube automatic startup to $BASHRC_LOCATION"
  echo "# Automatically start minikube on login" >> $BASHRC_LOCATION
  echo "... <add logic here> ..."
  echo ""
fi