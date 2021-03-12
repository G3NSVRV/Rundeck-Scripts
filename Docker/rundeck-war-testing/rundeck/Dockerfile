ARG IMAGE
FROM ${IMAGE}

RUN apt update
RUN apt upgrade -y
RUN apt install openjdk-8-jre-headless -y

RUN getent group rundeck || addgroup rundeck
RUN getent passwd rundeckuser || adduser rundeckuser -h /home/rundeck -s /bin/sh -G rundeck -D
RUN passwd -d rundeckuser
RUN echo -e "rundeckpassword\nrundeckpassword" | passwd rundeckuser > /output

COPY rundeck.war /home/rundeck

USER rundeck

CMD java -jar /home/rundeck/rundeck.war