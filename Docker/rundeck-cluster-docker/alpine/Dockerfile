ARG IMAGE
ARG NODE_PASS

FROM ${IMAGE}

RUN apk update
RUN apk upgrade
RUN apk add openssh

RUN getent group rundeck || addgroup rundeck
RUN getent passwd rundeckuser || adduser rundeckuser -h /home/rundeck -s /bin/sh -G rundeck -D
RUN passwd -d rundeckuser
RUN echo -e "rundeckpassword\nrundeckpassword" | passwd rundeckuser > /output

RUN echo "UseDNS no" > /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "Port 22" >> /etc/ssh/sshd_config
RUN echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
RUN echo "GatewayPorts no" >> /etc/ssh/sshd_config
RUN echo "X11Forwarding no" >> /etc/ssh/sshd_config
RUN echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
RUN echo "Subsystem	sftp /usr/lib/ssh/sftp-server" >> /etc/ssh/sshd_config

RUN ssh-keygen -A

CMD cat /output && cat /etc/ssh/sshd_config && /usr/sbin/sshd -f /etc/ssh/sshd_config -D