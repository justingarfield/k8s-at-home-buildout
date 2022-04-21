# Prerequisities

This chapter is _extremely_ important to follow. Failure to perform the steps provided here will likely lead to deployment of this stack going horribly wrong.

In this chapter:

* [OS, Driver and Firmware Updates](#updates)
* [Network / Firewall Rules](#networkFirewallRules)
* [Clone this Repository for Script Access](#cloneRepo)
* [Uninstall older Docker versions](#uninstallOld)

## <a id="updates"></a>OS, Driver and Firmware Updates

Before going any further, please make sure you've updated and applied patches for the following on your Host machine:

* Operating System
  * Windows 10 users - Windows Update
    * Keep checking until no more updates show, sometimes takes 2-3 sets of reboots/updates to finalize
  * Ubuntu/Debian users - `sudo apt-get update && sudo apt-get -y upgrade`
* BIOS / UEFI Firmware
* Hardware Drivers (specifically networking and storage)

_Note: Skip this step if you already did this in the WSL Users chapter._

## <a id="networkFirewallRules"></a>Network / Firewall Rules

In order for everything in this stack to properly function, you must ensure that the following traffic is allowed on your network: 

* Outbound Traffic
  * `443/TCP` - for HTTPS traffic
  * `1337/TCP` - for WireGuard VPN connectivity
  * `1337/UDP` - for WireGuard VPN connectivity

See also: `scripts/check-outgoing-ports.sh`

## <a id="cloneRepo"></a>Clone this Repository for Script Access

This repository provides convenience scripts to perform a majority of the steps required to provision this stack. Here we'll just simply clone this repository to your local machine, and make sure that all of the bash scripts in scripts/ are executable going forward.

As always, you should review the content of the bash scripts, so that you can understand what's actually going on.

_Note: Skip this step if you already did this in the WSL Users chapter to recompile the WSL Kernel._

```bash
sudo apt-get install -y git
cd ~ && pwd
git clone https://github.com/justingarfield/k8s-at-home-buildout.git
chmod 700 ~/k8s-at-home-buildout/scripts/*
```

Example output:

```bash
somedude@DESKTOP-FPUE1RT:~$ sudo apt-get install -y git
Reading package lists... Done
Building dependency tree
Reading state information... Done
git is already the newest version (1:2.25.1-1ubuntu3.3).
0 upgraded, 0 newly installed, 0 to remove and 11 not upgraded.
somedude@DESKTOP-FPUE1RT:~$ cd ~ && pwd
/home/somedude
somedude@DESKTOP-FPUE1RT:~$ git clone https://github.com/justingarfield/k8s-at-home-buildout.git
Cloning into 'k8s-at-home-buildout'...
remote: Enumerating objects: 140, done.
remote: Counting objects: 100% (140/140), done.
remote: Compressing objects: 100% (90/90), done.
remote: Total 140 (delta 73), reused 114 (delta 47), pack-reused 0
Receiving objects: 100% (140/140), 38.87 KiB | 1.62 MiB/s, done.
Resolving deltas: 100% (73/73), done.
somedude@DESKTOP-FPUE1RT:~$ chmod 700 ~/k8s-at-home-buildout/scripts/*
somedude@DESKTOP-FPUE1RT:~$
```