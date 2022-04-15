#!/bin/bash

###
#
# This script determines if the currently running WSL Kernel was compiled with support for the features required to run Wireguard.
#
# If it's determined that the WSL Kernel must be recompiled it will:
#  * Download and install the required tooling for recompiling the WSL Kernel
#  * Determine the correct branch to pull from the WSL Kernel GitHub repository and clone with a depth of 1
#  * Copy the running Kernel Config into the WSL Kernel build directory and enable the required feature flags
#  * Build/compile a new version of the running WSL Kernel that includes support for Wireguard features
#  * Place a copy of the newly built WSL Kernel on the Host OS, located at C:\temp\wsl-kernel-build\kernel
#  * Provide instructions at the very end, informing the user how to proceed with their newly build WSL Kernel
#
# See: https://www.reddit.com/r/bashonubuntuonwindows/comments/jk4x24/is_there_a_way_to_run_wireguard_within_wsl2/
#      https://itgaertner.net/posts/wireguard-in-wsl/
#
###

# Check if terminal allows output, if yes, define colors for output
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

# Only allow script to run as root
if (( EUID != 0 )); then
  echo -e "${red}This script needs to be run as root. Try again with 'sudo $0'${nc}"
  exit 1
fi

kernelNeedsRecompile=false

if [ -z $(zcat /proc/config.gz | grep -i CONFIG_NETFILTER_XT_CONNMARK=y) ]; then
  echo "${red}Currently running WSL Kernel does not have CONFIG_NETFILTER_XT_CONNMARK support${nc}"
  kernelNeedsRecompile=true
else
  echo "${green}Currently running WSL Kernel has CONFIG_NETFILTER_XT_CONNMARK support${nc}"
fi

if [ -z $(zcat /proc/config.gz | grep -i CONFIG_NETFILTER_XT_MATCH_CONNMARK=y) ]; then
  echo "${red}Currently running WSL Kernel does not have CONFIG_NETFILTER_XT_MATCH_CONNMARK support${nc}"
  kernelNeedsRecompile=true
else
  echo "${green}Currently running WSL Kernel has CONFIG_NETFILTER_XT_MATCH_CONNMARK support${nc}"
fi

if $kernelNeedsRecompile; then
  echo "${red}WSL Kernel needs to be recompiled with required feature flags${nc}"
else
  echo "${green}Currently running WSL Kernel has required feature flags for Wireguard support. No need to recompile${nc}"
  exit 0
fi

echo "Installing tools required to recompile the WSL Kernel."
apt-get install -y -q \
  libelf-dev \
  build-essential \
  pkg-config \
  git \
  bison \
  flex \
  libssl-dev \
  bc

gitHubBranch=linux-msft-wsl-$(uname -r | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')
echo "Derived a GitHub branch name of '${gitHubBranch}' to clone currently running Kernel source"

if [ -d "./WSL2-Linux-Kernel" ]; then
  echo "WSL2-Linux-Kernel folder already exists, skipping 'git clone'"
else
  echo "Cloning the $gitHubBranch branch of the WSL2-Linux-Kernel GitHub repository"
  git clone --branch $gitHubBranch --depth 1 --quiet https://github.com/microsoft/WSL2-Linux-Kernel.git
fi

echo "Making a copy of the running Kernel configuration"
zcat /proc/config.gz > ./WSL2-Linux-Kernel/.config

echo "Updating Kernel configuration copy with CONFIG_NETFILTER_XT_CONNMARK and CONFIG_NETFILTER_XT_MATCH_CONNMARK feature flags set"
sed -i '/# CONFIG_NETFILTER_XT_CONNMARK is not set/c\CONFIG_NETFILTER_XT_CONNMARK=y' ./WSL2-Linux-Kernel/.config
sed -i '/# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set/c\CONFIG_NETFILTER_XT_MATCH_CONNMARK=y' ./WSL2-Linux-Kernel/.config

echo "Compiling WSL Kernel"
make -j $(nproc) -C ./WSL2-Linux-Kernel
make -j $(nproc) -C ./WSL2-Linux-Kernel modules_install

echo "Copying newly compiled Kernel over to Windows filesystem"
mkdir -p /mnt/c/temp/wsl-kernel-build
cp ./WSL2-Linux-Kernel/arch/x86/boot/bzImage /mnt/c/temp/wsl-kernel-build/kernel

echo ""
echo ""
echo ""
echo "Done recompiling WSL Linux Kernel with CONFIG_NETFILTER_XT_CONNMARK and CONFIG_NETFILTER_XT_MATCH_CONNMARK features enabled."
echo ""
echo "You now need to do the following:"
echo " * Shutdown this running WSL instance by running this in a CMD/PowerShell terminal on the Host: 'wsl --shutdown'"
echo " * Make a copy of 'C:\Windows\System32\lxss\tools\kernel' to have as a backup"
echo " * Overwrite 'C:\Windows\System32\lxss\tools\kernel' with 'C:\temp\wsl-kernel-build\kernel'"
echo " * Restart WSL instance"
echo ""
echo ""
echo ""