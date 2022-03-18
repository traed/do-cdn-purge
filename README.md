A docker image that purges Digitalocean Spaces CDN cache. Made to be used in a Drone.io pipeline.

## Usage:
`$ docker run --rm -e PLUGIN_TOKEN=<PERSONAL ACCESS TOKEN> -e PLUGIN_ORIGIN=<SPACES ORIGIN> -e PLUGIN_PATTERN="<FILE PATTERN>" traed/do-cdn-purge`

`PUGIN_TOKEN` is a personal access token that can be retrieved from your Digitalocean account.
`PLUGIN_ORIGIN` is the origin of the space your wish to purge files from. Ex. `my-do-space.fra1.digitaloceanspaces.com`.
`PLUGIN_PATTERN` is a glob pattern to match the files you want to purge. * can be used to match all files in the space.

All environment variables are required.