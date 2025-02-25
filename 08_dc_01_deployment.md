# DC-01 deployment

## Assign a Static IP Address
### GUI 

1. Open network connections:
	- In the search bar, type `ncpa.cpl`, and press **Enter**.
2. Configure the Ethernet Adapter:
    - Right-click on the **Ethernet** adapter and select **Properties**.
    - Select **Internet Protocol Version 4 (TCP/IPv4)**, then click **Properties**.
    - Choose **Use the following IP address** and enter the following:
        - **IP address:** `10.0.9.4`
        - **Subnet mask:** `255.255.255.0`
        - **Default gateway:** `10.0.9.1`
        - **Preferred DNS server:** `127.0.0.1` (This will be configured to the server IP later)
    - Click **OK** on all windows.
3. Verify the Static IP: 
	- Open **Command Prompt**. 
	- Run `ipconfig` to confirm that the new static IP has been applied.

### Command Line Method

1. **Open PowerShell** with Administrative privileges.
2. Identify the Network Adapter:
   ```powershell
   Get-NetAdapter
   ```
3. Configure the Static IP:
   ```powershell
   New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.0.9.4 -PrefixLength 24 -DefaultGateway 10.0.9.1
   ```
4. Set the DNS Server to Loopback:
   ```powershell
   Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1
   ```
5. Verify Configuration:
   ```powershell
   Get-NetIPConfiguration
   ```

## Rename the server

### GUI Method

1. Open System Settings: 
	- In the search bar, type `sysdm.cpl`, and press **Enter**.
2. Access the Computer Name Settings:
   - Under the **Computer Name** tab, click **Change…**.
3. Change the Computer Name: 
   - In the **Computer name** field, enter `DC01`.
   - Click **OK** and then **Apply**.
4. Restart the Server: 
	- When prompted. Click **OK** and **Restart Now** to apply the changes.
5. Verify the New Name:
	- After reboot, type `Computer name` in the search bar to confirm the new hostname.

### Command Line Method

1. **Open PowerShell** as Administrator.
2. Rename and Restart:
   ```powershell
   Rename-Computer -NewName "DC01" -Force -Restart
   ```
3. Verify:
   - Open **PowerShell** again and run:
     ```powershell
     hostname
     ```
   - Confirm the name is now `DC01`.

## Install Active Directory Domain Services

1. Open Server Manager.
2. Add Roles and Features:
    * Click **Add roles and features**.
    * Click **Next** on the **Before You Begin** page.
    * Select **Role-based or feature-based installation**, then click **Next**.
    * Choose **Select a server from the server pool** and select the local server **DC01**, then click **Next**.
    * Select **Active Directory Domain Services**.
    * When prompted, click **Add Features**.
    * Continue clicking **Next** until you reach the **Confirmation** page.
    * Click **Install**.
3. Wait for Installation:
	- Once the installation is complete, click **Close**.

## Promote the Server to a Domain Controller

1. Open Server Manager.
2. Promote to Domain Controller:
    - Click the exclamation mark (!) in the **Notifications** area, then click **Promote this server to a domain controller**.
    - Select **Add a new forest**.
    - In the **Root domain name** field, enter `lab-test.local`.
    - Click **Next**.  
    - **Set Directory Services Restore Mode (DSRM) Password:**
    - Enter a password for the DSRM password:
		* Enter a secure password (e.g., `SecureLab!789`).
    - Continue clicking **Next** through the wizard.
    - When the **Prerequisites Check** completes successfully, click **Install**.
3. Domain Controller Promotion: 
	- The server will automatically reboot during the promotion process. Once it finishes, the server will be a domain controller for the new `lab-test.local` domain.

## Resources & References

- Microsoft Learn (Active Directory & Windows Server): https://learn.microsoft.com/en-us/windows-server/