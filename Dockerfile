FROM centos:7

# RUN yum -y install openssh openssh-clients openssh-server && yum clean all
RUN yum -y install openssh openssh-server \
    && yum clean all \
    && rm -rf /var/cache/yum/*

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

RUN useradd -u 1000 guest

RUN mkdir -p /home/guest/.ssh && chown guest. /home/guest/.ssh && chmod 700 /home/guest/.ssh 
# ADD .ssh/id_rsa.pub /home/guest/.ssh/authorized_keys
# RUN chown guest. /home/guest/.ssh/authorized_keys && chmod 600 /home/guest/.ssh/authorized_keys
VOLUME /home/guest/.ssh

# RUN echo "root:jump" | chpasswd
# RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# USER 1000
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]