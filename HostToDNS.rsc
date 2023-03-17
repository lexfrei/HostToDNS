# Domain to be added to your DHCP-clients hostname
:local topdomain;
:set topdomain "local";

# Use ttl to distinguish dynamic added DNS records
:local ttl;
:set ttl "00:29:59";

# Set variables to use
:local hostname;
:local hostip;
:local free;

# Remove all dynamic records
/ip dns static;
:foreach a in=[find] do={
  :if ([get $a ttl] = $ttl) do={
    :put ("Removing: " . [get $a name] . " : " . [get $a address]);
    remove $a;
  }
}

/ip dhcp-server lease ;
:foreach i in=[find] do={
  :if ([get $i active-address] != "") do={
    /ip dhcp-server lease ;
    :if ([:len [get $i host-name]] > 0) do={
      :set free "true";
      :set hostname ([get $i host-name] . "." . $topdomain);
      :set hostip [get $i address];
      /ip dns static ;
      # Check if entry already exist
      :foreach di in [find] do={
        :if ([get $di name] = $hostname) do={
          :set free "false";
          :put ("Not adding already existing entry: " . $hostname);
        }
      }
      :if ($free = true) do={
        :put ("Adding: " . $hostname . " : " . $hostip ) ;
        /ip dns static add name=$hostname address=$hostip ttl=$ttl;
      }
    }
  }
}
