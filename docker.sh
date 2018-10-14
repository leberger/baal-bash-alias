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

# Docker stuff
# Clean stopped containers
alias cco="docker ps -a | grep "Exited" | awk '{print $1}' | xargs docker rm"
# After that, clean unused images to reclaim disk space
alias cimg="docker images | grep none | awk '{print \$3}' | xargs docker rmi"
# Finally the regular stuff just to save typing.
alias dps="docker ps -a"
alias di="docker images"
alias drmi="docker rmi"
alias drm="docker rm"


