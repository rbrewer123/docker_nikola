# build command:
#  docker build -t rbrewer123/nikola .

FROM nfnty/arch-mini


RUN pacman -Syu --needed --noconfirm \
    base-devel \
    git pyalpm \
    python-pip \
    python-requests \
    python-srcinfo \
    python-webassets


RUN pip install -U pkgbuilder

RUN echo 'en_US.UTF-8 UTF-8' >>/etc/locale.gen
RUN echo 'en_DK.UTF-8 UTF-8' >>/etc/locale.gen
RUN locale-gen
RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user
RUN useradd -m user

USER user
WORKDIR /home/user

RUN pkgbuilder --noconfirm python-nikola

USER root
WORKDIR /root

RUN userdel user

COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh

EXPOSE 8000
ENTRYPOINT ["/root/runasuser.sh"]
