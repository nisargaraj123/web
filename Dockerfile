FROM tomcat:9-jre9
COPY ./target/web.war /usr/local/tomcat/webapps/