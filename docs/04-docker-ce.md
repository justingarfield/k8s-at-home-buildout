# Docker CE

In this chapter:

* [Uninstall older Docker versions](#uninstallOld)
* [Install Docker CE via Script](#installViaScript)
* [Install Docker CE Manually](#installManually)
  * [Download and Install the Docker CE binaries](#downloadAndInstall)
  * [](#)

## <a id="uninstallOld"></a>Uninstall older Docker versions

Older versions of Docker were called `docker`, `docker.io`, or `docker-engine`. If these are installed, uninstall them. [See this section](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions) for more detailed information.

If you want to do a full uninstall of older versions, also [see this section](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions).

## <a id="installViaScript"></a>Install Docker CE via Script

For those seeking ultimate convenience, simply run the below script:

```bash
sudo ./k8s-at-home-buildout/scripts/bootstrap-docker.sh
```

## <a id="installManually"></a>Install Docker CE Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

### <a id="downloadAndInstall"></a>Download and Install the Docker CE binaries

```bash
apt-get -qq update \
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
&& echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Download, install, and start Docker, Docker CLI, and Containerd
apt-get -qq update \
&& apt-get install -y \
  docker-ce=5:20.10.14~3-0~ubuntu-focal \
  docker-ce-cli=5:20.10.14~3-0~ubuntu-focal \
  containerd.io=1.5 \

service docker start

sudo usermode -aG docker $USER && newgrp docker
```

## Automatically start Docker in WSL

**NOTE: This section is for Windows / WSL users only**

Usually docker would start automatically on an Ubuntu / Debian install, since they use a subsystem called systemd that docker automatically adds a start file to. Unfortunately in WSL, there's no systemd install OOTB, so we need to add our own logic to startup docker when you first login to your WSL instance.

### The quick way

```bash
./k8s-at-home-buildout/scripts/add-docker-autostart-to-bashrc.sh
```

### The manual way

Add the following file to `/etc/sudoers.d`. This will allow your user account to call the `/usr/sbin/service docker start` without requiring a sudo password.

```bash
<your username here> ALL=(ALL) NOPASSWD: /usr/sbin/service docker start" > /etc/sudoers.d/<your username here>-service-docker-start
```

Add the following to your `~/.bashrc` file. This logic will run when you login to your Ubuntu instance.

```bash
# Automatically start docker service on login
if [[ ! -f '/var/run/docker.pid' ]]; then
  echo 'File /var/run/docker.pid does not exist. Starting docker service...'
  sudo /usr/sbin/service docker start
  echo 'Docker service started.'
fi
```
