##############################
Nikola Appliance
##############################

Purpose
###########

This ``Dockerfile`` creates a sandboxed, runnable `Nikola <https://getnikola.com>`_ environment based on the latest Ubuntu 14.04 image, Python developer packages, and the latest Nikola package installed with pip3.

    ``pip3 install nikola``

This works in docker even if your host system is not running Ubuntu 14.04.


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

To build the docker image::

  $ docker build -t dmmmdfll/nikola github.com/dmmmdfll/docker_nikola

You can see your new image with this command::

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

The package nikola is installed with 

    ``pip3 install nikola``
    
inside the image.

Some warnings are generated on ``nikola build``:

* WARNING: Nikola: In order to hyphenate texts, you must install the "pyphen" Python package.

* …more warnings

I decided that the warnings would likely be resolved by running ``pip3 install nikola[extras]``.

I tried that.

Nikola exited fatally with exceptions that I did not fully understand.  The exception had something to do with not being able to find the hyphenation dictionary and that the install could not be in .local.

I need to do some more research to sort out for myself what is going on before trying to guess at a fix.

**I have not tried a deploy. I am leaving the following limitation from the forked repo at https://github.com/rbrewer123/docker_nikola because it seems likely that the same would be true for this image**

The only limitation I know of so far is using Nikola`s ``deploy`` command.
I'm using Nikola with Amazon S3, and the ``s3cmd`` I use to deploy my site
is not within the Nikola container.  Since it's a single command to deploy
my site, I have that within a separate shell script.
