# Configure pfSense for High Availability & VLAN Trunking

## Assign IP to LAN Interface

1. Open the **pfSense Console**.
2. Select **Set interface(s) IP address** and enter **Option 2**.
3. Choose the interface to configure by entering **2** (for LAN).
4. Configure the IPv4 address:
   - When prompted for DHCP, type `n`.
   - Enter `10.0.5.2` for the first pfSense or `10.0.5.3` for the second.
   - Set the subnet bit count to `24`.
5. Press **Enter** to confirm.
6. Configure the IPv6 address:
   - When prompted for DHCP6, type `n`.
   - Press **Enter** to skip.
7. When asked to enable the DHCP server on LAN, type `n`.
8. To keep HTTPS as the webConfigurator protocol, type `n`.
9. Press **Enter** to finalise the settings.

## Configure Web-Terminal Access

1. Connect **pfSense Firewall Primary (em2)** to **pfSense Firewall Secondary (em2)**.
2. Drag the **OpenvSwitch** to the canvas.
3. Connect both firewalls and the **Web-Term** to the OpenvSwitch.
4. Right-click on **Web-Term** and select **Configure**.
5. In **General Settings**, go to **Network Configuration** and click **Edit**.
6. Replace the existing static settings with the following configuration:

```sh
# Static configuration for eth0
auto eth0
iface eth0 inet static
    address 10.0.5.10
    netmask 255.255.255.0
    gateway 10.0.5.1
    up echo nameserver 8.8.8.8 > /etc/resolv.conf
```

## Configure SYNC Port on the Primary Firewall

1. Open the console in **Web-Term**.
2. In your browser, navigate to `https://10.0.5.2/`:
   - **Login:** `admin`
   - **Password:** `pfsense`
3. Navigate to **Interfaces > Assignments**.
4. Click **Add**, select `em2`, and then click **Edit**.
5. Enable the interface by checking **Enable Interface**.
6. Set the **Description** to `SYNC`.
7. For **IPv4 Configuration Type**, select **Static IPv4**.
8. Set the **IPv4 Address** to `10.0.6.254` with a CIDR of `24`.
9. Click **Save** and then **Apply Changes**.

## Configure SYNC Port on the Secondary Firewall

1. In your browser, navigate to `https://10.0.5.3/`:
   - **Login:** `admin`
   - **Password:** `pfsense`
2. Configure the SYNC port by setting the **IPv4 Address** to `10.0.6.253` with a CIDR of `24`.

## Configure Firewall Rules

Create identical firewall rules on both firewalls.

![Firewall Rules Sync](docs/04/firewall-rules-sync.png)

## Set Up High Availability

1. Go to **System > High Availability**.
2. Enable **Synchronize States** and confirm.
3. Set **pfsync Synchronize Peer IP** to `10.0.6.253`.
4. Set **Synchronize Config to IP** to `10.0.6.253`.
5. Enter the **Remote System Username** as `Admin` and the **Remote System Password** as `pfsense`.
6. Enable **Synchronize Admin** and confirm.
7. Click **Toggle All** to synchronize all settings.
8. Click **Save**.

> [!NOTE]
> To verify synchronization, create a new user on the primary firewall. All settings should replicate to the backup firewall.

## Set Up CARP for Redundancy

1. Navigate to **Firewall > Virtual IP**.
2. Click **Add** and select **CARP** as the type.
3. Choose **LAN** as the interface.
4. Set the **Virtual IP Address** to `10.0.5.1`.
5. Specify a **Virtual IP Password**.
6. Set the **VHID Group** to `5`.
7. Click **Save**.

## Verify CARP Settings

1. Navigate to **Status > CARP (Failover)**.
2. Verify that the CARP status is correct on both firewalls.

![CARP Status](docs/04/status-carp.png)
![CARP Status 2](docs/04/status-carp-2.png)

## Rename LAN Port

1. Log in to the primary firewall.
2. Navigate to **Interfaces > LAN**.
3. Change the **Description** to `MGMT`.
4. Click **Save** and then **Apply Changes**.
5. Repeat the same steps on the secondary firewall.

## Create a Trunk Parent Interface

1. Log in to the primary firewall.
2. Go to **Interfaces > Assignments**.
3. Under **Available Network Ports**, locate `em3` and click **Add**.
4. Assign it to an available slot (e.g., **OPT2**).
5. Enable the interface by selecting **Enable Interface**.
6. Set the **Description** to `VLAN_TRUNK`.
7. Repeat the configuration on the secondary firewall.

## Create VLAN Interfaces

1. Log in to the primary firewall via `https://10.0.5.2/`.
2. Navigate to **Interfaces > Assignments > VLANs**.
3. Click **Add** to create a new VLAN:
   - **Parent Interface:** `em3`
   - **VLAN Tag:** `9`
   - **Description:** `Infrastructure`
4. Repeat the process to create VLANs with tags `10`, `20`, `30`, and `40`.
5. Perform the same steps on the secondary firewall by accessing `https://10.0.5.3/`.

> [!NOTE]
> pfSense does not synchronise VLAN configurations in HA mode.

### Final VLAN Configuration

![VLAN Interfaces](docs/04/interfaces-vlans.png)

## Interface Assignments on the Primary Firewall

| **VLAN** | **Description** | **Address** | **CIDR** |
| -------- | --------------- | ----------- | -------- |
| 9        | VLAN_INFRA      | 10.0.9.2    | 24       |
| 10       | VLAN_IT         | 10.0.10.2   | 24       |
| 20       | VLAN_SALS       | 10.0.20.2   | 24       |
| 30       | VLAN_FIN        | 10.0.30.2   | 24       |
| 40       | VLAN_HR         | 10.0.40.2   | 24       |

1. Navigate to **Interfaces > Interface Assignments**.
2. From the list of available network ports, assign each VLAN to an interface slot (e.g., **OPT2**, **OPT3**, etc.).
3. Click on each interface (e.g., “OPT3”) to configure:
   - **Enable** the interface.
   - Set the **Description** (e.g., `VLAN_Infra`).
   - Choose **Static IPv4** for the configuration type.
   - Assign an IPv4 address (for example, `10.0.8.2/24` for a VLAN).
4. Repeat for all VLANs.

## Interface Assignments on the Secondary Firewall

| **VLAN** | **Description** | **Address** | **CIDR** |
| -------- | --------------- | ----------- | -------- |
| 9        | VLAN_INFRA      | 10.0.9.3    | 24       |
| 10       | VLAN_IT         | 10.0.10.3   | 24       |
| 20       | VLAN_SALS       | 10.0.20.3   | 24       |
| 30       | VLAN_FIN        | 10.0.30.3   | 24       |
| 40       | VLAN_HR         | 10.0.40.3   | 24       |

Repeat the interface assignment steps on the secondary firewall by navigating to `https://10.0.5.3/`.

## Create CARP for Every VLAN

| **VLAN** | **Description** | **Address** | **CIDR** |
| -------- | --------------- | ----------- | -------- |
| 9        | VLAN_INFRA      | 10.0.9.1    | 24       |
| 10       | VLAN_IT         | 10.0.10.1   | 24       |
| 20       | VLAN_SALS       | 10.0.20.1   | 24       |
| 30       | VLAN_FIN        | 10.0.30.1   | 24       |
| 40       | VLAN_HR         | 10.0.40.1   | 24       |

1. Navigate to **Firewall > Virtual IP**.
2. Click **Add** and select **CARP** as the type.
3. Choose **LAN** as the interface.
4. Set a **Virtual IP Password**.
5. For each VLAN, select the corresponding **VHID Group** and manually create a Virtual IP.

### Final CARP Settings

![Firewall Virtual IPs](docs/04/firewall-virtual-ips.png)
