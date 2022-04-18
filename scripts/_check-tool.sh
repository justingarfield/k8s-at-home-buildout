# This function allows you to check if the required tools have been installed.
#
# Derived from https://github.com/pia-foss/manual-connections/blob/master/connect_to_wireguard_with_token.sh
check_tool() {
  cmd=$1
  if ! command -v "$cmd" >/dev/null; then
    echo "$cmd could not be found"
    echo "Please install $cmd"
    exit 1
  fi
}