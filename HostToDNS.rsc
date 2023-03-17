# Get domain name from DHCP server's DNS settings
:local topdomain [:put [/ip dhcp-server network get [find] domain]]

# Use ttl to distinguish dynamic added DNS records
:local ttl "00:29:59"

# Remove all dynamic records
/ip dns static remove [/ip dns static find ttl=$ttl]

# Add DNS entries for active DHCP leases
/ip dhcp-server lease
:foreach lease in=[find where active-address] do={
  :local hostname [get $lease host-name]
  :if ([:len $hostname] > 0) do={
    :set hostname ($hostname . "." . $topdomain)
    :local hostip [get $lease address]
    /ip dns static
    :if ([find name=$hostname]) do={
      :put ("Not adding already existing entry: " . $hostname)
    } else={
      :put ("Adding: " . $hostname . " : " . $hostip)
      /ip dns static add name=$hostname address=$hostip ttl=$ttl
    }
  } else={
    :put "Hostname is empty for lease with IP address [get $lease address]"
  }
}
