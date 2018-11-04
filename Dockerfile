FROM lsiobase/alpine.nginx:3.8

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="<your github username here>"

ARG ARIA2WEBUI_VERSION 
ARG ARIA2_VERSION 

ENV ARIA2WEBUI_VERSION 77636e25af04a965435519903ae09819ab727586
ENV ARIA2_VERSION 1.34.0-r0

ENV S6_KEEP_ENV 1

RUN \
    apk add --no-cache tar curl openssl aria2=${ARIA2_VERSION} && \
    mkdir -p /data/aria2c-webui /data/config && \
    curl -sSL https://github.com/ziahamza/webui-aria2/archive/${ARIA2WEBUI_VERSION}.tar.gz | tar xz -C /data/aria2c-webui --strip-components=1 && \
    apk del tar curl 

COPY root/ /

EXPOSE 8080 6800

VOLUME ["/data/config/","/data/downloads/"]
