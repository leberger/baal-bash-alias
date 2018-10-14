#!/bin/bash

#TODO :
#  c Documents/Winamax\ Poker/accounts/SharKKeater/data/
#  ls: cannot access *Documents/Winamax*/*Poker/accounts/SharKKeater/data/: No such file or directory

#TODO :
# c .. pkr
# ls: cannot access *..*/*pkr*/: No such file or directory
#
#TODO :
# cc zik II (chain actions from cc (shortcuts) to usual c directory stuff)
#
#TODO : c Doc %% Pap - will go to a *Pap* directory located ANYWHERE (at any level) in the *Doc* directory
#
#TODO : If there is no possible result, use a case insensitive match instead of case sensitive
#
#TODO : c hidden directories too ( .bash_aliases.dir for instance .

#TODO : replace ..c by .. , ...c by ... and .4 by, well, .4 . Make sure that if used empty ( .. for instance ) the default .. behaviour stay the same . 

#TODO : .. , ...  and .... should auto-complete on their respective level

#TODO : /Documents/CV/JobDescription > ..c CV
#       ls: cannot access *..*/*CV*/: No such file or directory


unset -f magic_cd_helper

function magic_cd_helper(){

  declare arguments startOfLine endOfLine list_dir TMPFILE tmp_quoted_string
  
  arguments=$( echo "$*" | sed 's/%/*/g'  )
          
  if [ $# -eq 0 ];then
    return;
  fi

  if [ $(echo $arguments | grep -c '^/') -eq 0 ];then
    if ! [[  "$arguments" =~ ^\.\..* ]];then
    startOfLine='*'
    fi 
  fi
  if [ $(echo $arguments | grep -c '/$') -eq 0 ];then
    endOfLine='*/'
  fi
      
  #example z@b:~ > c M my RO
  #        z@b:~/Music/myMisc/20170403-Pinkaerobic73-ROCKnbaby >
  TMPFILE_list_dir=$(mktemp)
  
  
  # be able to find paths like .gnome/test/ , with c no tes
  #  to do that, we enable extglob
  # http://mywiki.wooledge.org/glob
  # remember whether extglob was originally set, so we know whether to unset it
  shopt -q dotglob; dotglob_set=$?
  # set extglob if it wasn't originally set.
  ((dotglob_set)) && shopt -s dotglob
  # Note, 0 (true) from shopt -q is "false" in a math context.
  ls -d1 ${startOfLine}`echo "$arguments" | \
    sed 's/\/  */\/*/g' | sed 's/  *\//\*\//g' | \
    sed 's/  */*\/*/g'  | sed 's/\/\*\.\.\*\//\/..\//g' `${endOfLine}>$TMPFILE_list_dir
  #list_dir=${list_dir// /\\ }
  
  # unset extglob if it wasn't originally set
  ((extglob_dotglob)) && shopt -u dotglob
  
  if [ `cat $TMPFILE_list_dir | wc -l` -le 1 ];then
    cat $TMPFILE_list_dir
    return
  fi
  
  declare tmp_quoted_string=""
  declare tmp_array_options
  
  while read parcel; do
    tmp_array_options+=("$parcel" ·)
  done <$TMPFILE_list_dir
  
  TMPFILE=$(mktemp)
  dialog --nocancel --no-lines --no-button --no-description --menu " -" 20 50 8 \
	  "${tmp_array_options[@]}" · O >&2 2>$TMPFILE
  cat $TMPFILE
}

_man "c" \
 "[cd] magic change dir. Use magic paths, set shortcuts/c links. c -h for help"

_man ".." "..." "...." "....." ".3" ".4" ".5" ".6" ".7" \
	 "[cd] magic change dir. '\`...\` foo' will go up three directories then cd any dir that looks like 'foo'"

alias c='c'

alias -- -='cd -'
alias ..='c ..'
alias ...='c ../..'
alias .3='c ../../..'
alias ....='c ../../..'
alias .4='c ../../../..'
alias .....='c ../../../..'
alias .5='c ../../../../..'
alias .6='c ../../../../../..'
alias .7='c ../../../../../../..'

# _man '..c' \
#  '[cd] c from upper directory.
#    Example : ~/Documents/$ ..c Ex #will go in ~/Example'

# _man "-c" \
# 	 "[cd] c from home directory.
#    Example : ~/Documents/$ ..c Ex #will go in ~/Example"
# 
# alias -- -c='_-c3'
# alias '..c'='_-c1'
# 
# _man "...c" '[cd] see ..c'
# alias '...c'='_-c2'

function c(){

  local alias_file=$HOME'/.bash_aliases__c_alias.list'
  local argsss
  local linkk
  local opt
  local OPTIND=1

  if [ $# -eq 0 ];then

    ### cd home ###
    cd;
  else

     ### deal with editing links - a (add), r/d (remove/delete), l (list), h (help) ###
     # we shouldn't use while, as only one option should be use !
     while getopts "a:r:d:lh" opt; do
       local ln_name=$OPTARG
       local argsss
       case $opt in
          a)
	    if [ `echo "$OPTARG" | grep -c '[^A-Za-z0-9_.-]'` -ne 0 ];then
	      echo "not a valid alias name" 
	      return
            fi
            shift
            #remove aready existing alias
            [ -f $alias_file ] && sed -i.bak "/^${ln_name} /d" $alias_file
            shift
            if [ $# -eq 0 ] ;then
	      linkk=`pwd`/
	    else
              argsss=$*
              linkk=$(magic_cd_helper $argsss);
	    fi
	    if [ -z "$linkk" ] ; then
              echo "not a valid path" #> &2
	      return
            
            #relative to absolute path
            case $linkk in
              /*) absolute=$linkk;; # TODO shouldn't that be a \* ??
              *) absolute=$PWD/$linkk;;
            esac

            #print the result
            echo $absolute added as ${ln_name}
            #add to list
            echo $ln_name $absolute >> $alias_file
            
            return
          ;;
	  r|d)
            #remove a link from the list
            ln_name=$OPTARG
            echo `cat $alias_file | grep -n ^${ln_name} ` link removed
            sed -i.bak "/^${ln_name} /d" $alias_file
            return
          ;;
          l)
            #list the links
            cat $alias_file
            return
          ;;
          h)
            echo "c [a {magic path}][r|d {magic path}][l][h] | [arg]
Example : c  D Pap                #  go to ~/Document/Paperasse
Example : c -a paparchieve D la a #  ADD to your c-links the path /home/me/Documents/lava/archieve/, should this match the "D la a" magic path.
          c -a foobar # add to your c-links the current path
Example : c -r paparchieve        #  REMOVE the c-link path
Example : c -l                    #  list the c-links
"
          return
          ;;
          *)
            echo "invalid option"
            return
          ;;
       esac
    done

    ### links : cd links ### 
    aliased=''
    if [[ $1 = :* ]] ; then
      path=$(echo $1 | cut -c2-)
      aliased=$(cat $alias_file | grep "^$path " | cut -d' ' -f2)
      shift
    fi

    # cd to anything, if it's been aliased or not
    cd "$(magic_cd_helper ${aliased} $*)"

  fi
  return;
}

_man "cc" "[cd] use easily c-links (type c -h for help)"
alias cc='cc'
#shortcut of c :{link} , to access your private links - 
function cc(){
  c :$*
}

function _-c1(){
  cd "$(magic_cd_helper .. $*)";
}

function _-c2(){
  cd "$(magic_cd_helper ../.. $*)";
}

function _-c3(){
  cd "$(magic_cd_helper ~ $*)";
}

_complete_cc () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    cc_list=$(cut -f1 -d' ' $HOME'/.bash_aliases__c_alias.list')

    COMPREPLY=( $(compgen -W "${cc_list}" -- $cur))
    return 0
}
complete -F _complete_cc cc
