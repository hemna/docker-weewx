#FROM debian:jessie
FROM ubuntu:16.10
MAINTAINER Walter A. Boring IV <waboring@hemna.com>

ENV VERSION=3.7.1
ENV HOME=/home/weewx
ENV BRANCH="v3.7.1"

ENV INSTALL=$HOME/install

RUN apt-get -y update
RUN apt-get install -y sqlite3 curl wget \
    python-configobj python-cheetah python-imaging \
    python-serial python-usb python-mysqldb git
RUN apt-get install -y build-essential
RUN apt-get install -y apache2
RUN apt-get install -y python-dev xtide xtide-data
RUN tide -l Sacramento

# Clean out default apache site
RUN rm /etc/apache2/sites-enabled/000*

# Create directory to hold some of the install files.
RUN mkdir /home/weewx && chmod 777 /home/weewx && cd /home/weewx && mkdir install

RUN cd $INSTALL && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install -U pip setuptools wheel
RUN pip install pyephem

# install weewx from source
RUN cd $INSTALL && git clone -b $BRANCH http://github.com/weewx/weewx
RUN cd $INSTALL/weewx && python setup.py build
RUN cd $INSTALL/weewx && python setup.py install --no-prompt
#RUN cd /tmp && ./setup.py build && ./setup.py install --no-prompt

# install my wx.hemna.com plugin
RUN cd $INSTALL && git clone https://github.com/hemna/weewx-hemna-plugin
RUN cd $INSTALL/weewx-hemna-plugin && python setup.py install

RUN cd $INSTALL && wget http://lancet.mit.edu/mwall/projects/weather/releases/weewx-forecast-3.1.2.tgz
RUN cd $INSTALL && $INSTALL/weewx/bin/wee_extension --install weewx-forecast-3.1.2.tgz

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir $HOME/public_html

# add all confs and extras to the install
# based on CONF env, copy the dirs to the install using CMD cp

# override this to run another configuration
ENV CONF default

ADD conf/ $HOME/conf/
ADD bin/run.sh $HOME/
RUN chmod 755 $HOME/run.sh

# Apache
ADD apache/weewx.conf /etc/apache2/sites-enabled/weewx.conf

WORKDIR $HOME

EXPOSE 80

CMD $HOME/run.sh
