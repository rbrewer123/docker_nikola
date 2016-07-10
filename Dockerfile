# build command:
#  docker build -t rbrewer123/nikola .

FROM nfnty/arch-mini

# add pkgbuilder repo
RUN echo '' >>/etc/pacman.conf 
RUN echo '[pkgbuilder]' >>/etc/pacman.conf 
RUN echo 'Server = https://pkgbuilder-repo.chriswarrick.com/' >>/etc/pacman.conf 

# gnupg bugfix
RUN mkdir -p /root/.gnupg && \
    touch /root/.gnupg/dirmngr_ldapservers.conf

RUN pacman-key -r 5EAAEA16 
RUN pacman-key --lsign 5EAAEA16 

RUN pacman -Syu --needed --noconfirm \
    base-devel \
    pkgbuilder
RUN pacman -S --needed --noconfirm python-pip && pip install webassets

RUN echo 'en_US.UTF-8 UTF-8' >>/etc/locale.gen
RUN echo 'en_DK.UTF-8 UTF-8' >>/etc/locale.gen
RUN locale-gen

RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user
RUN useradd -m user

USER user
WORKDIR /home/user

RUN pkgbuilder --noconfirm \
    python-pygal \
    python-pyphen \
    python-typogrify

RUN pkgbuilder --noconfirm \
    python-nikola

USER root
WORKDIR /root

RUN userdel user
RUN rm -rf /home/user

COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh

EXPOSE 8000
ENTRYPOINT ["/root/runasuser.sh"]
