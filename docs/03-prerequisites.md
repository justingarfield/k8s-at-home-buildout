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

See also: `scripts/check-outgoing-ports.sh`

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

## Uninstall older Docker versions

Older versions of Docker were called `docker`, `docker.io`, or `docker-engine`. If these are installed, uninstall them. [See this section](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions) for more detailed information.

If you want to do a full uninstall of older versions, also [see this section](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions).

---

## Prepare your Ubuntu 20.04 WSL Environment

It's assumed that everything in this section is being typed into a bash shell on Ubuntu 20.04, not the Windows 10 host.

```shell
sudo bash k8s-at-home-buildout/scripts/prerequisites.sh
```