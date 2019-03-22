# docker-aria2-webui

# Info
```
docker run -d --name=aria2 --restart=always -v </foo/bar/path>:/data/downloads -e PUID=<UID> -e PGID=<GID>  -p 443:443 aria:latest
```

# Optional variables
- CUSTOM_RPC_TOKEN
- CUSTOM_OVERRIDE_OPTIONS

# TODO
- Offpeak time: https://github.com/ziahamza/webui-aria2/issues/126
