FROM alpine:3.6@sha256:1072e499f3f655a032e88542330cf75b02e7bdf673278f701d7ba61629ee3ebe

RUN echo 'syncthing:x:1000:1000::/var/syncthing:/sbin/nologin' >> /etc/passwd \
    && echo 'syncthing:!::0:::::' >> /etc/shadow \
    && mkdir /var/syncthing \
    && chown syncthing /var/syncthing

RUN apk add --no-cache curl jq gnupg \
    && gpg --keyserver keyserver.ubuntu.com --recv-key D26E6ED000654A3E

ENV release="v0.14.40"

RUN set -x \
    && mkdir /syncthing \
    && cd /syncthing \
    && release=${release:-$(curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | jq -r .tag_name )} \
    && curl -sLO https://github.com/syncthing/syncthing/releases/download/${release}/syncthing-linux-amd64-${release}.tar.gz \
    && curl -sLO https://github.com/syncthing/syncthing/releases/download/${release}/sha256sum.txt.asc \
    && gpg --verify sha256sum.txt.asc \
    && grep syncthing-linux-amd64 sha256sum.txt.asc | sha256sum \
    && tar -zxf syncthing-linux-amd64-${release}.tar.gz \
    && mv syncthing-linux-amd64-${release}/syncthing . \
    && rm -rf syncthing-linux-amd64-${release} sha256sum.txt.asc syncthing-linux-amd64-${release}.tar.gz \
    && apk del gnupg jq curl

USER syncthing
ENV STNOUPGRADE=1
ENTRYPOINT ["/syncthing/syncthing", "-home", "/var/syncthing/config", "-gui-address", "0.0.0.0:8384"]
