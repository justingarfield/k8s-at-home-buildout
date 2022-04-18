#!/bin/bash

# Only allow script to run as root
if (( EUID != 0 )); then
  echo -e "${red}This script needs to be run as root. Try again with 'sudo $0'${nc}"
  exit 1
fi

# Create sudoers file to allow current user to run 'sudo /usr/bin/dockerd' without a password
SUDOER_FILE="/etc/sudoers.d/$SUDO_USER-service-docker-start"
if [[ ! -f "$SUDOER_FILE" ]]; then
  echo "File $SUDOER_FILE does not exist. Creating..."
  echo "$SUDO_USER ALL=(ALL) NOPASSWD: /usr/sbin/service docker start" > $SUDOER_FILE
  chmod 440 $SUDOER_FILE
  echo "File $SUDOER_FILE created."
fi

# If we can't find the automatically start comment, add following to .bashrc
BASHRC_LOCATION="/home/$SUDO_USER/.bashrc"
if ! grep -q "# Automatically start docker service on login" $BASHRC_LOCATION; then
  echo ""
  echo "Adding automatic startup to $BASHRC_LOCATION"
  echo "# Automatically start docker service on login" >> $BASHRC_LOCATION
  echo "if [[ ! -f '/var/run/docker.pid' ]]; then" >> $BASHRC_LOCATION
  echo "  echo 'File /var/run/docker.pid does not exist. Starting docker service...'" >> $BASHRC_LOCATION
  echo "  sudo /usr/sbin/service docker start" >> $BASHRC_LOCATION
  echo "  echo 'Docker service started.'" >> $BASHRC_LOCATION
  echo "fi" >> $BASHRC_LOCATION
  echo ""
fi