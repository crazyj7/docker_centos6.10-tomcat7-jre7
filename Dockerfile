FROM centos:centos6.10
MAINTAINER crazyj7@gmail.com

RUN yum -y install sudo

# JDK
WORKDIR /usr/java

# add file -> auto uncompress. but URL file no auto uncompress.
#ADD jdk-7u80-linux-x64.tar.gz /usr/java
ADD https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz /usr/java
RUN tar xvfz jdk-7u80-linux-x64.tar.gz

RUN alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_80/bin/java 1
RUN alternatives --install /usr/bin/jar jar /usr/java/jdk1.7.0_80/bin/jar 1
RUN alternatives --install /usr/bin/javac javac /usr/java/jdk1.7.0_80/bin/javac 1
RUN echo "JAVA_HOME=/usr/java/jdk1.7.0_80" >> /etc/environment
RUN /bin/ln -s /usr/java/jdk1.7.0_80 /usr/java/latest

# install path ; /usr/share/tomcat7
WORKDIR /usr/local
ADD http://apache.tt.co.kr/tomcat/tomcat-7/v7.0.104/bin/apache-tomcat-7.0.104.tar.gz /usr/local
RUN tar xvfz apache-tomcat-7.0.104.tar.gz
#ADD apache-tomcat-7.0.104.tar.gz /usr/local
RUN /bin/ln -s /usr/local/apache-tomcat-7.0.104 /usr/local/tomcat

# env
WORKDIR /root
ENV CATALINA_HOME=/usr/local/tomcat
ENV JAVA_HOME=/usr/java/latest
ENV JRE_HOME=/usr/java/latest/jre
ENV LD_LIBRARY_PATH=.:/usr/local/lib:$JAVA_HOME/bin:$CATALINA_HOME/bin
ENV PATH=$PATH:/usr/java/latest/bin
ENV HOME /root

VOLUME ["/usr/local/tomcat/webapps","/usr/local/lib"]
EXPOSE 8080

#CMD ["/bin/bash"]
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

