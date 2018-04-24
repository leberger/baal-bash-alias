#!/bin/bash

## Misc Developer Stuff


## /!\ SEE in docker.sh for laravel, elasticsearch, gulp commands

_man "getResume" "Get a *kind of* resume from a PHP file - list function names and classes"
alias getResume='g -n -e "^var .* =\ *" -ie "function" -ie "DEPRECATED" -ie "public" -ie "private" -ie "protected" -ie "class"'

#todo 
#alias tf="echo;echo;tail -f -n 0 -q"
alias tfh="tf | head"

alias tf="tf"

tf(){
 #  tail -n 0  -f $1 | perl -pe 'BEGIN{$SIG{ALRM} = sub {print "\n\n"}} alarm 3' #|  perl -pe 'BEGIN{$SIG{ALRM} = sub {print ". . . . . . . . . . .  .   .    .\n"}} alarm 10'
 if [ "$1" == '$1' ]; then
   files=*;
 else
   files=$1;
 fi

 perl -e '
  $| = 1;
  seek STDIN, 0, 2; # uncomment if you want to skip the text that is already there.
  while (1) {
     if ($_ = <STDIN>) {
        print; $t = 0
     } else {
        print "\n" if ++$t == 3;
        print "• · ·  ·   ·    ·      ·          ·\n" if ++$t == 10;
        sleep 1;
     }
  }' < $1
}



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
    #sed -i 's/$1/$2/g'; echo "done";
    echo to test
    return

find ./ -type d \( -name .svn -o -name .git \) -prune -o \
   -type f -exec file {} \; \
   | grep -o -P '^.+: \w+ text' \
   | sed 's/: ASCII.*//g' \
   | xargs sed -i 's/$1/$2/g' {} \; # replace




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
