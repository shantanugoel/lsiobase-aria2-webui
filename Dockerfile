FROM lsiobase/nginx:3.12

ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="shantanugoel"

ARG ARIA2WEBUI_1_VERSION
ARG ARIA2WEBUI_2_VERSION
ARG ARIA2_VERSION

ENV ARIA2WEBUI_1_VERSION master
ENV ARIA2WEBUI_2_VERSION 1.1.6
ENV ARIA2_VERSION 1.35.0-r1

RUN \
    set -xe && \
    apk add --no-cache unzip tar curl openssl aria2 && \
    mkdir -p /data/aria2-webui-1 /tmp/aria2-webui-1 /data/aria2-webui-2 /tmp/aria2-webui-2 /data/config && \
    curl -sSL https://github.com/ziahamza/webui-aria2/archive/${ARIA2WEBUI_1_VERSION}.tar.gz | tar xz -C /tmp/aria2-webui-1 --strip-components=1 && \
    cp -R /tmp/aria2-webui-1/docs/* /data/aria2-webui-1 && \
    curl -sSL https://github.com/mayswind/AriaNg/releases/download/${ARIA2WEBUI_2_VERSION}/AriaNg-${ARIA2WEBUI_2_VERSION}.zip -o /tmp/AriaNg-${ARIA2WEBUI_2_VERSION}.zip && \
    unzip /tmp/AriaNg-${ARIA2WEBUI_2_VERSION}.zip -d /data/aria2-webui-2 && \
    apk del unzip tar curl && \
    rm -rf /tmp/*

COPY root/ /

EXPOSE 4040

VOLUME ["/data/downloads/"]
