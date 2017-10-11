#!/bin/bash

_man 'dorebuild' '[docker] Rebuild all dockers containers'
dorebuild='docker-compose down && docker-compose up --build -d nginx redis mysql workspace elasticsearch phpmyadmin'

_man 'doshutreup' '[docker] Shutdown all containers and re up them'
doshutreup='docker-compose down && docker-compose up -d nginx redis mysql workspace elasticsearch phpmyadminmd'

_man 'dossh' '[docker] SSH into a container'
dossh='docker-compose exec {container_name} bash'

_man 'dostop' '[docker] Stop all docker processes'
dostop='docker stop $(docker ps -a -q)'

# `docker rm $(docker ps -a -q)`

_man 'doflog' '[docker] Follow logs of a machine (i.e. elasticsearch_1)'
doflog='docker logs --follow'

_man 'larefreshseed' '[laravel] Refresh and seed app datas'
larefreshseed='php artisan migrate:refresh --seed'

_man 'curlela' 'Test elasticsearch from the workspace'
curlela='curl -u elastic http://elasticsearch:9200'

