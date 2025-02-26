# Deploy GNS3 Appliances for Network Simulation

Unfortunately, I do not have access to Cisco appliance licenses. Instead, I have chosen open-source solutions and evaluation versions of Windows Server and Windows 10 for my GNS3 lab.

## Chosen Appliances:

- **Open vSwitch** – Virtual switch for advanced networking.
- **pfSense** – Open-source firewall and router.
- **WebTerm** – Lightweight terminal for web-based access to pfSense.
- **Windows 10** – Evaluation version for testing.
- **Windows Server 2022** – Evaluation version for server simulations.

## Install Open vSwitch, pfSense, WebTerm

We can install Open vSwitch and WebTerm easily through GNS3. For that, we need:

1. Open **GNS3 GUI > File > New Template > Install an appliance from the GNS3 Server > Next**.
2. Find Open vSwitch in switches **> Install > Next**.
3. In the **Guests** category, locate **WebTerm** and install it.
4. In the **Firewalls** category, search for **pfSense**. 

> [!Caution]
> Downloading the pfSense's image requires registration on the official website. Additionally, the checksum provided on the site does not match the one shown in the GNS3 installation process.

## Install Windows 10 and Windows Server

These instructions apply to **Windows 10** and **Windows Server 2022** in GNS3. I did not use predefined settings.

### Create the Windows VM Template

1. Open **GNS3** > Click **New template**.
2. Select **Manually create a new template** > Choose **QEMU VMs** > Click **New**.
3. Enter **Windows 10** or **Windows Server 2022** > **Next**.
4. Set RAM to **2048 MB** > Click **Next**.
5. Console Type > Choose **VNC** >  Click **Next**.
6. Select **New Image** > Click **Create** > Choose **Qcow2** as the format.
7. Click **Next** > Click **Next** again.

### Configure the Windows VM

1. In the **End Devices** section of the GNS3 main window, right-click on your newly created template. 
2. Select **Configure template**.
3. Template Configuration:
	* **General settings** > **Boot priority** set to **CD/DVD-ROM**
	* **HDD** > Set to **SATA**.
	* **CD/DVD** > Click **Browse**, then select the **Windows ISO file**.
	* **Advanced** > Uncheck. **Use a linked base VM**  
	* Click **OK**.

### Install Windows

1. Drag the VM onto the GNS3 canvas.
2. Press **Start**, then open the console.
3. Wait **2 minutes**, then proceed with the **Windows installation**.
### Modify Settings After Installation

1. In the **End Devices** section, right-click your Windows VM. 
2. Select **Configure template**.
3. Modify the template settings:
	* **General Settings** > Set **Boot Priority** to **HDD**.
	* **CD/DVD** > Remove all mounted images.
	* **Advanced** > Check **Use a linked base VM** 
	* Click **OK**.

## Installing Guest-Tools Drivers

I recommend installing drivers for better performance. I chose Spice because VNC does not support a working clipboard in a nested VM.(In my case)
### Mount the VirtIO ISO in GNS3

1. In the **End Devices** section of the GNS3 main window, right-click on your Windows template.
2. Select **Configure template**.
3. Template Configuration:
	* **CD/DVD** > Click **Browse**, then select the **Virtio ISO file**.
	* **Advanced** > Uncheck. **Use a linked base VM**.
	* Click **OK**.
### Install Guest Tools

1. Drag our VM to the canvas. 
2. Press start, then open the console.
3. Install the guest tools from the mounted ISO.
4. Restart the VM

### Final Configuration

1. Right-click on your Windows template in the End Devices section of the GNS3 main window. 
2. Select **Configure template**.
3. Modify the template settings:
	* **Console type** > Spice+agent
	* **CD/DVD** > Remove the **VirtIO ISO path.**
	* **Advanced** > Check **Use a linked base VM**
	* Click **OK**.

> [!NOTE]
> I suggest increasing the RAM to 4096MB for the server and configuring the vCPUs to 2.

## Resources & References

- Windows 10 Evaluation: https://www.microsoft.com/en-us/software-download/windows10ISO
- Windows 2022 Evaluation: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
- Guest Tools Drivers: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/
