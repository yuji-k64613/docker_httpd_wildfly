FROM fedora:latest
RUN yum -y install java-1.8.0-openjdk tar net-tools
RUN cd /opt && curl https://download.jboss.org/wildfly/16.0.0.Final/wildfly-16.0.0.Final.tar.gz | tar zx
RUN ln -s /opt/wildfly-16.0.0.Final /opt/wildfly
RUN groupadd -r cookbook -g 12345 && useradd -u 54321 -r -g cookbook -d /opt/wildfly -s /sbin/nologin -c "Wildfly user" wildfly
RUN /opt/wildfly/bin/add-user.sh admin password --silent
RUN chown -R wildfly:cookbook /opt/wildfly/*
EXPOSE 8080 9990
USER wildfly
#COPY docker-example.war /opt/wildfly/standalone/deployments/
COPY docker-example.war /tmp
COPY script.sh /opt
CMD [ "bash", "/opt/script.sh" ] 
