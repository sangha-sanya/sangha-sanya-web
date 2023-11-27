#!/bin/bash


project_user="dh_qi2a7u"
project_server="sanghasanya.com"


dir=`pwd`

source=${dir}/public/
destination=${project_user}@${project_server}:/home/${project_user}/${project_server}

# rm -fR $source/*
docker run --rm -it \
  -v $(pwd):/src \
  klakegg/hugo:0.101.0-ext



# Newer files first. Drafts becoming published and new JPGs show go first /index.html or any archive to avoid 404
rsync -avh --ignore-existing  $source  $destination >> $HOME/nohup.out
# full
rsync -avh --delete $source  $destination >> $HOME/nohup.out
