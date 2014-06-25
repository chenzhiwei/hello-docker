# Ubuntu Base
#
# VERSION 0.0.1
#

FROM ubuntu:14.04
MAINTAINER Chen Zhiwei <zhiweik@gmail.com>

# add a new user since ubuntu disabled root user by default
RUN useradd -m -d /home/ubuntu -s /bin/bash -G adm,sudo ubuntu

# change the `ubuntu` user password to `password`
RUN echo 'ubuntu:password' | chpasswd

# make sure the package repository is up to date
RUN apt-get -qq update

# install essential packages
RUN apt-get -qqy install vim dnsmasq openssh-server bash-completion

# setup dnsmasq
RUN echo 'user=root' >> /etc/dnsmasq.conf
RUN echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf

RUN echo 'nameserver 8.8.8.8' > /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

# add files and change owner
ADD ./config/dot_vimrc /home/ubuntu/.vimrc
RUN chown -R ubuntu:ubuntu /home/ubuntu

EXPOSE 22

RUN mkdir /var/run/sshd

CMD ["/usr/sbin/sshd", "-D"]
