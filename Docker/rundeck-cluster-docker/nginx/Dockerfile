ARG IMAGE
FROM ${IMAGE}

ARG RD_PORT_01
ARG RD_PORT_02
ARG RD_URL

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN sed -i "s/RD_PORT_01/${RD_PORT_01}/g" /etc/nginx/conf.d/default.conf
RUN sed -i "s/RD_PORT_02/${RD_PORT_02}/g" /etc/nginx/conf.d/default.conf
RUN sed -i "s/RD_URL/$(echo ${RD_URL} | sed 's/\//\\\//g')/g" /etc/nginx/conf.d/default.conf
RUN sed -i "s/NGINX_UP/$(echo $RD_URL | cut -d '/' -f3)/g" /etc/nginx/conf.d/default.conf