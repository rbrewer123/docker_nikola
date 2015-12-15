FROM debian:stable 
MAINTAINER Don M <https://github.com/dmmmdfll/docker_nikola> 

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get update -qq && apt-get install -y \
locales -qq

RUN echo 'en_US.UTF-8 UTF-8' >>/etc/locale.gen && \
    echo 'en_DK.UTF-8 UTF-8' >>/etc/locale.gen && \
    locale-gen && \
    dpkg-reconfigure locales

RUN apt-get update && apt-get install -y \
    -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
build-essential \
python3-dev \
python3-pip \
python3-wheel \
libffi-dev \
libssl-dev \
libgtk2.0-0 \
libSM6 \
libxt6 \
libgpm2 \
libxml2-dev \
libxslt1-dev \
libjpeg62-turbo-dev \
libfreetype6 \
libfreetype6-dev

RUN pip3 install virtualenv
RUN \
    ["/bin/bash", \
     "-c", \
     "virtualenv -p /usr/bin/python3 nikola-virtualenv && \
      source /nikola-virtualenv/bin/activate && \
      pip3 install --upgrade Nikola[extras]"]
RUN export PATH=$PATH:/nikola-virtualenv/bin

COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh

EXPOSE 8000
ENTRYPOINT ["/root/runasuser.sh"]
