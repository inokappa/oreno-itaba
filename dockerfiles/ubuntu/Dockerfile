# reference: https://docs.docker.com/examples/running_ssh_service/
# docker run: docker run -t -d -P your_name/your_image
FROM ubuntu:14.04
MAINTAINER YOHEI KAWAHARA inokappa
RUN apt-get update
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:itamae' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# ssh ログイン後に即切断を防ぐ
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
