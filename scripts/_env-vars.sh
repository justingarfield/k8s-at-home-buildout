IS_WSL=false

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  local DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
  if [[ ${DISTRIB} = "Ubuntu"* ]]; then
    if uname -a | grep -q '^Linux.*Microsoft'; then
      IS_WSL=true
    else
      # native ubuntu
    fi
  elif [[ ${DISTRIB} = "Debian"* ]]; then
    # debian
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS OSX
fi