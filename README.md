<!--

VISIT https://github.com/josemazo/bmo FOR SEE THIS FILE FORMATTED

-->

BMO &mdash; ![BMO](https://raw.githubusercontent.com/josemazo/bmo/master/resources/bmo.png "BMO")
=================================================================================================

BMO, pronounced Beemo, is a Machine Learning toolbox based on Docker and IPython Notebook. It's extensible with any tool or package you need beacuse it's like having a mini-Linux inside your Linux!

Content
-------

1. [Installation](#1-installation)
  1. [Docker](#11-docker)
  2. [nsenter](#12-nsenter)
  3. [BMO](#13-bmo)
2. [Usage](#2-usage)
  1. [Initial considerations](#21-initial-considerations)
  2. [Start](#22-start)
  3. [Finish](#23-finish)
  4. [Kill](#24-kill)
  5. [Enter](#25-enter)
  6. [Commit](#26-commit)
  7. [Status](#27-status)
3. [List of the installed Python main packages](#3-list-of-the-installed-python-main-packages)
4. [License and more](#4-license-and-more)

1. Installation
---------------

`BMO` has the next requirements, but continue reading before install anything.
* [Linux/x64](http://distrowatch.com/dwres.php?resource=major)
* [Docker](https://www.docker.com/)
* [nsenter](https://github.com/jpetazzo/nsenter) and the `docker-enter` utility

`BMO` is based on `Docker`, and the last one can be installed only on `Linux/x64`, so, `BMO` is restricted to the same platforms. This guide only covers the complete `BMO`installation on `Ubuntu 14.04 (Trusty Tahr)`, but excpet for the `Docker` installation step, you can use this guide with any Linux distribution. So, let's start! But before, you need to download `BMO`. For that open a terminal and execute these commands:
```
$ wget https://github.com/josemazo/bmo/releases/download/v0.1/bmo-v0.1.tar.gz
$ tar -zxvf bmo-v0.1.tar.gz
$ rm bmo-v0.1.tar.gz
$ cd bmo/
```

### 1.1. Docker

If you are not using `Ubuntu 14.04 (Trusty Tahr)` you can visit the [`Docker` installation page](https://docs.docker.com/installation/) for an extensive documentation.

**Important**: after installing `Docker` you need to be sure that it can run without the use of `sudo`. If you are using `Ubuntu 14.04 (Trusty Tahr)`, this guide will show you how to do it.

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
$ docker version
```

If you get the same output as before and nothing talking about permissions you have `Docker` installed correctly. Congratulations!

### 1.2. nsenter

`nsenter` is needed for get a prompt of the `BMO Docker image` when this is running without using `ssh`. You can read [here](http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/) why you shouldn't use `ssh` with `Docker`.

For install `nsenter` you can visit [this repo](https://github.com/jpetazzo/nsenter) and follow the instructions detailed there **or** you can copy a compiled version that is provided in the `nsenter` folder:
```
$ sudo cp nsenter/nsenter nsenter/docker-enter /usr/local/bin/
```

**Important**: if you install `nsenter` using the instructions of the [mentioned repo](http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/) don't forget to install the `docker-enter` utilty. Also, if you can edit the `docker-enter` script and modify the line that call `nsenter` adding a `sudo` at the beginning, it will be great!

### 1.3. BMO

You really don't need to install anything, but you need to download or build the `BMO Docker image`. There are no difference between download or build the `image`. But if you are a `Docker` user and you want to modify the image, you need to build it. In the other case, it's is preferable to download the image because it's faster, a lot.

So, to download:
```
./bmo -i
```

Or, if you decide to build it:
```
./bmo -ib
```

Wait, and that's all. You are finished with the installation.

2. Usage
--------

### 2.1. Initial considerations

Before start explaining how to use `BMO`, it would be nice to _briefly_ know how `Docker` works. `Docker` takes an `image`, something like in a virtual machine, and boots a `Linux` in your running `Linux`, something like a virutal machine. So, what is the difference? It's a little bit complicated, but you can read about what `Docker` is [here](https://docs.docker.com/introduction/understanding-docker/). The point here is that you will have much better performance that in virtual machine, in most cases, the same as if you run your sofware from your native machine, and this is very important when you are dealing with `Machine Learning`.

In summary, the main thing about `Docker` is that you have `images` and `containers`. A `container` is a running instance of an `image`, so you can have multiple `containers` from the same `image`. And what happens when you install some software or you create some files in a `container`? You can lose them if you remove the `container`, but you only need to commit the changes to an `image`, kind of _super easy_.

You may now be thinking that using `BMO`, having `Docker` in the middle, can be very difficult. But don't worry, for that, a `Python` script is provided, called `bmo`, something like a very basic `command line utility` for make your life easier. But if you are `Docker` pro-user you can take a look to the `Dockerfile` and the `bmo` script to understand everything. Also, for the last ones, at the end of the `bmo` script you have the full list of `Docker commands` that the script uses.

**Important**: if you aren't a `Docker` pro-user, you must know that if you use `Docker` without use the `bmo` script, a proper behaviour is not totally guaranteed.

Let's see the main use cases. If you need some more help, you can run:
```
./bmo --help
```
or you can become a `Docker` pro-user reading [this guide](https://docs.docker.com/userguide/). You will thank yourself for reading it, beacause `Docker` is prety awesome. Also, in that help, it's never mentioned the word `container`, it's used the concept `Docker image`, for try to abstract the logic behind `Docker`.

### 2.2. Start
I
For start using the `IPython Notebook` that `BMO` provides, you only need to execute the next command:
```
./bmo -s
```

The output that you are seeing is a `Docker` output. The `bmo` script always shows them, so you can look for help if any error ocurrs.

After that, open your Internet browser and visit:
```
http://localhost:8888/
```

Now you are in the IPython Notebook environment. You can visit [this link](http://ipython.org/notebook.html) for get more information about this awesome tool.

The directory that you are seeing in your browser it's the `notebooks` folder inside the root of the `BMO Docker container`. This directory corresponds to the `notebooks` folder that is inside the current directory in your terminal. That folder will contain your notebooks.

**Important**: `Docker` have a little problem with the files that it creates outside the `container`. The owner of these files is `root`. For change that, you can run the next command everytime you need:
```
./bmo -o
```

### 2.3. Finish

If you have finished your work with the `IPython Notebook` server for this sesion, you can finish the `BMO Docker container` with:
```
./bmo -f
```

This will finish the `container` and remove its reference from `Docker`.

If you want to finish the `container` without remove its reference, for example, for [save changes](#26-commit), you can execute:
```
./bmo -fo
```

After doing whatever you need, execute the next command for remove the `Docker` reference:
```
./bmo -rm
```

Also, after that, it's the perfect time for change the owner of the notebooks with:
```
./bmo -o
```
as we saw in the previous section.

**Important**: remember that for start the `BMO Docker container` again you need that its `Docker`reference is deleted.

### 2.4. Kill

Please, execute a `kill` command only when the `BMO Docker container` doesn't respond or became frozen, it's your last resort. For kill it, you can execute:
```
./bmo -k
```

As the `finish` command, the `kill` one also can be executed without remove the `BMO Docker container` reference:
```
./bmo -ko
```

Take a look to the [previous section](#23-finish) for see how to deal with the `Docker` reference after kill the `conainter` without remove it.

### 2.5. Enter

If you need some `Python` package, or a `Linux` one, that isn't installed on the `BMO Docker image` you can install them wiht `pip` or `apt-get`. For that, if the `BMO Docker containter` is running, you can execute:
```
./bmo -e
```

You will see a `prompt`. Now your are inside the `container` logged as `root`. Install everything you need and type:
```
exit
```

to return to your machine `prompt`.

**Important**: If you want your changes to be permanent, you need to perform a `commit`.

### 2.6. Commit

If you have made some changes to the `container` that you would like to be permanent you need to `commit` the current `BMO Docker container`. For that you need that the `container` is running or finished, never killed (bad practice) or removed. After check that, execute:
```
./bmo -c
```

And your `container` will be saved in the `BMO Docker image`.

### 2.7. Status

Sometimes you will want to know the state of the `BMO Docker container`. For that, you can use:
```
./bmo -st
```

The possible status of `BMO` are:
* running
* finished: you need to remove the `container` for start `BMO` again
* killed: you need to remove the `container` for start `BMO` again
* non-existent: there isn't any `container` attached to `Docker`, so you can start a new one

3. List of the installed Python main packages
---------------------------------------------

Once the `BMO Docker image` has been downloaded or builded, a bunch of Python packages will be installed in the `image`. Here is a list of the main ones:
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
* The `BMO` name and its logo are property of [Cartoon Network](http://www.cartoonnetwork.com/). The logo has been taken from the [Adventure Time wiki](http://adventuretime.wikia.com/) on [Wikia](http://www.wikia.com/).
* This is a project that will always be growing, and of course, you can contribute.
