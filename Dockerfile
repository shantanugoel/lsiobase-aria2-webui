FROM alpine:3.8

ARG ARIA2WEBUI_VERSION 
ARG ARIA2_VERSION 

ENV ARIA2WEBUI_VERSION 77636e25af04a965435519903ae09819ab727586
ENV ARIA2_VERSION 1.34.0-r0

ENV UID 1000
ENV GID 1000

ENV USER abc
ENV GROUP abc


COPY scripts/entrypoint.sh /
COPY conf/supervisord.conf /

RUN addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP}  && \
    apk add --no-cache bash tar curl darkhttpd openssl supervisor aria2=${ARIA2_VERSION} && \
    mkdir -p /data/aria2c-webui /data/config && \
    curl -sSL https://github.com/ziahamza/webui-aria2/archive/${ARIA2WEBUI_VERSION}.tar.gz | tar xz -C /data/aria2c-webui --strip-components=1 && \
    chown -R ${USER}:${GROUP} /data/aria2c-webui  && \
    apk del tar curl && \
    chmod +x entrypoint.sh && \
    touch /data/config/custom.conf

EXPOSE 8080 6800

USER ${USER}

VOLUME ["/data/config/","/data/downloads/"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c /supervisord.conf"]
