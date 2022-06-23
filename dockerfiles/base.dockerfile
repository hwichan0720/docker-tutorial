FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel

ENV HOME=/home

WORKDIR $HOME

# Update nvidia GPG key   
RUN rm /etc/apt/sources.list.d/cuda.list && \
    rm /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-key del 7fa2af80 && \
    apt-get update && apt-get install -y --no-install-recommends wget && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    apt-get update

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo 

RUN apt-get update && apt-get install -y \
    sudo \
    build-essential \
    curl \
    bzip2 \
    libjuman \
    libcdb-dev \
    libboost-all-dev \
    make \
    cmake \
    wget \
    git \
    autoconf \
    unzip \
    automake \
    zlib1g-dev

# install juman++
RUN mkdir $HOME/src && \
    cd $HOME/src && \
    curl -L -o jumanpp-2.0.0-rc2.tar.xz https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc2/jumanpp-2.0.0-rc2.tar.xz && \
    tar Jxfv jumanpp-2.0.0-rc2.tar.xz && \
    cd jumanpp-2.0.0-rc2/ && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/ && \
    make && \
    make install

# install mecab
RUN apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8

# install mecab-ko
RUN wget https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz &&\
    tar zxfv mecab-ko-dic-2.1.1-20180720.tar.gz &&\
    cd mecab-ko-dic-2.1.1-20180720 &&\
    ./autogen.sh &&\
    ./configure  &&\
    make &&\
    make install 

# install sentencepiece
RUN git clone https://github.com/google/sentencepiece.git &&\
    cd sentencepiece &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    make -j $(nproc) &&\
    make install &&\
    ldconfig -v

# install japanese_bart_pretrained_model branch
RUN pip install -U pip &&\
    pip install pyknp &&\
    git clone -b japanese_bart_pretrained_model https://github.com/utanaka2000/fairseq.git &&\
    cd fairseq &&\
    pip install --editable .


RUN pip install zenhan &&\
    pip install sentencepiece &&\
    pip install pandas &&\
    pip install scipy &&\
    pip install -U numpy &&\
    pip install seaborn &&\
    pip install jupyterlab

RUN rm -rf $HOME/src && \
    apt-get purge -y \
    build-essential \
    curl \
    bzip2

RUN chmod -R g+rwx $HOME/

# RUN echo 'root:password' | chpasswd 

# RUN apt-get update && apt-get install -y sudo
# ARG UID
# RUN useradd newuser -u $UID -m 
# RUN echo 'newuser:password' | chpasswd
# RUN usermod -aG root newuser
# USER newuser
