# Switch Configuration

This document explains how to configure the core and access switches in the GNS3 environment.

## GNS3 Canvas Overview

![GNS3 Canvas - Switches](images/07/gns-3-canvas.png)

---

## Set Up the First Core Switch

1. In GNS3, place **5 Open vSwitch** devices on the canvas and rename them accordingly.
2. Open the console for **Core-Switch1**.
3. Check the current configuration:
   ```sh
   ovs-vsctl show
   ```
4. Remove all existing bridges:
   ```sh
   for br in $(ovs-vsctl list-br); do ovs-vsctl del-br $br; done
   ```
5. Verify again:
   ```sh
   ovs-vsctl show
   ```
6. Create a new bridge:
   ```sh
   ovs-vsctl add-br br0
   ```
7. Enable STP and set the priority:
   ```sh
   ovs-vsctl set bridge br0 stp_enable=true other-config:stp-priority=4096
   ```
8. Add a trunk port toward **pfSense**:
   ```sh
   ovs-vsctl add-port br0 eth0 trunk=9,10,20,30,40,99
   ```
9. Add a trunk port toward **Core-Switch2**:
   ```sh
   ovs-vsctl add-port br0 eth1 trunk=9,10,20,30,40,99
   ```
10. Add trunk ports toward Access Switches:
    - Access-Switch-1:
      ```sh
      ovs-vsctl add-port br0 eth2 trunk=10,20
      ```
    - Access-Switch-2:
      ```sh
      ovs-vsctl add-port br0 eth3 trunk=9,99
      ```
    - Access-Switch-3:
      ```sh
      ovs-vsctl add-port br0 eth4 trunk=10,30,40
      ```
11. Verify the final configuration:
    ```sh
    ovs-vsctl show
    ovs-appctl stp/show br0
    ```

---

## Set Up the Second Core Switch

Below is an example shell script you can run on **Core-Switch2**. You can also execute each command manually:

```bash
#!/bin/bash
# Exit immediately if any command fails
set -e

echo "Remove all existing bridges..."
for br in $(ovs-vsctl list-br)
do
	ovs-vsctl del-br $br
done

echo "Creating the Core Switch bridge..."
ovs-vsctl add-br br0

echo "Enable STP on the bridge..."
ovs-vsctl set Bridge br0 stp_enable=true

echo "Set STP priority to 8192..."
ovs-vsctl set Bridge br0 other-config:stp-priority=8192

echo "Creating a trunk port to pfSense..."
ovs-vsctl add-port br0 eth0 trunk=9,10,20,30,40,99

echo "Creating a trunk port to the first Core Switch..."
ovs-vsctl add-port br0 eth1 trunk=9,10,20,30,40,99

echo "Creating trunk ports for access switches"
ovs-vsctl add-port br0 eth2 trunk=10,20
ovs-vsctl add-port br0 eth3 trunk=9,99
ovs-vsctl add-port br0 eth4 trunk=10,30,40

echo "Displaying final configuration..."
ovs-vsctl show
ovs-appctl stp/show br0
```

12. Open the console of **Core-Switch2**.
13. Create a file:
   ```sh
   nano configure_coreSW2.sh
   ```
14. Paste in the script above, then save and exit (Ctrl+X, then Y).
15. Make the script executable:
   ```sh
   chmod +x configure_coreSW2.sh
   ```
16. Run it:
   ```sh
   ./configure_coreSW2.sh
   ```

---

## Set Up the First Access Switch

```bash
#!/bin/bash
# Exit immediately if any command fails
set -e

echo "Remove all existing bridges..."
for br in $(ovs-vsctl list-br)
do
	ovs-vsctl del-br $br
done

echo "Creating the Access Switch bridge..."
ovs-vsctl add-br br0

echo "Enable STP on the bridge..."
ovs-vsctl set bridge br0 stp_enable=true

echo "Creating a trunk port to Core Switch 1 and 2..."
ovs-vsctl add-port br0 eth0 trunk=10,20
ovs-vsctl add-port br0 eth1 trunk=10,20

echo "Creating ports for end-devices..."
ovs-vsctl add-port br0 eth2 tag=10
ovs-vsctl add-port br0 eth3 tag=10
ovs-vsctl add-port br0 eth4 tag=10
ovs-vsctl add-port br0 eth5 tag=20
ovs-vsctl add-port br0 eth6 tag=20
ovs-vsctl add-port br0 eth7 tag=20

echo "Set a higher path cost on the link to CoreSW2..."
ovs-vsctl set port eth1 other-config:stp-path-cost=20000

echo "Displaying final configuration..."
ovs-vsctl show
ovs-appctl stp/show br0
```

17. Open the console for **Access-Switch-1**.
18. Create a file:
   ```sh
   nano configure_accessSW-1.sh
   ```
19. Paste in the script, save, and exit (Ctrl+X, then Y).
20. Make the script executable:
   ```sh
   chmod +x configure_accessSW-1.sh
   ```
21. Run it:
   ```sh
   ./configure_accessSW-1.sh
   ```

---

## Set Up the Second Access Switch

```bash
#!/bin/bash
# Exit immediately if any command fails
set -e

echo "Remove all existing bridges..."
for br in $(ovs-vsctl list-br)
do
	ovs-vsctl del-br $br
done

echo "Creating the Access Switch bridge..."
ovs-vsctl add-br br0

echo "Enable STP on the bridge..."
ovs-vsctl set Bridge br0 stp_enable=true

echo "Creating a trunk port to Core Switch 1 and 2..."
ovs-vsctl add-port br0 eth0 trunk=9,99
ovs-vsctl add-port br0 eth1 trunk=9,99

echo "Creating ports for end-devices..."
ovs-vsctl add-port br0 eth2 tag=9
ovs-vsctl add-port br0 eth3 tag=9
ovs-vsctl add-port br0 eth4 tag=9
ovs-vsctl add-port br0 eth5 tag=99

echo "Set a higher path cost on the link to CoreSW2..."
ovs-vsctl set port eth1 other-config:stp-path-cost=20000

echo "Displaying final configuration..."
ovs-vsctl show
ovs-appctl stp/show br0
```

22. Open the console for **Access-Switch-2**.
23. Create a file:
   ```sh
   nano configure_accessSW-2.sh
   ```
24. Paste in the script, save, and exit.
25. Make the script executable:
   ```sh
   chmod +x configure_accessSW-2.sh
   ```
26. Run it:
   ```sh
   ./configure_accessSW-2.sh
   ```

---

## Set Up the Third Access Switch

```bash
#!/bin/bash
# Exit immediately if any command fails
set -e

echo "Remove all existing bridges..."
for br in $(ovs-vsctl list-br)
do
	ovs-vsctl del-br $br
done

echo "Creating the Access Switch bridge..."
ovs-vsctl add-br br0

echo "Enable STP on the bridge..."
ovs-vsctl set bridge br0 stp_enable=true

echo "Creating a trunk port to Core Switch 1 and 2..."
ovs-vsctl add-port br0 eth0 trunk=10,30,40
ovs-vsctl add-port br0 eth1 trunk=10,30,40

echo "Creating ports for end-devices..."
ovs-vsctl add-port br0 eth2 tag=10
ovs-vsctl add-port br0 eth3 tag=30
ovs-vsctl add-port br0 eth4 tag=30
ovs-vsctl add-port br0 eth5 tag=40

echo "Set a higher path cost on the link to CoreSW2..."
ovs-vsctl set Port eth1 other-config:stp-path-cost=20000

echo "Displaying final configuration..."
ovs-vsctl show
ovs-appctl stp/show br0
```

27. Open the console for **Access-Switch-3**.
28. Create a file:
   ```sh
   nano configure_accessSW-3.sh
   ```
29. Paste in the script, save, and exit.
30. Make it executable:
   ```sh
   chmod +x configure_accessSW-3.sh
   ```
31. Run it:
   ```sh
   ./configure_accessSW-3.sh
   ```

---

## Interconnecting Core and Access Switches

![GNS3 Canvas - Additional Switch Layout](images/07/gns-3-canvas-2.png)

32. **Core-Switch-1**:
   - `eth0` → Connect to **Firewall-Router-Primary (em3)**
   - `eth1` → Connect to **Core-Switch-2 eth1**
   - `eth2` → Connect to **Access-Switch-1 eth0**
   - `eth3` → Connect to **Access-Switch-2 eth0**
   - `eth4` → Connect to **Access-Switch-3 eth0**

33. **Core-Switch-2**:
   - `eth0` → Connect to **Firewall-Router-Secondary (em3)**
   - `eth1` → Connect to **Core-Switch-1 eth1**
   - `eth2`, `eth3`, `eth4` → Same pattern as Core-Switch-1 but for second links to the access switches

34. **Access-Switch-1, 2, 3**:
   - `eth0` → Connect to **Core-Switch-1**
   - `eth1` → Connect to **Core-Switch-2**

35. Connect **Web-Term** to `eth5` on **Access-Switch-2** (tagged VLAN 99).
36. Place a **Windows Server** VM and connect it (for example) to `eth2` on **Access-Switch-2** if desired.

---

## Configure Web-Term with New Network Settings

37. Right-click **Web-Term** → **Configure**.
38. In **General Settings**, go to **Network Configuration** → **Edit**.
39. Replace the existing static settings with:
   ```sh
   # Static configuration for eth0
   auto eth0
   iface eth0 inet static
       address 10.0.99.10
       netmask 255.255.255.0
       gateway 10.0.99.1
       up echo nameserver 8.8.8.8 > /etc/resolv.conf
   ```

---

## Turn Off MGMT Interface in pfSense

40. Log in to each pfSense instance (e.g., `10.0.99.2` for Primary, `10.0.99.3` for Secondary).
41. Navigate to **Interfaces > MGMT**.
42. Uncheck **Enable Interface**.
43. Click **Save** and then **Apply Changes**.

---
