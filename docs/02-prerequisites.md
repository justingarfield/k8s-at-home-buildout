# Prerequisities

This chapter is _extremely_ important to follow. Failure to perform the steps provided here will likely lead to deployment of this stack going horribly wrong.

---

## Host OS and Firmware Updates

Before going any further, please make sure you've updated and applied patches for the following on your Host machine:

* Operating System
  * Windows 10 users - Windows Update
  * Ubuntu/Debian users - `sudo apt-get -y update && sudo apt-get -y upgrade`
* BIOS / UEFI Firmware
* Hardware Drivers (audio, networking, disk, CPU microcode updates etc.)

---

## Network / Firewall Rules

In order for everything in this stack to properly function, you must ensure that the following traffic is allowed on your network: 

* Outbound Traffic
  * `443/TCP` - for HTTPS traffic
  * `1337/TCP` - for WireGuard VPN connectivity
  * `1337/UDP` - for WireGuard VPN connectivity

---

## Clone this Repository for Script Access

This repository provides convenience scripts to perform a majority of the steps required to provision this stack. Here we'll just simply clone this repository to your local machine, and make sure that all of the bash scripts in scripts/ are executable going forward.

Note: This is to be performed on your Ubuntu 20.04 instance (Windows doesn't do bash ;-\))

As always, you should review the content of the bash scripts, so that you can understand what's actually going on.

```shell
cd ~
git clone https://github.com/justingarfield/k8s-at-home-buildout.git
chmod 700 k8s-at-home-buildout/scripts/*
```

---

## Windows 10 Users Only

This section applies to Windows 10 users only.

### Install/Update Windows Subsystem for Linux

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

### Install/Update Linux Distribution

The steps above updated the WSL Kernel, but doesn't actually affect anything inside of the Linux distributions that it launches. In order to update the actual Ubuntu 20.04 Linux distribution, open up the Ubuntu 20.04 distribution via one of the shortcuts, or by typing in an elevated prompt:
```shell
wsl --distribution Ubuntu20.04
```
Note: for those with Ubuntu 20.04 as the default, you can just simply type `wsl` without any arguments

Once inside of the WSL distribution's shell (probably a bash shell), type the following to update Ubuntu:
```shell
sudo apt-get -y update && sudo apt-get -y upgrade
```

Once done applying updates, **restart the entire host machine**.

### Make sure WSL Kernel supports Wireguard

At the time of this writing, the WSL Kernel doesn't have the required feature flags enabled that the Wireguard VPN software requires.

Assuming you cloned this repository to your local Ubuntu 20.04 instance, you can type the following to run a bash script I've provided that will scan your WSL Kernel's currently running config and determine if a WSL Kernel recompile is required:

```shell
sudo bash k8s-at-home-buildout/scripts/rebuild-wsl-kernel-with-connmark.sh
```

If the script determined that a recompile was required, it will download the required tooling, clone the source code from GitHub, and perform a build automatically for you. This can take 5-10 minutes depending on your hardware.

If a recompilation did occur, **you will be required to follow some manual steps at the end of this to swap out the kernel binary on the Windows Host itself**. See output from the script when it finishes.

---

## Uninstall older Docker versions

Older versions of Docker were called `docker`, `docker.io`, or `docker-engine`. If these are installed, uninstall them. [See this section](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions) for more detailed information.

If you want to do a full uninstall of older versions, also [see this section](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions).

---

## Prepare your Ubuntu 20.04 WSL Environment

It's assumed that everything in this section is being typed into a bash shell on Ubuntu 20.04, not the Windows 10 host.

```shell
sudo bash k8s-at-home-buildout/scripts/prerequisites.sh
```