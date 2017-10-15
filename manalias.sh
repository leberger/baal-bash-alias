#!/bin/bash

declare -A _man_array

#function for documentation purposes in bash_alias
function _man(){
  lastElementNumber=$#-1
  ${ARR1[@]:(-1)}

  local descri=${@: -1}
  endofloop=`expr $# - 1`
  local cmdslist=''
  if [ $# -gt 2 ];then
    cmdslist="· [see ${@:1:`expr $# - 1`}]"
  fi
  for i in $(seq 1 $endofloop);   do
    alias_name=${!i}
    _man_array[${alias_name}]="$descri $cmdslist"
  done
}


_man "zz" "list many available commands with their short explanation"
alias zz="ls  /usr/bin | xargs whatis | less"

_man "alias_man" "aliasman" "man_alias" "manalias"\
  "[baal] gives the list of alias, and their short description when available"

##TODO aliasman c -> this should ONLY return the aliasman for c !!!! NOT the WHOLE list !!

alias alias_man='alias_man';alias aliasman='alias_man';alias man_alias='alias_man';alias manalias='alias_man'
function alias_man(){
  local alias_regex='[A-Za-z0-9_-.]*'
  \alias |\
    while read i; do
        if [[ $i =  *[A-Za-z0-9_-.]* ]];then
          i=`echo "$i" | sed "s/^alias \(${alias_regex}\)=/\1 : /g" `
          local aliased_command=`echo "$i" | sed "s/^\(${alias_regex}\) : .*/\1/g"`
          ####TO KEEP #########  echo " ${!_man_array[@]}"      
          if [ `echo "${_man_array[$aliased_command]}" | wc -c` -gt 1 ]; then
              echo -e "\e[1m$aliased_command\e[0m\t- ${_man_array[$aliased_command]}";
          else
            echo "$i"
          fi
        else
          echo -e "\e[31m NOT GOOD #$i# \e[0m"
        fi
    done
}


_man "falias" "findalias" \
  "[baal] locate where the alias or function is located in its bash alias file. // If it has ANY second argument, it will open relevant file in vi at the correct line"
#OMG !! THAT IS FUCKING MAGIC
alias falias='falias'
alias findalias='falias'
function falias () {
  if [ $# -eq 1 ];then
    grep -rHin "alias.*$1=" $BASH_ALIAS_FILE_DIR*
  else
    vi $(grep -rHin "alias $1=" $BASH_ALIAS_FILE_DIR* | sed 's/\(.*\):\(.*\):.*/+\2 \1/g')
  fi
}

