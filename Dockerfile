FROM oraclelinux
RUN yum update -y
RUN yum install wget -y
RUN yum install java -y
RUN cd /tmp
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.96/bin/apache-tomcat-7.0.96.tar.gz
RUN tar xzf apache-tomcat-7.0.96.tar.gz
RUN mv apache-tomcat-7.0.96 /usr/local/tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64" >> /etc/default/tomcat7
COPY selfsigned.cer /tmp
COPY *.zip /usr/local/tomcat7/webapps/ROOT/
RUN unzip /usr/local/tomcat7/webapps/ROOT/*.zip
#RUN  keytool -import -noprompt -trustcacerts -alias tomcat -file selfsigned.cer -keystore "$JAVA_HOME/jre/lib/security/cacerts" -storepass changeit

# Expose the default tomcat port
EXPOSE 8080

# Start the tomcat (and leave it hanging)
CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out
