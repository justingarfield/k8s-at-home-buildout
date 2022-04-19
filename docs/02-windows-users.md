# Windows Users

This section applies to Windows users only.

## Host OS and Firmware Updates

Before going any further, please make sure you've updated and applied patches for the following on your Host machine:

* Operating System via Windows Update
* BIOS / UEFI Firmware
* Hardware Drivers (audio, networking, disk, CPU microcode updates etc.)

## Install/Update Windows Subsystem for Linux

To ensure that WSL is installed, and that you also have the Ubuntu 20.04 image installed, type the following in an elevated prompt:
```shell
wsl --install --distribution Ubuntu-20.04
```

To ensure that the WSL Kernel is up-to-date, in an elevated prompt, type:
```shell
wsl --update
```

If you run multiple distributions under WSL, you can make your life easier with this stack by setting your default distribution to be the Ubuntu 20.04 one by typing the following in an elevated prompt:
```shell
wsl --set-default Ubuntu-20.04
```

## Install/Update Linux Distribution

The steps above updated the WSL Kernel, but doesn't actually affect anything inside of the Linux distributions that sit on-top-of the Kernel. In order to update the actual Ubuntu 20.04 Linux distribution, open up the Ubuntu 20.04 distribution via one of the shortcuts, or by typing in an elevated prompt:
```shell
wsl --distribution Ubuntu20.04
```
Note: for those with Ubuntu 20.04 as the default, you can just simply type `wsl` without any arguments

Once inside of the WSL distribution's shell (probably a bash shell), type the following to update Ubuntu:
```shell
sudo apt-get -y update && sudo apt-get -y upgrade
```

Once done applying updates, **restart the entire host machine**.

## Make sure WSL Kernel supports Wireguard

At the time of this writing, the WSL Kernel doesn't have the required feature flags enabled that the Wireguard VPN software requires.

Assuming you cloned this repository to your local Ubuntu 20.04 instance, you can type the following to run a bash script I've provided that will scan your WSL Kernel's currently running config and determine if a WSL Kernel recompile is required:

```shell
sudo bash k8s-at-home-buildout/scripts/rebuild-wsl-kernel-with-connmark.sh
```

If the script determined that a recompile was required, it will download the required tooling, clone the source code from GitHub, and perform a build automatically for you. This can take 5-10 minutes depending on your hardware.

If a recompilation did occur, **you will be required to follow some manual steps at the end of this to swap out the kernel binary on the Windows Host itself**. See output from the script when it finishes.