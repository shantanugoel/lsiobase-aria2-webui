## Info

Unofficial Linuxserver.io image, use issue tracker for potentional problems.

[Aria2](https://aria2.github.io/)  is a lightweight multi-protocol & multi-source command-line download utility. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink. aria2 can be manipulated via built-in JSON-RPC and XML-RPC interfaces.

## Batteries included:
- [WebUI] (-e WEBUI=aria) https://github.com/ziahamza/webui-aria2
- [WebUI] (-e WEBUI=ariang) https://github.com/mayswind/AriaNg/

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `lukasmrtvy/lsiobase-aria2-webui` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |



## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=aria2 \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 4040:4040 \
  -v </path/to/appdata/config>:/data/config \
  -v </path/to/downloads>:/data/downloads \
  -e WEBUI=aria \
  --restart unless-stopped \
  lukasmrtvy/lsiobase-aria2-webui
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  aria2:
    image: lukasmrtvy/lsiobase-aria2-webui
    container_name: aria2
    environment:
      - PUID=1000
      - PGID=1000
      - WEBUI=aria
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/data/config
      - </path/to/downloads>:/data/downloads
    ports:
      - 4040:4040
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 4040` | http gui |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /data/config` | aria2 Application Data. |
| `-v /data/downloads` | Downloads Folder. |
| `-e CUSTOM_RPC_TOKEN` | Optional. Specify custom RPC token vaule. |
| `-e CUSTOM_OVERRIDE_OPTIONS` | Optional. Pass arguments to aria2 daemon |
| `-e SKIP_SSL=true` | Optional. Disable HTTPS |
| `-e WEBUI=aria` | Optional. Defaults to ariang |


## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Access the webui at `<your-ip>:443`and setup connection to Aria2 RPC. for more information check out [Aria2 WebUI](https://github.com/ziahamza/webui-aria2).
You can use also custom clients with same connection string.


## Support Info

* Shell access whilst the container is running: `docker exec -it aria2 /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f aria2`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' aria2`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/aria2`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull lukasmrtvy/lsiobase-aria2-webui`
* Stop the running container: `docker stop aria2`
* Delete the container: `docker rm aria2`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start aria2`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull aria2`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d aria2`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **23.02.19:** - Initial version.

# TODO
- Offpeak time: https://github.com/ziahamza/webui-aria2/issues/126
