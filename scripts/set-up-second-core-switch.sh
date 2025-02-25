#!/bin/bash
#Exit immediately if any comand fails
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

echo "Creating a trunk port to pfsense..."
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