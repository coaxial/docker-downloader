# docker-downloader

## What is it?
A collection of docker containers interfaced together to provide a media
downloading service for tv shows and movies over usenet and bittorrent.

## How to use it?
`docker-compose up` (hopefully).

## Notes
- This is a work in progress
- Docker has changed a lot since I last used it, so I might be doing some very
  bad things unknowingly
- This makes some assumptions regarding the mount points
  (`/srv/{tv_shows,movies,downloads}` must exist)
- the volumes in `/srv` can be aliases to locations on a separate drive
