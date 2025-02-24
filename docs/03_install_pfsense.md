# Install and Configure pfSense Firewall

## Add pfSense and Cloud NAT to the GNS3 Canvas:

1. Open **GNS3**.
2. Drag the **pfSense** firewall to the canvas.
3. Drag **Cloud NAT** (found under **End Devices**) to the canvas.
4. Connect **pfSense (em0)** to **Cloud NAT**.

## Start pfSense and Begin Installation:

1. **Start** the pfSense VM.
2. Open the **Console**.
3. Accept the terms and Install **pfSense**.

## Configure WAN Interface

1. **WAN Interface**:
	Select **em0** > Click **Continue**.
2. Confirm basic settings with **DHCP**.

## Configure LAN Interface

1. **LAN Interface**:
	Select **em1** > Click **Continue**.
2. Set **Interface Mode** to **Static**.
3. Disable **DHCP**.

## Finalise Installation
1. Confirm settings for **em1 (LAN Interface)**.
2. Click **Continue**.
3. Click **Install CE**.
4. Click **Continue** and confirm prompts several times
5. Reboot.

## Configure the second Router

* Repeat the same steps as for the first router.

> [!Tip]
> Ensure you create a snapshot before significant changes
> 1. Go to **File > Manage Snapshots** in GNS3
> 2. Click "**Create Snapshot**"

## Resources & References

* pfSense Documentation: https://docs.netgate.com/pfsense/en/latest/
