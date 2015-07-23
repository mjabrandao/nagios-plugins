FROM debian:wheezy
MAINTAINER Mário Brandão <mariobrandao@gmail.com>

RUN apt-get update && apt-get install -y nagios-plugins 
RUN apt-get install -y ruby

# Install Redis gem
RUN /bin/bash -l -c "gem install redis --no-ri --no-rdoc"

# Copy check_sentinel plugin
COPY check_sentinel /usr/lib/nagios/plugins/check_sentinel
COPY check_sentinel_master /usr/lib/nagios/plugins/check_sentinel_master
COPY check_sentinel_master_health /usr/lib/nagios/plugins/check_sentinel_master_health

ADD wrapper.sh /usr/local/bin/run-plugin

ENTRYPOINT ["bash", "-e", "/usr/local/bin/run-plugin"]
