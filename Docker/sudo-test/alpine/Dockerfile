ARG IMAGE
FROM ${IMAGE}

ARG NODE_PASS

RUN apk update
RUN apk upgrade
RUN apk add openssh sudo

RUN getent group rundeck || addgroup rundeck
RUN getent passwd rundeckuser || adduser rundeckuser -h /home/rundeck -s /bin/sh -G rundeck -D
RUN getent passwd newuser || adduser newuser -h /home/rundeck -s /bin/sh -G wheel -D
RUN echo -e "${NODE_PASS}\n${NODE_PASS}" | passwd rundeckuser > /output

RUN echo "UseDNS no" > /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "Port 22" >> /etc/ssh/sshd_config
RUN echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
RUN echo "GatewayPorts no" >> /etc/ssh/sshd_config
RUN echo "X11Forwarding no" >> /etc/ssh/sshd_config
RUN echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
RUN echo "Subsystem	sftp /usr/lib/ssh/sftp-server" >> /etc/ssh/sshd_config

RUN ssh-keygen -A

RUN echo "%rundeck ALL=(newuser) NOPASSWD:ALL" >> /etc/sudoers.d/custom

CMD cat /output && cat /etc/ssh/sshd_config && /usr/sbin/sshd -f /etc/ssh/sshd_config -D