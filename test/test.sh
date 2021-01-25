#!/usr/bin/env bash

prj_path=$(dirname $(dirname $(realpath $0)))

echo $prj_path

docker build $prj_path/test/docker -t main.dotz.test:v.0.0.1

#docker run -it -v $prj_path:/install main.dotz.test:v.0.0.1 /install/install.sh
docker run -it -v $prj_path:/install main.dotz.test:v.0.0.1 
