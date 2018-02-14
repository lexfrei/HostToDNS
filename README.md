# HostToDNS.rsc
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Flexfrei%2FHostToDNS.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Flexfrei%2FHostToDNS?ref=badge_shield)

This script can add your local hostnames to DNS

Only read and write permissions required.

You can run it manually or add to scheduler.

To add script to scheduler:

``/system scheduler
add interval=30m name=HostToDNS on-event="/system script run HostToDNS"``

Tested on 6.5.34


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Flexfrei%2FHostToDNS.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Flexfrei%2FHostToDNS?ref=badge_large)