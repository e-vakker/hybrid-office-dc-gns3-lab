# Hybrid Office Data Center GNS3 Lab

I have created a GNS3 lab to develop and enhance my system administration skills. My approach is to start with a foundational setup and gradually integrate more advanced technologies.

Initially, I aim to create a small office with reliable core infrastructure and minimal appliances, focusing on essential networking and system administration concepts. I plan to expand it by imitating a data center site and adding a small branch office. 

## Current Topology

![Topology](images/topology.png)

## Objectives

| **#** | **Topic**                                                                         | Objectives                                                                                                                                                                             | **Status** |
| ----- | --------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| 1     | [Deploy a Virtualised Lab Environment on Cloud](docs/01_environment_setup.md)     | - Deploy a Cloud VM with GNS3.<br>- Enable nested virtualisation for running virtual appliances.<br>- Install essential dependencies for GNS3, including QEMU and Docker.              | Completed  |
| 2     | [Configure GNS3 and appliances for network simulation](docs/02_configure_gns3.md) | - Deploy Network Appliances Open vSwitch, pfSense, and WebTerm<br>- Configure Windows VM templates for Windows 10 and Windows Server 2022.<br>- Optimise Windows VMs with Guest Tools. | Completed  |
| 3     | [Install and Configure pfSense Firewall](docs/03_install_pfsense)                 | - Add pfSense and Cloud NAT to the GNS3 canvas.                                                                                                                                        | Completed  |

## Resources & References

* GNS3 Official Documentation: https://docs.gns3.com/
* Microsoft Learn (Active Directory & Windows Server): https://learn.microsoft.com/en-us/
* pfSense Documentation: https://docs.netgate.com/pfsense/en/latest/
* Open vSwitch Documentation: https://docs.openvswitch.org/

## License

[MIT License](LICENSE)
