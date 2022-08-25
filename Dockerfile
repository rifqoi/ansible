FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo vim unzip zip python && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS user
ARG TAGS
RUN addgroup --gid 1000 rifqoi
RUN adduser --gecos rifqoi --uid 1000 --gid 1000 --disabled-password rifqoi
RUN usermod -aG sudo rifqoi
RUN echo "rifqoi:pass" | chpasswd
USER rifqoi
WORKDIR /home/rifqoi

FROM user
COPY . ansible
WORKDIR ./ansible
RUN ansible-galaxy install -r requirements.yaml
CMD ["ansible-playbook", "-K", "--diff", "-v", "--extra-vars", "@values.yaml", "main.yaml"]
