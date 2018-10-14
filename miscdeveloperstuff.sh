#!/bin/bash

## Misc Developer Stuff


## /!\ SEE in docker.sh for laravel, elasticsearch, gulp commands

_man "phpResume" "Get a *kind of* resume from a PHP file - list function names and classes"
alias phpResume='\grep -n -e "^var .* =\ *" -ie "function" -ie "DEPRECATED" -ie "public" -ie "private" -ie "protected" -ie "class"'

_man "pythonResume" "Get the resume of a pythoon file . Usage : pythonResume {filename}"

function pythonResume () {
 grep -e "^def " -e "'''" -e '^@' $1 | sed 's/^def //g' | sed 's/()://g' | sed "s/'''//g"
}

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

 read -r -p "Are you sure you would like to : sed -i 's/$1/$2/g'? [y|n]" response
 case "$response" in
  [yY][eE][sS]|[yY]) 
    #sed -i 's/$1/$2/g'; echo "done";
    echo to test
echo s/$1/$2/g
#return;
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

_man "curlftpfs" "ftpmnt" "mntftp" "Mount remote ftp directory host locally into linux filesystem"
alias ftpmnt='curlftpfs'
alias mntftp='curlftpfs'




# npm aliases
alias ni='npm install'
alias nig='npm install -g'
alias nis='npm install -S'
alias nid='npm install -D'
alias nu='npm uninstall'
alias nug='npm uninstall -g'
alias nus='npm uninstall -S'
alias nud='npm uninstall -D'
alias nit='npm init'
alias nity='npm init -y'

#webpack
alias wp='webpack'
alias wpc='touch webpack.config.js'
alias wds='webpack-dev-server'

alias PANIC="espeak 'OH NO, the sky is falling'"




_complete_hosts () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    host_list=`{
        for c in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config
        do [ -r $c ] && sed -n -e 's/^Host[[:space:]]//p' -e 's/^[[:space:]]*HostName[[:space:]]//p' $c
        done
        for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts
        do [ -r $k ] && egrep -v '^[#\[]' $k|cut -f 1 -d ' '|sed -e 's/[,:].*//g'
        done
        sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; }|tr ' ' '\n'|grep -v '*'`
    COMPREPLY=( $(compgen -W "${host_list}" -- $cur))
    return 0
}
complete -F _complete_hosts ssh
complete -F _complete_hosts sshs
complete -F _complete_hosts host
complete -F _complete_hosts telnet
complete -F _complete_hosts ping

