ARG IMAGE
FROM ${IMAGE}

RUN yum update -y
RUN yum install java-1.8.0-openjdk-headless -y

RUN getent group rundeck || groupadd rundeck
RUN getent passwd rundeckuser || adduser rundeckuser -m -s /bin/sh -g rundeck
RUN passwd -d rundeckuser
RUN echo -e "rundeckpassword\nrundeckpassword" | passwd rundeckuser > /output

COPY rundeck.war /home/rundeckuser
USER rundeckuser

CMD java -jar /home/rundeckuser/rundeck.war