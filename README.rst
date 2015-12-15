##############################
Nikola Appliance
##############################

Purpose
###########

This ``Dockerfile`` creates a sandboxed, runnable `Nikola <https://getnikola.com>`_ environment based on the debian:stable image, Python developer packages, and the latest Nikola package installed.

The decision to use debian:stable was influenced by::

> Whenever possible, use current Official Repositories as the basis for your image.We recommend the Debian image since it’s very tightly controlled and kept extremely minimal (currently under 100 mb), while still being a full distribution. <https://docs.docker.com/engine/articles/dockerfile_best-practices/>

This image works in docker even if your host system is not running Debian.

Pull this image from `Docker Hub <https://hub.docker.com/r/dmmmdfll/nikola/>` with the command ``docker pull dmmmdfll/nikola``.

Requirements
################

This is tested with the following software:

* Nikola 7.7.3
* Docker version 1.8.3, build f4bf5c7

Since its main dependency is Docker, it should run on any platform with
Docker installed (e.g. Windows, OS X).  It may or may not work with earlier
versions of docker.  To install docker on your system, see the official
`docker installation instructions <https://docs.docker.com/installation>`_.


Installation
##############

To pull the docker image. (This is much faster than building your own. lxml takes at least drinking a cup of coffee's time to build on my machine.)::

  $ docker pull dmmmdfll/nikola

Alternatively to pulling the docker image build the docker image with::

  $ docker build -t dmmmdfll/nikola github.com/dmmmdfll/docker_nikola

You can see your new image that you either pulled or built with this command::

  $ docker images

Grab the ``go`` script from github like this::

  $ git clone https://github.com/dmmmdfll/docker_nikola

Now update the ``docker_nikola/nikola`` script to use your correct
``username``, ``uid``, ``group``, and ``gid``.  This avoids problems with
files being owned by root or other permissions problems that often occur
when using docker in this manner.


Run
#######

To run ``nikola`` from within the container, simply run the ``nikola`` script::

  $ docker_nikola/nikola help


Limitations 
#############

**I have not tried a deploy. I am leaving the following limitation from the forked repo at https://github.com/rbrewer123/docker_nikola because it seems likely that the same would be true for this image**

The only limitation I know of so far is using Nikola`s ``deploy`` command.
I'm using Nikola with Amazon S3, and the ``s3cmd`` I use to deploy my site
is not within the Nikola container.  Since it's a single command to deploy
my site, I have that within a separate shell script.
