# Check if terminal allows output, if yes, define colors for output
#
# Derived from https://github.com/pia-foss/manual-connections/blob/master/connect_to_wireguard_with_token.sh
if [[ -t 1 ]]; then
  ncolors=$(tput colors)
  if [[ -n $ncolors && $ncolors -ge 8 ]]; then
    red=$(tput setaf 1) # ANSI red
    green=$(tput setaf 2) # ANSI green
    nc=$(tput sgr0) # No Color
  else
    red=''
    green=''
    nc='' # No Color
  fi
fi