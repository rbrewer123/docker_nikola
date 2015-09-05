##############################
Nikola Appliance
##############################

Purpose
###########

This ``Dockerfile`` creates a sandboxed, runnable `Nikola
<https://getnikola.com>`_ environment based on the latest official Debian
package produced by the Nikola team.  This works in docker even if your
host system is not running Debian.


Requirements
################

This is tested with docker 1.8.0 running on Ubuntu 14.04.  Since it's
main dependency is docker, it should run on any platform with docker
installed (e.g. Windows, OS X).  It may or may not work with earlier
versions of docker.  To install docker on your system, see the
official `docker installation instructions
<https://docs.docker.com/installation>`_.



Installation
##############

To build the docker image::

  $ docker build -t rbrewer123/docker_nikola github.com/rbrewer123/docker_nikola

You can see your new image with this command::

  $ docker images

Grab the ``go`` script from github like this::

  $ git clone https://github.com/rbrewer123/docker_nikola

Now update the ``docker_nikola/go`` script to use your correct
``username``, ``uid``, ``group``, and ``gid``.  This avoids problems with
files being owned by root or other permissions problems that often occur
when using docker in this manner.


Run
#######

To run ``nikola`` from within the container, simply run the ``go`` script::

  $ docker_nikola/go help


Limitations 
#############

The only limitation I know of so far is using nikola`s ``deploy`` command.
I'm using nikola with Amazon S3, and the ``s3cmd`` I use to deploy my site
is not within the nikola container.  Since it's a single command to deploy
my site, I have that within a separate shell script.
