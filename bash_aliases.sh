#!/bin/bash

# @author Cedric Pain
# github.com/leberger/baal-bash-alias
# linkedin.com/in/cedricpain/
# 
# I have always liked writing bash scripts - that is why I have always had well-maintained bash aliases - to speed up and ease my daily routines
# 
#


# CAUTIOUS :
# Because of the use of setxkbmap below, your keyboard should have the right ctrl and the padlock disabled and used as a special key to write special characters . Please comment out these lines to disable it

# HOW TO :
#
## add these lines in your ~/.bashrc file :
# if [ -f ~/baal-bash-alias/.bash_aliases.sh ]; then
#    . ~/baal-bash-alias/.bash_aliases.sh
# fi
#
#
#
# (if you add it, just type "source ~/.bash_aliases.sh" in your console to load the file
#  You should see a random adage given by fortune - or an error message that states "fortune: command not found" .
# In that case, either install fortune from your Linux' repository, or comment out the line which states "fortune"


fortune

export HISTCONTROL=ignoredups
HISTSIZE=4000
HISTFILESIZE=8000

#for German character, type right ctrl+ shift, let it go, then " then the letter ( a o u). For Eszett, ctrl+shift, then two times s. DONE !!!
setxkbmap -keycodes "evdev+aliases(qwerty)" -rules evdev -option terminate:ctrl_alt_bksp -option caps:super -option compose:rctrl  # -option ctrl:nocaps


AAABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
FILE_DIR=$(dirname $AAABSOLUTE_PATH)

#function for documentation purposes in bash_alias
function _man(){
  # TODO broken. Unbroke it
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
  "gives the list of alias, and their short description when available"

##TODO aliasman c -> this should ONLY return the aliasman for c !!!! NOT the WHOLE list !!

alias alias_man='alias_man'
alias aliasman='alias_man'
function alias_man(){
  # TODO broken. Unbroke it
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

#misc
if [ -f $FILE_DIR/general.sh ]; then
  . $FILE_DIR/general.sh
fi

#cd
if [ -f $FILE_DIR/cd.sh ]; then
  . $FILE_DIR/cd.sh
fi

#scripts that I do not need to share on git
if [ -f $FILE_DIR/secret.sh ]; then
  . $FILE_DIR/secret.sh
fi

#my script to download easily music
if [ -f $FILE_DIR/youdl.sh ]; then
  . $FILE_DIR/youdl.sh
fi

#git
if [ -f $FILE_DIR/git.sh ]; then
  . $FILE_DIR/git.sh
fi

#vagrant
if [ -f $FILE_DIR/vagrant.sh ]; then
  . $FILE_DIR/vagrant.sh
fi

#docker
if [ -f $FILE_DIR/docker.sh ]; then
  . $FILE_DIR/docker.sh
fi

## Misc Developer Stuff
if [ -f $FILE_DIR/dev.sh ]; then
  . $FILE_DIR/dev.sh
fi


#   apropos
#   df
#   which


alias shawim='shawim #modify the AWS IMAGE CLOUDRONT param for the test AWS server'
alias shawim-qa='shawim-qa #modify the AWS IMAGE CLOUDRONT param for the test AWS server'



