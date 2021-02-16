FROM ubuntu:18.04

RUN apt update && apt install -y language-pack-en
RUN update-locale LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt -y install haveged software-properties-common
RUN add-apt-repository ppa:bigbluebutton/support -y
RUN add-apt-repository ppa:rmescandon/yq -y
RUN add-apt-repository ppa:libreoffice/ppa
RUN apt update

RUN apt install -y curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt install -y nodejs

RUN apt install wget
RUN wget https://ubuntu.bigbluebutton.org/repo/bigbluebutton.asc -O- | apt-key add -
RUN echo "deb https://packages-eu.bigbluebutton.org/xenial-22/ bigbluebutton-xenial main" | tee /etc/apt/sources.list.d/bigbluebutton.list
RUN apt install -y apt-transport-https
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6657DBE0CC86BB64
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN apt update

RUN apt install -y bigbluebutton

RUN bbb-conf --restart
RUN bbb-conf --check
