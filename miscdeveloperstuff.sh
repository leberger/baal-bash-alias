#!/bin/bash

## Misc Developer Stuff


## /!\ SEE in docker.sh for laravel, elasticsearch, gulp commands

_man "getResume" "Get a *kind of* resume from a PHP file - list function names and classes"
alias getResume='g -n -e "^var .* =\ *" -ie "function" -ie "DEPRECATED" -ie "public" -ie "private" -ie "protected" -ie "class"'

#todo 
alias tf="echo;echo;tail -f -n 0 -q"
alias tfh="tf | head"



_man "replaceAll"\
  "/!\ Dangerous !! Replace all string by the other accross files from current direcotry"
alias replaceAll='replaceAll'

function replaceAll(){
 echo "this do not replace recursively yet.
 TODO !! "
 return

 read -r -p "Are you sure you would like to : sed -i 's/$1/$2/g'? [y|n]" response
 case "$response" in
  [yY][eE][sS]|[yY]) 
    sed -i 's/$1/$2/g'; echo "done";
    ;;
  *)
    echo "Aborted"
  ;;
 esac
}




_man "cjson" "curl json"
alias cjson='cjson' 

function cjson (){ 
  curl -s $1 | python -mjson.tool
}
