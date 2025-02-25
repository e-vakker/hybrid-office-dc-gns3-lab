# DNS Forwarding Setup (DC01)

The primary purpose is to get access to the internet from end devices by forwarding external queries to Google DNS.

## Configure Forwarding in Windows DNS

1. Log in to `DC01`.
2. Open DNS Manager:  
   - In the search bar, type `dnsmgmt.msc`, and press **Enter**.
3. Right-click the **server name** `DC01` > **Properties**.
4. Configure Forwarders:  
   - Navigate to the **Forwarders** tab.
   - Click **Edit**.
   - Add the following external DNS servers:
     - `8.8.8.8`
     - `8.8.4.4`
   - Click **OK** and then **Apply**.

## Configure DNS Settings in DC01

1. Open Network Connections:  
   - In the search bar, type `ncpa.cpl`, and press **Enter**.
2. Modify Adapter Settings:  
   - Right-click the network adapter and select **Properties**.
   - Select **Internet Protocol Version 4 (TCP/IPv4)**, then click **Properties**.
3. Update DNS Server:  
   - Change the **Preferred DNS server** to `10.0.9.4`.
   - Click **OK** and then **Close**.

## Verification

4. Renew IP Configuration on a Client:  
   - Connect to the Windows 10 appliance on **Access-Switch-1**.
   - Open a terminal and run the following commands:
     ```cmd
     ipconfig /release
     ipconfig /renew
     ```
   - Confirm the changes with the provided screenshot:
     ![[images/10/ipconfig-renew.png]]
5. Verify DNS Resolution:  
   - In the terminal, execute:
     ```cmd
     nslookup google.com
     ```
   - Verify the output with the screenshot:
     ![[images/10/nslookup.png]]
