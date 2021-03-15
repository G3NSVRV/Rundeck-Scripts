ARG IMAGE
FROM ${IMAGE}

COPY dump.sql /docker-entrypoint-initdb.d
RUN chmod 777 /docker-entrypoint-initdb.d/dump.sql