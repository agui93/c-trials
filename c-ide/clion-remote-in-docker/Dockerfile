############################################################
##  构建镜像的命令:
##      docker build -t c-env/c_remote_env:0.1 -f Dockerfile  .
##  启动容器的命令:
##      docker run -it -d --cap-add sys_ptrace -p127.0.0.1:2222:22 --name clion_remote_env --hostname clion-remote-machine c-env/c_remote_env:0.1
##  ssh登录容器:
##    用户名:clion  密码:clion  端口:2222 => ssh clion@127.0.0.1 -p 2222
##    用户名:root  密码:root  端口:2222   => ssh root@127.0.0.1 -p 2222
##  本地进入容器:
##      docker exec -it clion_remote_env /bin/bash
############################################################


FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y  tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y  ssh
RUN apt-get install -y  build-essential
RUN apt-get install -y  gcc
RUN apt-get install -y  g++
RUN apt-get install -y  gdb
RUN apt-get install -y  clang
RUN apt-get install -y  cmake
RUN apt-get install -y  automake
RUN apt-get install -y  pkg-config
RUN apt-get install -y  rsync
RUN apt-get install -y  tar
RUN apt-get install -y  python
RUN apt-get install -y  vim
RUN apt-get install -y  sudo

RUN apt-get clean autoclean



RUN yes root | passwd root
RUN useradd -m clion
RUN yes clion | passwd clion
RUN mkdir /run/sshd

RUN ( \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_test_clion

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]

