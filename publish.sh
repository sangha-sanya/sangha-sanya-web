#!/bin/bash

project=sangha-sanya-web
project-user="dh_qi2a7u"
project-server="sanghasanya.com"

cd $HOME/${project}

before_pull=`git rev-parse HEAD `

git pull --rebase > $HOME/nohup.out

after_pull=`git rev-parse HEAD `


if [ "$before_pull" == "$after_pull" ]; then
  echo "and no changes in git, exiting." >> $HOME/nohup.out
  exit 0
fi


cd $HOME/${project}/
hugo >> $HOME/nohup.out 


source=$HOME/${project}/public/
upload=$HOME/${project}/upload/
destination=${project_user}@${project_server}:/home/${project_user}/${project_server}

# checksum on local
rsync -r -h --delete --checksum $source $upload >> $HOME/nohup.out
# Newer files first. Drafts becoming published and new JPGs show go first /index.html or any archive to avoid 404
rsync -avh --ignore-existing  $upload  $destination >> $HOME/nohup.out
# full
rsync -avh --delete $upload  $destination >> $HOME/nohup.out

git add $HOME/${project}/content >> $HOME/nohup.out
git commit -m "new posts" >> $HOME/nohup.out
git push >> $HOME/nohup.out 
