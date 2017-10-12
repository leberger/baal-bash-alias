#!/bin/bash

_man 'dorebuild' '[docker] Rebuild all dockers containers'
dorebuild='docker-compose down && docker-compose up --build -d nginx redis mysql workspace elasticsearch phpmyadmin'

_man 'doshutreup' '[docker] Shutdown all containers and re up them'
doshutreup='docker-compose down && docker-compose up -d nginx redis mysql workspace elasticsearch phpmyadminmd'

_man 'dossh' '[docker] SSH into a container'
dossh='docker-compose exec {container_name} bash'

function dossh(){
 docker-compose exec $1 bash
}
alias dossh='dossh'

_man 'dostop' '[docker] Stop all docker processes'
dostop='docker stop $(docker ps -a -q)'

_man 'dormmon' '[docker] removes all non-running containers'
dormnon='docker rm $(docker ps -a -q)'

dops='docker ps'

dorm='docker rm'


_man 'dormimage' '[docker] removes all untagged images'
dormimage='docker rmi $(docker images -q); '

_man 'doflog' '[docker] Follow logs of a machine (i.e. elasticsearch_1)'
doflog='docker logs --follow'

donyan='docker run -it supertest2014/nyan'

_man 'larefreshseed' '[laravel] Refresh and seed app datas'
larefreshseed='php artisan migrate:refresh --seed'

_man 'curlela' 'Test elasticsearch from the workspace'
curlela='curl -u elastic http://elasticsearch:9200'


# Running a different types of containers
# 
# Next I have two simple aliases that provide shoutcuts to my most common options for running interactive and daemonized containers.
# 
# The first alias runs a daemonized container.
# 
# alias dkd="docker run -d -P"
# 
# I use it like so:
# 
# $ dkd jamtur01/ssh
# 
# This will launch a daemonized container running my jamtur01/ssh image. I could also add a command override at the end of the command also.
# 
# My second alias is very similar but runs an interactive container instead.
# 
# alias dki="docker run -t -i -P"
# 
# I use this like so:
# 
# $ dki ubuntu /bin/bash
# 
# This will launch a interactive container with a TTY running the ubuntu image and executed with the /bin/bash command.
# Docker build function
# 
# Finally I have a function for interacting with the docker build command. The function allows me to skip typing the -t flag for tagging my new images.2
# 
# db() { docker build -t="$1" .; }
# 
# I use it like so:
# 
# $ db jamtur01/ssh
# 
# It assumes a Dockerfile in my current directory and then builds that file and tags the subsequent build with jamtur01/ssh.
# 
# I hope those are useful to folks and feel free to add others you use in the comments.