FROM ubuntu:latest

RUN apt update && apt install  openssh-server sudo -y
RUN mkdir -p ~/.ssh
RUN rm /etc/ssh/sshd_config
ADD ./ssd/ /etc/ssh/

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 

RUN  echo 'test:test' | chpasswd

RUN service ssh start
RUN ssh-keygen -q -t rsa -N '' -f /id_rsa
RUN /usr/bin/ssh-keygen -A
RUN ls -al /root/ 

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
