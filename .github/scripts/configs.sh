#!/bin/bash


cd config/$app/$version
filename=Kubefile
if  [ -f Dockerfile ]; then
  filename=Dockerfile
fi
sudo sealos login $registry  -u $username -p  $password
sudo sealos build -t $registry/$repo/$app:$version -f $filename .
sudo sealos push $registry/$repo/$app:$version
