# K8s @ Home Buildout

---

**!! WARNING !!**

**THIS REPOSITORY CONTAINS LOTS OF RAW CODE THAT HASN'T BEEN FULLY POLISHED OR TESTED YET. USE WITH EXTREME CAUTION!**

**YOU HAVE BEEN WARNED**

---

This repository holds all of the scripts, deployment variables, Helm charts, etc. that I use for my personal [K8s at Home](https://k8s-at-home.com/) build-out. I placed it here in-case anyone else is looking for a similar solution, and can hopefully save folks hours of ripping their hair out.

Most of the scripts and example code in this repository should run for users with native Ubuntu/Debian Linux installs as their Host OS. The main reason I chose to target WSL on Windows 10 is to not only show that it's possible to run a full K8s stack in WSL, but also to provide a solution for Windows users who can't, or don't want to use, Docker Desktop.

## Assumptions

* You do not currently have anything running on ports `80` or `443` on the machine you're going to run this stack on
* You are on a machine with a CPU that supports virtualization technologies
* You DO NOT have Docker Desktop installed
* You wish to run everything in Windows Subsystem for Linux w/ an Ubuntu 20.04 instance
* You have applied all of the latest updates/patches for:
  * Operating System
  * Windows Subsystem for Linux Kernel (if using Windows)
  * BIOS / UEFI Firmware
  * Hardware
* You are using [Private Internet Access](https://www.privateinternetaccess.com/) as your Anonymous VPN provider

## Where do I start?

See the [docs/](docs/) folder. Starting with the [Table of Contents](docs/00-table-of-contents.md).

## Testing

This repository has been tested inside of a fresh Ubuntu 20.04 distribution using the Windows Subsystem for Linux kernel, on-top of a fresh Windows 10 Professional install with all Windows Updates applied prior.

## DISCLAIMER

Please note that everything in this repository is highly opinionated and derived from my own personal experiences thus far using Containers, Kubernetes, PVR Software, and anything else contained within. There is no support for these scripts in chat channels, Discord, etc., so use at your own risk.