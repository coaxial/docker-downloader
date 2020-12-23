# docker-downloader

[![Build Status](https://travis-ci.org/coaxial/docker-downloader.svg?branch=master)](https://travis-ci.org/coaxial/docker-downloader)

## What is it?
A collection of docker containers interfaced together to provide a media
downloading service for tv shows and movies over usenet and bittorrent.

## How to use it?

1. Copy the `.env.example` file to `.env` and edit values as needed.
2. Run `docker-compose up`.

Then visit the following URIs:

URI | Service
--- | ---
`/series` | [Sonarr](https://sonarr.tv/)
`/movies` | [Radarr](https://radarr.video/)
`/torrent` | [Transmission](https://transmissionbt.com/)
`/nzb` | [NZBGet](https://nzbget.net/)
`/aggregator/torrent` | [Jackett](https://github.com/Jackett/Jackett)
`/aggregator/nzb` | [nzbHydra](https://github.com/theotherp/nzbhydra)

Backups are with [tarsnap](https://www.tarsnap.com/), subtitles with [Subliminal](https://subliminal.readthedocs.io/en/latest/)

## Notes
- This is a work in progress
- Docker changes very fast, I might be doing bad things unknowingly
- This makes some assumptions regarding the mount points (`/srv/{tv_shows,movies,downloads}` must exist)
- the volumes in `/srv` can be aliases to locations on a separate drive

## Updating versions
Optional if using `latest`: bump the tag for the relevant docker image (either in `.env` or in the `Dockerfiles` for the services that are built). Do not use the apps' built-in update mechanism.

Backup volumes: `sudo docker run --rm --volumes-from dockerdownloader_torrent_1 -v <PWD>/backups:/backup ubuntu bash`

Remove existing containers `sudo docker-compose down`

Create new containers `sudo docker-compose up -d`
