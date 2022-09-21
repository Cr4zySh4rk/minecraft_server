#!/bin/bash

echo "Pushing to minecraftServer branch master!"

eval `ssh-agent`

ssh-add ~/.ssh/minecraft

git push origin master

echo "Pushed to minecraftServer branch master!"
