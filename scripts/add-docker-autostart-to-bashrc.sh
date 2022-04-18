#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_root-only.sh"

# Create sudoers file to allow current user to run 'sudo /usr/bin/dockerd' without a password
SUDOER_FILE="/etc/sudoers.d/$SUDO_USER-service-docker-start"
if [[ ! -f "$SUDOER_FILE" ]]; then
  echo "File $SUDOER_FILE does not exist. Creating..."
  echo "$SUDO_USER ALL=(ALL) NOPASSWD: /usr/sbin/service docker start" > $SUDOER_FILE
  chmod 440 $SUDOER_FILE
  echo "File $SUDOER_FILE created."
fi

# If we can't find the automatically start comment, add following to .bashrc
BASHRC_FILE="/home/$SUDO_USER/.bashrc"
if ! grep -q "# Automatically start docker service on login" $BASHRC_FILE; then
  echo ""
  echo "Adding automatic startup to $BASHRC_FILE"
  echo "# Automatically start docker service on login" >> $BASHRC_FILE
  echo "if [[ ! -f '/var/run/docker.pid' ]]; then" >> $BASHRC_FILE
  echo "  echo 'File /var/run/docker.pid does not exist. Starting docker service...'" >> $BASHRC_FILE
  echo "  sudo /usr/sbin/service docker start" >> $BASHRC_FILE
  echo "  echo 'Docker service started.'" >> $BASHRC_FILE
  echo "fi" >> $BASHRC_FILE
  echo ""
fi