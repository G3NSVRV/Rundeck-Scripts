ARG IMAGE
FROM ${IMAGE}

ARG RD_PORT

COPY --chown=rundeck:root remco /etc/remco

RUN sed -i "s/SERVER_PORT/${RD_PORT}/g" /etc/remco/templates/rundeck-config-extras.properties