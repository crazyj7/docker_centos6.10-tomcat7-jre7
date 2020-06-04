FROM ubuntu:16.04
MAINTAINER crazyj7@gmail.com
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential binutils libtool make gcc g++ openjdk-8-jdk git dos2unix vim wget 

# install path ; /usr/share/tomcat8
RUN apt-get install -y tomcat8
# link
WORKDIR /usr/java
RUN /bin/ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/java/latest
WORKDIR /usr/local
RUN /bin/ln -s /usr/share /usr/local/tomcat

ENV JAVA_HOME=/usr/java/latest
ENV LD_LIBRARY_PATH=.:/usr/local/lib
ENV PATH=$PATH:/usr/java/latest/bin

WORKDIR /root

