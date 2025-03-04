# Virtual Office & Infrastructure Lab

I have created a GNS3 lab to develop and enhance my system administration skills. My approach is to start with a foundational setup and gradually integrate more advanced technologies.

Initially, I aim to create a small office with reliable core infrastructure and minimal appliances, focusing on essential networking and system administration concepts. I plan to expand it by imitating a data center site and adding a small branch office. 

My target is to complete **70%** of defined objectives.

## Current Topology

![Topology](images/topology.png)

## Objectives

| **#** | **Topic**                                                                                  | Objectives                                                                                                                                                                                                                                                         | **Status** |
| ----- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------- |
| 1     | [Deploy Virtual Lab Environment on Cloud](01_deploy_virtual_lab_environment.md)            | - Deploy a Cloud VM with GNS3.<br>- Enable nested virtualisation for running virtual appliances.<br>- Install essential dependencies for GNS3, including QEMU and Docker.                                                                                          | Completed  |
| 2     | [Deploy GNS3 Appliances for Network Simulation](02_deploy_gns3_appliances.md)              | - Deploy Network Appliances Open vSwitch, pfSense, and WebTerm<br>- Configure Windows VM templates for Windows 10 and Windows Server 2022.<br>- Optimise Windows VMs with Guest Tools.                                                                             | Completed  |
| 3     | [Install & Configure pfSense Firewall](03_install_configure_pfsense.md)                    | - Add pfSense and Cloud NAT to the GNS3 canvas.                                                                                                                                                                                                                    | Completed  |
| 4     | [Setup pfSense HA & VLAN Trunking](04_setup_pfsense_vlan_trunking.md)                      | - Assign IP to LAN interface.<br>- Configure Web-Term access.<br>- Configure SYNC port.<br>- Set up High Availability.<br>- Create CARP VIP on LAN (10.0.5.1).<br>- Create trunk parent interface.<br>- Create VLAN interfaces.<br>- Create CARP VIP for each VLAN | Completed  |
| 5     | [Setup Management VLAN (MGMT_VLAN)](05_setup_mgmt_vlan.md)                                 | - Create a new VLAN (VLAN 99).<br>- Create a CARP VIP on VLAN_MGMT.                                                                                                                                                                                                | Completed  |
| 6     | [Deploy Permissive Firewall Rules](06_deploy_permissive-firewall_rules.md)                 | - Create an Interface Group.<br>- Add a Firewall Rule                                                                                                                                                                                                              | Completed  |
| 7     | [Deploy & Configure Core and Access Switches](07_deploy_configure_core_access_switches.md) | - Deploy Core and Access Switches.<br>- Enable STP for Redundancy.<br>- Configure VLAN Trunks and Access Ports.<br>- Interconnect Switches.<br>- Configure Web-term Static IP.<br>- Disable MGMT Interface of pfSense                                              | Completed  |
| 8     | [Deploy & Configure Domain Controller (DC-01)](08_deploy_configure_dc01.md)                | - Rename the Server.<br>- Install Active Directory Domain Services (AD DS).<br>- Promote to Domain Controller.                                                                                                                                                     | Completed  |
| 9     | [Configure DHCP Server & Relay](09_configure_dhcp.md)                                      | - Install the DHCP Server.<br>- Create DHCP Scopes.<br>- Configure DHCP Relay on pfSense                                                                                                                                                                           | Completed  |
| 10    | [Configure DNS Forwarding on DC-01](10_configure_dns_forwarding_dc01.md)                   | - Configure Forwarders in Windows DNS.<br>- Update DNS Settings on DC01.                                                                                                                                                                                           | Completed  |
| 11    | [Configure Organisational Units (OUs)](11_configure_ous.md)                                | - Create OUs                                                                                                                                                                                                                                                       | Completed  |
| 12    | [Join Computers & Create User Accounts in Domain](12_join_pcs_create_users_in_domain.md)   | - Deploy Windows 10 Appliances.<br>- Create Users.<br>- Join PCs to the Domain.                                                                                                                                                                                    | Completed  |
| 13    | [Configure Active Directory Security Groups](13_configure_ad_security_groups.md)           | - Create Security Groups.<br>- Add Users to Groups.                                                                                                                                                                                                                | Completed  |
| 14    | [Configure Basic Group Policy Objects (GPOs)](14_configure_basic_gpos.md)                  | - Password & Lockout Policies.<br>- Optimisation VM.                                                                                                                                                                                                               | Completed  |
| 15    | Create Lightweight Windows Server Appliance                                                |                                                                                                                                                                                                                                                                    | Planned    |
| 16    | Deploy File Server (FS01)                                                                  |                                                                                                                                                                                                                                                                    | Planned    |
| 17    | Deploy Backup Server (BKUP01)                                                              |                                                                                                                                                                                                                                                                    | Planned    |
| 18    | Migrate VLAN Configuration to Core Switches                                                |                                                                                                                                                                                                                                                                    | Planned    |
| 19    | Establish Firewall-to-Switch Mesh Topology for Redundancy                                  |                                                                                                                                                                                                                                                                    | Planned    |
| 20    | Configure ACLs on Core Switches                                                            |                                                                                                                                                                                                                                                                    | Planned    |
| 21    | Implement Restrictive Firewall Rules for Edge & CARP                                       |                                                                                                                                                                                                                                                                    | Planned    |
| 22    | Configure WAN Interface with CARP                                                          |                                                                                                                                                                                                                                                                    | Planned    |
| 23    | Deploy Role-Based Access Control (RBAC)                                                    |                                                                                                                                                                                                                                                                    | Planned    |
| 24    | Deploy a Logging Server (LOG-SRV01)                                                        |                                                                                                                                                                                                                                                                    | Planned    |
| 25    | Configure RAID Storage                                                                     |                                                                                                                                                                                                                                                                    | Planned    |
| 26    | Deploy RADIUS Server (NPS01)                                                               |                                                                                                                                                                                                                                                                    | Planned    |
| 27    | Deploy Web Server in DMZ (WEB01)                                                           |                                                                                                                                                                                                                                                                    | Planned    |
| 28    | Deploy a Data Center with All Servers                                                      |                                                                                                                                                                                                                                                                    | Planned    |
| 29    | Establish a Site-to-Site VPN                                                               |                                                                                                                                                                                                                                                                    | Planned    |
| 30    | Configure Replication to a Data Center                                                     |                                                                                                                                                                                                                                                                    | Planned    |
| 31    | Deploy Monitoring Tool                                                                     |                                                                                                                                                                                                                                                                    | Planned    |
| 32    | Configure GPOs for Software Deployment & Drive Mapping                                     |                                                                                                                                                                                                                                                                    | Planned    |
| 33    | Deploy & Configure IDS/IPS                                                                 |                                                                                                                                                                                                                                                                    | Planned    |
| 34    | Deploy & Configure SIEM                                                                    |                                                                                                                                                                                                                                                                    | Planned    |
| 35    | Deploy Small Office Branch                                                                 |                                                                                                                                                                                                                                                                    | Planned    |

## Failover tests

| **#** | **Topic**                                | Objectives                                           | Status  |
| ----- | ---------------------------------------- | ---------------------------------------------------- | ------- |
| 1     | Primary Firewall and Core Switch Failure | - Simulate a Failure.<br>- Validate HA Functionality | Planned |

## Repository Structure
``` plain
hybrid-office-dc-gns3-lab/
├── docs/
│   ├── new-users.csv
│   └── topology.png
├── images/
├── scripts/
│   ├── configure-dhcp-scopes-dc-01.ps1
│   ├── create-groups.ps1
│   ├── new-users-import.ps1
│   ├── set-up-first-access-switch.sh
│   ├── set-up-second-access-switch.sh
│   ├── set-up-second-core-switch.sh
│   └── set-up-third-access-switch.sh
├── 01_deploy_virtual_lab_environment.md
├── 02_deploy_gns3_appliances.md
├── 03_install_configure_pfsense.md
├── 04_setup_pfsense_vlan_trunking.md
├── 05_setup_mgmt_vlan.md
├── 06_deploy_permissive-firewall_rules.md
├── 07_deploy_configur_access_switches.md
├── 08_deploy_configure_dc01.md
├── 09_configure_dhcp.md
├── 10_configure_dns_forwarding_dc01.md
├── 11_configure_ou.md
├── 12_join_pcs_create_sers_in_domain.md
├── 13_configure_ad_security_groups.md
├── 14_configure_basic_gpos.md
├── LICENSE
└── README.md
```

## Resources & References

- GNS3 Official Documentation: https://docs.gns3.com/
- Microsoft Learn (Active Directory & Windows Server): https://learn.microsoft.com/en-us/windows-server/
- pfSense Documentation: https://docs.netgate.com/pfsense/en/latest/
- Open vSwitch Documentation: https://docs.openvswitch.org/

## Contact

For inquiries, questions, or suggestions, please reach out directly at

[jevgeni@vakker.pro](mailto:jevgeni@vakker.pro)

## License

[MIT License](LICENSE)
