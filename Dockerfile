# BMO

FROM ubuntu:14.04
MAINTAINER Jose M. Camacho <hello@josemazo.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy dist-upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install build-essential gfortran libatlas-dev libatlas3-base libfreetype6-dev liblapack-dev libpng-dev libxml2-dev libxslt1-dev libyaml-dev pkg-config python-dev python-pip supervisor zlib1g-dev

RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy autoremove
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy autoclean

RUN pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U

RUN pip install numpy
RUN pip install scipy
RUN pip install matplotlib
RUN pip install bottleneck cython numexpr nose patsy pyenchant pytz pyyaml
RUN pip install configobj lxml python-dateutil textblob
RUN pip install beautifulsoup4 gensim ipython[notebook] mpltools nltk pandas pattern scikit-learn simpy ujson
RUN pip install statsmodels
RUN pip install seaborn
RUN pip install moss

ADD installation_files/ipython_notebook_config.py /ipython_notebook_config.py
RUN IPYTHON_DIR=$(ipython locate) && \
    mv /ipython_notebook_config.py $IPYTHON_DIR/profile_default/ipython_notebook_config.py

ADD installation_files/ipynblogo.png /ipynblogo.png
RUN mv /ipynblogo.png /usr/local/lib/python2.7/dist-packages/IPython/html/static/base/images/ipynblogo.png

RUN mkdir -p /var/log/supervisor
ADD installation_files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
