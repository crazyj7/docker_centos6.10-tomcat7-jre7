docker run -d -p 9999:8080 \
  -v /home/psychic/storage/docker/app/tomcat9/webapps:/usr/local/tomcat/webapps  \
  --name tomcat9 \
  crazyj7/centos6.10-tomcat7-jre7:latest
