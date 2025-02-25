# Set Up Permissive Firewall Rules

We will create permissive firewall rules for testing purposes. These rules allow all traffic through the `VLAN_GROUP`, and we gradually harden them as later.

## Create an Interface Group

To simplify management, first create an interface group that includes all relevant VLAN interfaces.

### On the Primary Firewall (10.0.5.2):

1. Navigate to **Interfaces > Assignments > Interface Groups**.
2. Click **Add**.
3. In the **Group Name** field, enter `VLAN_GROUP`.
4. For **Group Members**, select the following interfaces:  
   - `VLAN_INFRA`
   - `VLAN_IT`
   - `VLAN_SALS`
   - `VLAN_FIN`
   - `VLAN_HR`
   - `VLAN_MGMT`
5. Click **Save**.

Repeat the same steps on the secondary firewall.

## Create a Firewall Rule

Configure a rule to allow all traffic on the created interface group.

### On Both Firewalls:

1. Navigate to **Firewall > Rules** and select the `VLAN_GROUP` interface.
2. Click **Add**.
3. Configure the rule with these settings:
   - **Protocol:** Any
   - **Source:** Any
   - **Destination:** Any
4. Click **Save**.