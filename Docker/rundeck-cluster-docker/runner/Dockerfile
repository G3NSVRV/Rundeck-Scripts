ARG IMAGE
FROM ${IMAGE}

ARG RD_URL

USER root
RUN apt -y update
RUN apt -y install curl jq
COPY runner-check.sh /home/runner/runner-check.sh
RUN chmod +x /home/runner/runner-check.sh
RUN sed -i "s/RD_URL/$(echo ${RD_URL} | sed 's/\//\\\//g')/g" /home/runner/runner-check.sh

USER runner
CMD ["/bin/bash", "-c", "/home/runner/runner-check.sh"]