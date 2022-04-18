# Only allow script to run as root
#
# Derived from https://github.com/pia-foss/manual-connections/blob/master/run_setup.sh
if (( EUID != 0 )); then
  echo -e "${red}This script needs to be run as root. Try again with 'sudo $0'${nc}"
  exit 1
fi