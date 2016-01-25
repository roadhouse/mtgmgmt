# Copyright 2014 George Cooper
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:14.04

MAINTAINER eGloo

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-security multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu trusty-security multiverse" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential git
RUN apt-get install -y python-software-properties software-properties-common

RUN apt-get install -y postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4 libpq-dev libssl-dev
RUN apt-get install -y pgtune apg

RUN mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp
RUN chown postgres /var/run/postgresql/9.4-main.pg_stat_tmp
RUN chgrp postgres /var/run/postgresql/9.4-main.pg_stat_tmp

VOLUME ["/data"]

EXPOSE 5432

RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# RUN git clone git@github.com:roadhouse/mtgmgmt.git
# RUN cd mtgmgmt && bundle install && rake bootstrap:run
RUN pwd
RUN ls -la
