FROM ubuntu:21.04

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y && apt install -y curl git neovim zsh unzip
