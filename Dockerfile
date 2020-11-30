FROM \
ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
  apt-get update; \
  apt-get -yq --no-install-recommends install \
    build-essential \
    ca-certificates \
    curl \
    wget \
    git \
    bash-completion \
    less \
    jq \
    mysql-client \
    tzdata \
    locales \
    dnsutils \
    net-tools \
    netcat \
    lsof \
    strace \
    procps \
    vim \
    nano \
    htop

RUN set -eux; \
  apt-get update; \
  apt-get -yq --no-install-recommends install \
    apache2 \
    libapache2-mod-rpaf \
    php7.4 \
    php7.4-bcmath \
    php7.4-bz2 \
    php7.4-intl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-zip \
    php7.4-common

COPY layer /

RUN echo 'web:x:10000:' >>/etc/group
RUN echo 'web:x:10000:10000:Web User:/home/user:/bin/bash' >>/etc/passwd


RUN set -eux; \
  a2enmod remoteip; \
  install -d /a/shared/public -o 10000 -g 10000; \
  install -d /run/apache2 -o 10000; \
  chown -R 10000 /var/log/apache2;

USER 10000
ENV APACHE_RUN_USER="web"
ENV APACHE_RUN_GROUP="web"

ENTRYPOINT [ "/entrypoint" ]
