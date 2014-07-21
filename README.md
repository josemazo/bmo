<!--

VISIT https://github.com/josemazo/bmo FOR SEE THIS FILE FORMATTED

-->

BMO &mdash; ![BMO](https://raw.githubusercontent.com/josemazo/bmo/master/resources/bmo.png "BMO")
=================================================================================================

A Machine Learning toolbox based on Docker and IPython Notebook.

Content
-------

1. [Installation](Installation)
  1. [Docker](Docker)
  2. [nsenter](nsenter)
  3. [BMO](BMO)
2. [Usage](Usage)
3. [List of Python main packages](List of Python main packages)
4. [License and more](License and more)

1. Installation
---------------

`BMO` has the next requirements, but continue reading before install anything.
* [Linux/x64](http://distrowatch.com/dwres.php?resource=major)
* [Docker](https://www.docker.com/)
* [nsenter](https://github.com/jpetazzo/nsenter) and the `docker-enter` utility

Being `BMO` based on `Docker`, and the last one can be installed only on `Linux/x64`, `BMO` is restricted to the same platform. This guide only covers the complete `BMO`installation on `Ubuntu 14.04 (Trusty Tahr)`, but excpet for the `Docker` installation step, you can use this guide with any Linux distribution. So, let's start! But before, you need to download `BMO`. For that open a terminal and execute these commands:
```
$ wget https://github.com/josemazo/bmo/releases/download/v0.1/bmo-v0.1.tar.gz
$ tar -zxvf bmo-v0.1.tar.gz
$ rm bmo-v0.1.tar.gz
$ cd bmo/
```

### 1.1. Docker

If you are not using `Ubuntu 14.04 (Trusty Tahr)` you can visit the [`Docker` installation page](https://docs.docker.com/installation/) for an extensive documentation.

**Important**: after installing `Docker` you need to be sure that it can run without the use of `sudo`.

In the case you are under `Ubuntu 14.04 (Trusty Tahr)` you can follow the next instructions.

First, install `Docker` with this easy step:
```
$ sudo apt-get -y install curl
$ curl -s https://get.docker.io/ubuntu/ | sudo sh
```

To verify that everything has worked as expected:
```
$ sudo docker version
```

And you will see something like:
```
Client version: 1.1.1
Client API version: 1.13
Go version (client): go1.2.1
Git commit (client): bd609d2
Server version: 1.1.1
Server API version: 1.13
Go version (server): go1.2.1
Git commit (server): bd609d2
```

Now let's use `Docker` without sudo:
```
$ sudo gpasswd -a ${USER} docker
$ sudo service docker restart
```

Loogout and log back in and check the version of `Docker` again:
```
$ sudo docker version
```

If you get the same output as before and nothing talking about permissions you have `Docker` installed. Congratulations!

### 1.2. nsenter

`nsenter` is needed for get a prompt of the `BMO docker image` when this is running (as a `container`) without using `ssh`. You can read [here](http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/) why you shouldn't use `ssh` in a `Docker container`.

For install `nsenter` you can visit [this repo](https://github.com/jpetazzo/nsenter) and follow the instructions detailed there **or** you can trust me and copy a compiled version that I provide in the `nsenter` folder:
```
$ sudo cp nsenter/nsenter nsenter/docker-enter /usr/local/bin/
```

**Important**: if you install `nsenter` using the instructions of the [mentioned repo](http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/) don't forget to install the `docker-enter` utilty. Also, if you can edit the `docker-enter` script and modify the line that call `nsenter` adding a `sudo` at the beginning, it will be great!

### 1.2. BMO

You really don't need to install anything, but you need to download or build the `BMO Docker image`. There are no difference for use `BMO` between download or build the image. But if you are a `Docker` user and you want to modify the image, you need to build it. In the other case, it's is preferable to download the image because it's faster, a lot.
```
./bmo -i
```

Wait, and that's all. You are finished with the installation.

2. Usage
--------

**Working on this section**

3. List of Python main packages
-------------------------------

Once the `BMO Docker image` has been downloaded or builded, a bunch of Python packages will be installed in the image. Here is a list of the main ones:
* beautifulsoup4
* gensim
* ipython[notebook]
* matplotlib
* networkx
* nltk
* numpy
* patsy
* pyenchant
* pygraphviz
* pandas
* pattern
* scikit-learn
* scipy
* seaborn
* simpy ujson
* statsmodels
* textblob

4. License and more
-------------------

* This project is released under the `MIT License`.
* The `BMO` name and its logo are property [Cartoon Network](http://www.cartoonnetwork.com/). The logo has been taken from the [Adventure Time wiki](http://adventuretime.wikia.com/) on [Wikia](http://www.wikia.com/).
