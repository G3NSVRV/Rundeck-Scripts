ARG IMAGE
FROM ${IMAGE}

ARG DB_HOSTNAME
ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG RD_PASSWORD
ARG DB_JDBC_URL
ARG DB_JDBC_DRIVER

RUN microdnf update -y
RUN microdnf install -y java-11-openjdk-headless passwd procps strace

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
RUN echo "dataSource.url=${DB_JDBC_URL}" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.username=${DB_USER}" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.password=${DB_PASS}" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "dataSource.driverClassName=${DB_JDBC_DRIVER}" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "rundeck.storage.provider.type=db" >> /home/rundeckuser/server/config/rundeck-config.properties
RUN echo "rundeck.storage.provider.path=keys" >> /home/rundeckuser/server/config/rundeck-config.properties

CMD /bin/bash -c "sleep 45" && java -jar /home/rundeckuser/rundeck.war