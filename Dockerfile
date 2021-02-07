FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

WORKDIR /home/jovyan/

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential \
    curl \
    wget \
    gpg

# git
RUN apt install git-all -y

# FFmpeg
RUN git clone https://github.com/FFmpeg/FFmpeg.git

RUN apt-get install yasm
RUN cd FFmpeg && ./configure && \
    make && make install

# python
RUN apt update && apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update && apt install python3.7 -y

RUN apt-get install -y python3 python-dev python3-dev \
    python-pip python3.7-dev python3-pip

# librosa

RUN apt-get update && apt-get install libsndfile1-dev
RUN pip install librosa



# Kubeflow config
# jupyter
RUN pip install jupyterlab

ENV NB_PREFIX /

CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
