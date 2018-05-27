FROM centos:7

RUN yum -y install openssh openssh-server \
    && yum clean all \
    && rm -rf /var/cache/yum/*

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

RUN useradd -u 1000 guest

RUN mkdir -p /home/guest/.ssh && chown guest. /home/guest/.ssh && chmod 700 /home/guest/.ssh
VOLUME /home/guest/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]