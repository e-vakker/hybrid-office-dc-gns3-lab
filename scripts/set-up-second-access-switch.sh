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

echo "Creating a trunk port to Core Switch 1 and 2..."
ovs-vsctl add-port br0 eth0 trunk=9,99
ovs-vsctl add-port br0 eth1 trunk=9,99

echo "Creating ports for end-devives"
ovs-vsctl add-port br0 eth2 tag=9
ovs-vsctl add-port br0 eth3 tag=9
ovs-vsctl add-port br0 eth4 tag=9
ovs-vsctl add-port br0 eth5 tag=99

echo "set a higher path cost on the link to CoreSW2"
ovs-vsctl set port eth1 other-config:stp-path-cost=20000

echo "Displaying final configuration..."
ovs-vsctl show
ovs-appctl stp/show br0