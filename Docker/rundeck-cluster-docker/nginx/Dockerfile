ARG IMAGE
FROM ${IMAGE}

ARG RD_PORT_01
ARG RD_PORT_02
ARG RD_PROTOCOL
ARG RD_HOST

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN sed -i "s/RD_PORT_01/${RD_PORT_01}/g" /etc/nginx/conf.d/default.conf
RUN sed -i "s/RD_PORT_02/${RD_PORT_02}/g" /etc/nginx/conf.d/default.conf
RUN sed -i "s/RD_URL/${RD_PROTOCOL}\:\/\/${RD_HOST}/g" /etc/nginx/conf.d/default.conf
RUN sed -i "s/NGINX_UP/${RD_HOST}/g" /etc/nginx/conf.d/default.conf
