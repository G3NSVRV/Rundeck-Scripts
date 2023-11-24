ARG IMAGE
FROM ${IMAGE}

ARG DB_HOSTNAME
ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG RD_PASSWORD

RUN yum update -y
RUN yum install -y java-11-openjdk-headless strace

RUN getent group rundeck || groupadd rundeck
RUN getent passwd rundeckuser || adduser rundeckuser -m -s /bin/sh -g rundeck
RUN passwd -d rundeckuser
RUN echo -e "${RD_PASSWORD}\n${RD_PASSWORD}" | passwd rundeckuser > /output

USER rundeckuser
COPY --chown=rundeckuser:rundeck rundeck.war /home/rundeckuser
RUN java -jar /home/rundeckuser/rundeck.war --installonly
RUN sed -i 's/^dataSource.url.*$//g' /home/rundeckuser/server/config/rundeck-config.properties
RUN sed -i 's/^server.address.*//g' /home/rundeckuser/server/config/rundeck-config.properties
RUN sed -i 's/^rundeck.storage.converter.1.*//g' /home/rundeckuser/server/config/rundeck-config.properties
RUN sed -i 's/^rundeck.storage.provider.1.*//g' /home/rundeckuser/server/config/rundeck-config.properties
RUN sed -i 's/^rundeck.config.storage.converter.1.*//g' /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.url=jdbc:mysql://${DB_HOSTNAME}/${DB_NAME}?autoReconnect=true&useSSL=false" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.username=${DB_USER}" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.password=${DB_PASS}" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.driverClassName=org.mariadb.jdbc.Driver" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "rundeck.storage.provider.type=db" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "rundeck.storage.provider.path=keys" >> /home/rundeckuser/server/config/rundeck-config.properties

CMD /bin/bash -c "sleep 45" && java -jar /home/rundeckuser/rundeck.war