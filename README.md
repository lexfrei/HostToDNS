# DHCP Server DNS Settings to Domain Name Conversion Script

This script is designed to run on a MikroTik RouterOS device and automatically add DNS entries for all active DHCP leases.

## How it works

1. The script first gets the top-level domain name from the DHCP server's network settings.

2. It then sets a time-to-live (TTL) value for the DNS records to distinguish them from other static DNS entries.

3. Any existing dynamic DNS entries with the same TTL value are removed.

4. The script loops through all active DHCP leases and gets the hostname and IP address for each.

5. If a hostname exists for the lease, it is concatenated with the top-level domain name obtained earlier.

6. The script checks if the DNS entry already exists and, if not, adds the new DNS entry with the hostname and IP address.

7. If the hostname is empty for a lease, a message is displayed indicating that the hostname is empty.

## How to use

1. Add the script to your scripts in System -> Scripts

2. ``/system scheduler
add interval=30m name=HostToDNS on-event="/system script run HostToDNS"``

The script will automatically add DNS entries for all active DHCP leases on the network.
