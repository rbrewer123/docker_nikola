FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'en_US.UTF-8 UTF-8' >>/etc/locale.gen
RUN echo 'en_DK.UTF-8 UTF-8' >>/etc/locale.gen
RUN locale-gen

USER root

RUN apt-get update && apt-get install -y \
    -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
build-essential \
python3-dev \
python-virtualenv \
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
libjpeg8 \
libjpeg62-dev \
libfreetype6 \
libfreetype6-dev

RUN \
    ["/bin/bash", "-c", "virtualenv -p /usr/bin/python3 nikola-virtualenv && source /nikola-virtualenv/bin/activate && pip3 install --upgrade Nikola[extras]"]
COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh

EXPOSE 8000
ENTRYPOINT ["/root/runasuser.sh"]
