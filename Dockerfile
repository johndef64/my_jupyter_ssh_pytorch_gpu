# syntax=docker/dockerfile:1
FROM nvcr.io/nvidia/pytorch:23.03-py3

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
COPY boot.sh .
COPY requirements.txt .
RUN chmod 777 boot.sh

RUN apt update && apt install  openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 user

RUN echo 'user:Iknos2023' | chpasswd

RUN service ssh start

#RUN pip install -r requirements.txt
RUN pip install jupyterlab[all] -U
RUN pip install jupyterlab[all] -U && \
    pip install ipywidgets
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

EXPOSE 22
#USER test
CMD ["./boot.sh"]