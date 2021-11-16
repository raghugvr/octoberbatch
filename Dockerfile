FROM tomcat:9.0
COPY ./target/WebApp.war /usr/local/tomcat/webapps/demo.war