# docker-downloader

[![Build Status](https://travis-ci.org/coaxial/docker-downloader.svg?branch=master)](https://travis-ci.org/coaxial/docker-downloader)

## What is it?
A collection of docker containers interfaced together to provide a media
downloading service for tv shows and movies over usenet and bittorrent.

## How to use it?
`docker-compose up` (hopefully).

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
