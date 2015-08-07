# docker run: docker run -t -d -P your_name/your_image
FROM centos:centos6
MAINTAINER YOHEI KAWAHARA inokappa
RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
#
RUN useradd -d /home/itamae -m -s /bin/bash itamae
RUN echo itamae:itamae | chpasswd
RUN echo 'itamae ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 22
CMD /usr/sbin/sshd -D -o UseDNS=no -o UsePAM=no -o PasswordAuthentication=yes -o UsePrivilegeSeparation=no -o PermitRootLogin=no -o PidFile=/tmp/sshd.pid
