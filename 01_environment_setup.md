# Deploy a Virtualised Lab Environment on Cloud

To get started, you need a server on-premises or in the cloud. I considered buying a cheap old server, but I decided to use a cloud solution because it was loud and I did not have space for it. Each primary cloud provider offers initial credits for testing, which should be enough to experiment with the lab. I registered with AWS, Azure, and Google and decided to stay with Google because they provided a generous 600€ credit for three months upon registration. If you have an x86 machine with at least 16GB of RAM, I suggest running it on your hardware. Otherwise, the cloud is a solid alternative.

## Google Cloud VM Setup

To create a VM instance, I used the `gcloud` command:
``` sh
gcloud compute instances create {Your VM-Instance name} \
--project={Your project name} \
--zone={Cheapest zone near you} \
--machine-type=n2-standard-4 \
--network-interface=network-tier=STANDARD,stack-type=IPV4_ONLY,subnet=default \
--no-restart-on-failure \
--maintenance-policy=TERMINATE \
--provisioning-model=SPOT \
--instance-termination-action=STOP \
--max-run-duration=18000s \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
--enable-display-device \
--tags=http-server,https-server \
--create-disk=auto-delete=yes,boot=yes,device-name={Your-Device-Name},image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250111,mode=rw,size=50,type=pd-balanced \
--no-shielded-secure-boot \
--shielded-vtpm \
--shielded-integrity-monitoring \
--labels=goog-ec-src=vm_add-gcloud \
--enable-nested-virtualization \
--reservation-affinity=any \
```

Creating a VM instance through the Google Cloud Console is possible, but enabling nested virtualisation requires manual configuration via the CLI. I recommend writing a custom command for deployment. If something breaks, you can quickly redeploy the instance with a single command.

### Key Requirements for GNS3 Labs:

- Nested Virtualisation.
- Enable Display Device.
- Opened the RDP port in the Google Cloud firewall.

### Cost Optimisation:

- Network-tier standard (200GB for free).
- Use Spot instances.
- Manually stop your VM instance.

> [!Caution]
> Even if the VM instance is not running, you still need to pay for the disk storage.

### Basic commands:

- SSH connection:
	``` sh
	gcloud compute ssh {VM-Instance} --zone={Your-Zone}
	```
- Start the instance:
	``` sh
	gcloud compute instances start {VM-Instance} --zone={Your-Zone}
	```
- Stop the instance:
	``` sh
	gcloud compute instances stop {VM-Instance} --zone={Your-Zone}
	```

> [!TIP]
> You can always increase your instance’s disk size, RAM, and CPU cores, but you cannot shrink them.

## Configuration of Ubuntu server for GUI experience

After deployment, the server has an SSH connection without a desktop environment. We must install several applications and dependencies to access it through RDP.

### Install Important Dependencies

* Update & Upgrade the System:
	``` sh
	sudo apt update && sudo apt upgrade -y
	```
* Install System Dependencies:
	```sh
	sudo apt install -y python3 python3-pip \
                    qemu qemu-kvm libvirt-daemon-system libvirt-clients \
                    bridge-utils ubridge dynamips
	```
* Allow Non-Root Access to Networking:
	``` sh
	sudo usermod -aG ubridge $USER
	sudo usermod -aG libvirt,kvm $USER
	```

> [!Note]
> Log out and back in for changes to take effect.

### Install Xfce  Desktop Environment

```sh
sudo apt install xfce4 xfce4-goodies -y
```

### Install XRDP:

* Install application:
	``` sh
	sudo apt install -y xrdp
	```
* Add User to `ssl-cert` Group:
	``` sh
	sudo adduser $USER ssl-cert
	```
* Enable & Start XRDP:
	``` sh
	sudo systemctl enable xrdp
	sudo systemctl start xrdp
	```
* Set Xfce as the Default Session:
	``` sh
	echo "xfce4-session" > ~/.xsession
	chmod +x ~/.xsession
	```

### Install GNS3 and Additional Applications

* Install GNS3 on Ubuntu:
	``` sh
	sudo add-apt-repository ppa:gns3/ppa -y
	sudo apt install -y gns3-gui gns3-server
	```
* Install VNC Viewer:
	``` sh
	sudo apt install -y tigervnc-viewer
	```
* Install Spice for Remote Display:
	``` sh
	sudo apt install -y spice-client-gtk spice-vdagent virt-viewer
	```
* Install Firefox:
	``` sh
	sudo apt install -y firefox
	```
* Install Docker:
	``` sh
	sudo apt install -y docker.io
	sudo usermod -aG docker $USER
	sudo systemctl enable docker
	sudo systemctl start docker
	```

> [!Note]
> Log out and back in for changes to take effect.

## Troubleshooting Connection Issue

If you encounter a problem with the connection, one possible issue could be incorrect login credentials.

Through SSH connection, we can change and verify:
1. Current username:
	``` sh
	whoami
	```
2. Change password:
	``` sh
	sudo passwd <your_username>
	```

## Troubleshooting **0x204** Error with RDP

1. Reboot the RDP client on your device and try to reconnect again.
2. Check the status of xrdp and sesman:
	``` sh
	sudo systemctl status xrdp xrdp-sesman
	```
3. If there are errors, restart the services:
	``` sh
	sudo systemctl restart xrdp xrdp-sesman
	```
4. If you had an active `gns-server` after logging in, terminate it:
	``` sh
	sudo pkill -f gns3
	```
5. Try rebooting the system:
	``` sh
	sudo reboot
	```
6. Check logs to identify the issue:
	``` sh
	sudo journalctl -u xrdp --no-pager | tail -50
	```

## Resources & References

- Azure: https://azure.microsoft.com
- Google Cloud: https://cloud.google.com
- AWS: https://aws.amazon.com
- RDP client Windows: https://apps.microsoft.com/detail/9n1f85v9t8bn
- RDP client MacOS: https://apps.apple.com/np/app/windows-app/id1295203466