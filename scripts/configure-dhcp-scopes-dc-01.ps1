# Add DHCP Scopes
Add-DhcpServerv4Scope -Name "IT Scope" -StartRange 10.0.10.100 -EndRange 10.0.10.200 -SubnetMask 255.255.255.0
Add-DhcpServerv4Scope -Name "SALS Scope" -StartRange 10.0.20.100 -EndRange 10.0.20.200 -SubnetMask 255.255.255.0
Add-DhcpServerv4Scope -Name "FIN Scope" -StartRange 10.0.30.100 -EndRange 10.0.30.200 -SubnetMask 255.255.255.0
Add-DhcpServerv4Scope -Name "HR Scope" -StartRange 10.0.40.100 -EndRange 10.0.40.200 -SubnetMask 255.255.255.0

# Set Default Gateway (Option 003 Default Gateway) for Each Scope
Set-DhcpServerv4OptionValue -ScopeId 10.0.10.0 -OptionId 3 -Value 10.0.10.1
Set-DhcpServerv4OptionValue -ScopeId 10.0.20.0 -OptionId 3 -Value 10.0.20.1
Set-DhcpServerv4OptionValue -ScopeId 10.0.30.0 -OptionId 3 -Value 10.0.30.1
Set-DhcpServerv4OptionValue -ScopeId 10.0.40.0 -OptionId 3 -Value 10.0.40.1

# Set DNS Server (Option 006 DNS Server) for Each Scope
Set-DhcpServerv4OptionValue -ScopeId 10.0.10.0 -OptionId 6 -Value 10.0.9.4
Set-DhcpServerv4OptionValue -ScopeId 10.0.20.0 -OptionId 6 -Value 10.0.9.4
Set-DhcpServerv4OptionValue -ScopeId 10.0.30.0 -OptionId 6 -Value 10.0.9.4
Set-DhcpServerv4OptionValue -ScopeId 10.0.40.0 -OptionId 6 -Value 10.0.9.4

# Set DNS Domain Name (Option 015 DNS Domain name) for Each Scope
Set-DhcpServerv4OptionValue -ScopeId 10.0.10.0 -OptionId 15 -Value "lab-test.local"
Set-DhcpServerv4OptionValue -ScopeId 10.0.20.0 -OptionId 15 -Value "lab-test.local"
Set-DhcpServerv4OptionValue -ScopeId 10.0.30.0 -OptionId 15 -Value "lab-test.local"
Set-DhcpServerv4OptionValue -ScopeId 10.0.40.0 -OptionId 15 -Value "lab-test.local"