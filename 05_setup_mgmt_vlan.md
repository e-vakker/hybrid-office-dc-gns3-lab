# Setup Management VLAN (MGMT_VLAN)

## Create a New VLAN on the Primary Firewall

1. Log into the primary pfSense at `10.0.5.2`.
2. Navigate to **Interfaces > Assignments > VLANs**, then click **Add**.
3. Configure the following settings:
   - **Parent Interface:** Select `em3`.
   - **VLAN Tag:** Enter `99`.
   - **Description:** Enter `Management`.

## Assign the VLAN to an Interface on the Primary Firewall

1. Go to **Interfaces > Assignments**.
2. From the **Available network ports**, select **VLAN99 on em3** and click **Add**.

## Configure the MGMT Interface on the Primary Firewall

1. Enable the new interface by checking **Enable Interface**.
2. Set the following parameters:
   - **Description:** Enter `VLAN_MGMT`.
   - **IPv4 Configuration Type:** Select **Static IPv4**.
   - **IPv4 Address:** Enter `10.0.99.2/24`.
3. Click **Save** and then **Apply Changes**.

## Configure the MGMT VLAN on the Secondary Firewall

1. Log into the secondary pfSense at `10.0.5.3`.
2. Repeat the steps from Sections 1 and 2 to create the same VLAN:
    - Create a new VLAN with:
      - **Parent Interface:** `em3`
      - **VLAN Tag:** `99`
      - **Description:** `Management`
    - Assign the VLAN to an interface.
3. Configure the interface with a static IP:
    - **IPv4 Address:** Enter `10.0.99.3/24`.
4. Click **Save** and then **Apply Changes**.

## Create a Virtual IP (VIP) for the MGMT Interface on the Primary Firewall

1. Log into the primary pfSense.
2. Navigate to **Firewall > Virtual IPs** and click **Add**.
3. Configure the Virtual IP as follows:
    - **Type:** Select **CARP**.
    - **Interface:** Choose `VLAN_MGMT`.
    - **Address(es):** Enter `10.0.99.1/24`.
    - **Virtual IP Password:** Enter a secure password.
    - **VHID Group:** Enter `99`.
    - **Description:** Enter `Management`.
4. Click **Save** and then **Apply Changes**.
