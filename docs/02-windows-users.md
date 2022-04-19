# Windows Users

In this chapter:

* [OS, Driver and Firmware Updates](#updates)
* [Install Windows Subsystem for Linux and Ubuntu 20.04 (Fresh WSL installs only)](#wsl)
* [Install Ubuntu 20.04 Distribution (Existing WSL installs only)](#distro)
  * [(optional) Default WSL distro to Ubuntu 20.04](#default)
* [Apply WSL Kernel Updates](#kernelUpdates)
* [Apply Ubuntu 20.04 Updates](#ubuntuUpdates)
* [Make sure WSL Kernel supports Wireguard](#wireguard)
* [Troubleshooting](#troubleshooting)
  * [WslRegisterDistribution failed with error: 0x80370102](#wslRegisterDistribution)

**This section applies to Windows users only.**

_Note: I'm referring to WSL2 as just 'WSL' going forward. WSL1 is extremely old at this point, and no one is really referring to it anymore._

## <a id="updates"></a>OS, Driver and Firmware Updates

Before going any further, please make sure you've updated and applied patches for the following on your Windows machine:

* Operating System via Windows Update
  * Keep checking until no more updates show, sometimes takes 2-3 sets of reboots/updates to finalize
* BIOS / UEFI Firmware
* Hardware Drivers (specifically networking and storage)

## <a id="wsl"></a>Install Windows Subsystem for Linux and Ubuntu 20.04 (Fresh WSL installs only)

The latest version of the WSL installer also downloads and installs Ubuntu by default. This stack was built using 20.04, so rather than pulling the generic Ubuntu distribution that could change over time and come out of alignment with this stack, we'll tell the WSL installer to also use Ubuntu 20.04 specifically.

Run the following commands in an administrator PowerShell:

```powershell
PS C:\users\somedude> wsl --install --distribution Ubuntu-20.04
Installing: Virtual Machine Platform
Virtual Machine Platform has been installed.
Installing: Windows Subsystem for Linux
Windows Subsystem for Linux has been installed.
Downloading: WSL Kernel
Installing: WSL Kernel
WSL Kernel has been installed.
Downloading: Ubuntu 20.04 LTS
The requested operation is successful. Changes will not be effective until the system is rebooted.
```

Now reboot Windows (as-per the instructions provided). When you log back in, a window should open up and continue installation. It should look like the following output here:

```bash
Installing, this may take a few minutes...
Please create a default UNIX user account. The username does not need to match your Windows username.
For more information visit: https://aka.ms/wslusers
Enter new UNIX username:
```

You will now need to configure a username and password, which can be completely different than your Windows usernmame/password. You're now in the actual Ubuntu distro. Once complete, your shell should look something like below. 

_Note: If you instead received an error code of `0x80370102`, see the [Troubleshooting](#wslRegisterDistribution) section below._

```bash
Enter new UNIX username: somedude
New password:
Retype new password:
passwd: password updated successfully
Installation successful!
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

Welcome to Ubuntu 20.04 LTS (GNU/Linux 5.10.16.3-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Apr 19 08:23:52 PDT 2022

  System load:  0.12               Processes:             8
  Usage of /:   0.4% of 250.98GB   Users logged in:       0
  Memory usage: 0%                 IPv4 address for eth0: 172.21.169.79
  Swap usage:   0%

0 updates can be installed immediately.
0 of these updates are security updates.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


This message is shown once once a day. To disable it please create the
/home/somedude/.hushlogin file.
somedude@DESKTOP-FPUE1RT:~$
```

## <a id="distro"></a>Install Ubuntu 20.04 Distribution (Existing WSL installs only)

**This step is for users that already have WSL installed on their machines**

If you already have WSL installed, you just need to make sure you have Ubuntu 20.04 available to run this stack on.

In an administrator PowerShell, type the following:

```powershell
PS C:\Users\somedude> wsl --install --distribution Ubuntu-20.04
```

If you already have the distribution, you should get output like this, and a bash prompt should open in another window:

```powershell
PS C:\Users\somedude> wsl --install --distribution Ubuntu-20.04
Ubuntu 20.04 LTS is already installed.
Launching Ubuntu 20.04 LTS...
```

Otherwise, it should download the distribution first, you should see output like below, and you will be prompted to setup a new user/password in another window (similar to the final steps under the fresh install instructions above):

```powershell
PS C:\Users\somedude> wsl --install --distribution Ubuntu-20.04
Downloading: Ubuntu 20.04 LTS
Installing: Ubuntu 20.04 LTS
Ubuntu 20.04 LTS has been installed.
Launching Ubuntu 20.04 LTS...
```

## <a id="default"></a>(optional) Default WSL distro to Ubuntu 20.04

If you run multiple distributions under WSL, you can make your life easier working with this stack by setting your default distribution to be Ubuntu 20.04. You can do this by typing the following in an elevated PowerShell terminal:

```powershell
PS C:\Users\somedude> wsl --set-default Ubuntu-20.04
```

You can see which distribution is set as a default if you look for an entry with `(Default)` next to it after running the following command:
```powershell
PS C:\Users\somedude> wsl --list
Windows Subsystem for Linux Distributions:
Ubuntu-20.04 (Default) <---
docker-desktop-data
docker-desktop
```

_Note: If you don't set Ubuntu 20.04 as your default, make sure you always launch the Ubuntu 20.04 distro by adding `-d Ubuntu-20.04` to `wsl.exe` calls / terminals._

## <a id="kernelUpdates"></a>Apply WSL Kernel Updates

Even if you did a fresh install of WSL above, chances are there are there's still a newer version of the WSL Kernel available. Let's make sure it's got the latest and greatest before proceeding any further.

In an administrator PowerShell:

```powershell
PS C:\Users\somedude> wsl --update
Checking for updates...
Downloading updates...
Installing updates...
This change will take effect on the next full restart of WSL. To force a restart, please run 'wsl --shutdown'.
Kernel version: 5.10.102.1
```

If you did in-fact have WSL Kernel updates, you'll need to do what the instructions say and run the following command as well:
```powershell
PS C:\Users\somedude> wsl --shutdown
```

## <a id="ubuntuUpdates"></a>Apply Ubuntu 20.04 Updates

Now that you have the WSL Kernel intalled/updated and an Ubuntu 20.04 distribution installed, it's time to update the Ubuntu distribution itself.

Open up your Ubuntu 20.04 distro...You can do this by clicking on the Ubuntu 20.04 App Store icon in the Start Menu, via a Windows Terminal tab, or by opening up PowerShell and typing `wsl.exe -d Ubuntu-20.04`

You should now be at a bash prompt and ready to upgrade Ubuntu 20.04 to the latest and greatest. We do that by issuing the following commands:

```bash
sudo apt-get update && sudo apt-get -y upgrade
```

Example output of what it should look like:

```bash
somedude@DESKTOP-FPUE1RT:~$ sudo apt-get update && sudo apt-get -y upgrade
[sudo] password for somedude:
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal InRelease [265 kB]
Get:3 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [1386 kB]

...

282 updates can be installed immediately.
169 of these updates are security updates.
To see these additional updates run: apt list --upgradable


*** System restart required ***  <----- notice this line re: system restart

...

Processing triggers for libc-bin (2.31-0ubuntu9.7) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for ca-certificates (20210119~20.04.2) ...
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
Processing triggers for initramfs-tools (0.136ubuntu6.7) ...
somedude@DESKTOP-FPUE1RT:~$
```

Once done applying updates, you will most likely need to "restart the system" according to apt-get upgrade. To do that with WSL, you can simply do what we did for the WSL Kernel as well, by running the following command, and re-opening Ubuntu 20.04 afterward.

```powershell
PS C:\Users\somedude> wsl --shutdown
```

## <a id="wireguard"></a>Make sure WSL Kernel supports Wireguard

`<TODO: Workflow order is fudged here...fresh install wouldn't have cloned yet>`
`<TODO: add example output from script for recompile w/ instruction steps>`

At the time of this writing, the WSL Kernel doesn't have the required feature flags enabled that the Wireguard VPN software requires.

Assuming you cloned this repository to your local Ubuntu 20.04 instance, you can type the following to run a bash script I've provided that will scan your WSL Kernel's currently running config and determine if a WSL Kernel recompile is required:

```bash
sudo bash k8s-at-home-buildout/scripts/rebuild-wsl-kernel-with-connmark.sh
```

If the script determined that a recompile was required, it will download the required tooling, clone the source code from GitHub, and perform a build automatically for you. This can take 5-10 minutes depending on your hardware.

If a recompilation did occur, **you will be required to follow some manual steps at the end of this to swap out the kernel binary on the Windows Host itself**. See output from the script when it finishes.

## <a id="troubleshooting"></a>Troubleshooting

### <a id="wslRegisterDistribution"></a>WslRegisterDistribution failed with error: 0x80370102

For users that receive the following message during WSL / Distro installation:
```shell
WslRegisterDistribution failed with error: 0x80370102
Error: 0x80370102 The virtual machine could not be started because a required feature is not installed.
```

If you are running your Windows instance as a VM inside of a HyperVisor, you need to ensure that Nested Virtualization is enabled for your VM. At the time of this writing, VirtualBox does NOT support Second-level Address Translation (SLAT), and therefore cannot be used to run this stack inside another VM.

If you are using Hyper-V, you can turn on Nested Virtualization for a particular VM via PowerShell by using: `Set-VMProcessor -VMName <your vm-name here> -ExposeVirtualizationExtensions $true`