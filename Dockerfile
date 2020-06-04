FROM ubuntu:16.04
MAINTAINER crazyj7@gmail.com
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential binutils libtool make gcc g++ openjdk-8-jdk git dos2unix vim wget 

# jre link
WORKDIR /usr/java
RUN /bin/ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/java/latest

# install path ; /usr/share/tomcat8
RUN apt-get install -y tomcat8

# tomcat8 link
WORKDIR /usr/local/tomcat
RUN /bin/ln -s /etc/tomcat8 /usr/local/tomcat/conf &&\
/bin/ln -s /var/lib/tomcat8/webapps /usr/local/tomcat/webapps &&\
/bin/ln -s /usr/share/tomcat8/lib /usr/local/tomcat/lib &&\
/bin/ln -s /usr/share/tomcat8/bin /usr/local/tomcat/bin &&\
/bin/ln -s /var/log/tomcat8 /usr/local/tomcat/logs

# env
WORKDIR /root
ENV CATALINA_HOME=/usr/local/tomcat
ENV JAVA_HOME=/usr/java/latest
ENV JRE_HOME=/usr/java/latest/jre
ENV LD_LIBRARY_PATH=.:/usr/local/lib:$JAVA_HOME/bin:$CATALINA_HOME/bin
ENV PATH=$PATH:/usr/java/latest/bin
ENV HOME /root

VOLUME ["/usr/local/tomcat/webapps"]
EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

