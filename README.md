# docker-downloader

## What is it?
A collection of docker containers interfaced together to provide a media
downloading service for tv shows and movies over usenet and bittorrent.

It probably can't be used as is because there are some things specific to my
environment, but hopefully this is useful for inspiration. It shouldn't take a
*lot* of changes to make it work in your environment though, there are only
three volumes mapped to arbitrary locations, and you can remove the IP
altogether when binding the ports.

## How to use it?
Go through the `docker-compose.yml` file and adapt it to your env. Notably the
`downloads`, `series`, and `movies` volumes can be made "regular" volumes if
you don't need them on another drive.

You can probably get away with regular ports binding, i.e. `"80:80"` instead of
`"<ip>:80:80"`.

Finally, I am using the `nobody` user (uid 65534) and `nogroup` group (gid
65534) so it plays nicely with the permissions on my server. This is not
stricly necessary depending on your env, the default values are UID 911 GID 911
(cf. https://hub.docker.com/r/linuxserver/ for each image.)

Then a simple `docker-compose up` should get you going.

I have also made public the Ansible playbook I'm using if that's your thing,
cf. [here](https://github.com/coaxial/ansible-playbooks/downloader).

Then visit the following URIs:

URI | Service
--- | ---
`/series` | [Sonarr](https://sonarr.tv/)
`/movies` | [Radarr](https://radarr.video/)
`/torrent` | [Transmission](https://transmissionbt.com/)
`/nzb` | [NZBGet](https://nzbget.net/)
`/aggregator/torrent` | [Jackett](https://github.com/Jackett/Jackett)

## Notes
- This is a work in progress
- Docker has changed a lot since I last used it, so I might be doing some very
  bad things unknowingly
- This makes some assumptions regarding the mount points
  (`/srv/{tv_shows,movies,downloads}` must exist)
- the volumes in `/srv` can be aliases to locations on a separate drive

## Updating versions
Bump the tag for the relevant docker image (either in `docker-compose.yml` or
in the `Dockerfiles` for the services that are built). Do not use the apps'
built-in update mechanism.
