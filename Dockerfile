# OS version
FROM ubuntu:20.04

# Add i386 architecture to allow installation of 32-bit libs
RUN dpkg --add-architecture i386

ENV DEBIAN_FRONTEND=noninteractive

ARG UID
ARG USER
ARG GID
ARG HOME

RUN groupadd -g $GID $USER
RUN useradd -u $UID -g $GID $USER -m -d $HOME -p "$(openssl passwd -1 123456)"
# RUN useradd -g $GID $USER -m -d $HOME

RUN usermod -aG sudo $USER

RUN apt-get update
RUN apt-get install -y apt-utils \
 wget \
 sudo \
 net-tools \
 bzip2 \
 lib32stdc++6 \
 python \
 python3 python3-dev \
 git \
 lcov \
 cppcheck \
 autogen \
 autoconf \
 libtool \
 libxext-dev:i386 \
 libxext-dev \
 libfreetype6-dev:i386 \
 libfreetype6-dev \
 sudo \
 python3-pip \
 build-essential \
 libc6-dbg \
 libc6-dbg:i386 \
 libc6-dev-i386 \
 gcc-multilib \
 g++-multilib \
 openssh-client \
 clang-format-6.0 \
 iwyu \
 mesa-common-dev \
 ccache \
 curl \
 sqlite3 \
 zlib1g:i386 \
 openjdk-8-jdk \
 ruby-full \
 apt-transport-https \
 ca-certificates \
 gnupg \
 software-properties-common \
 iproute2 \
 valgrind \
 clang-tidy \
 firefox \
 tmux \
 ninja-build \
 libharfbuzz-dev \
 libglib2.0-dev \
 glib2.0 \
 xdotool \
 xdg-dbus-proxy \
 cpio \
 rsync \
 zsh \
 bc \
 libmount1:i386 \
 libuuid1:i386 \
 cmake

# Install NodeJS 12
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Get latest cmake version
#RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
#RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
#RUN apt-get update
# RUN apt-get install -y cmake

# RUN pip3 install junit2html
# RUN pip3 install pygments

USER $USER

# Setup working directory
WORKDIR $HOME
