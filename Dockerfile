FROM ubuntu:18.04

RUN apt-get update &&\
      apt-get upgrade -y

RUN apt-get install python3 python3-pip -y &&\
      apt-get install -y openssh-server

RUN pip3 install ansible

RUN mkdir /var/run/sshd &&\
      echo 'root:root' | chpasswd &&\
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
      sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&\
      mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]