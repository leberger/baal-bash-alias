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
  else
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
    
    ls -d1 ${startOfLine}`echo "$arguments" | sed 's/  */*\/*/g'`${endOfLine}>$TMPFILE_list_dir
    #list_dir=${list_dir// /\\ }
    
    if [ `cat $TMPFILE_list_dir | wc -l` -le 1 ];then
      cat $TMPFILE_list_dir
      return
    else
      declare tmp_quoted_string=""
      declare tmp_array_options
      
      while read parcel; do
        tmp_array_options+=("$parcel" ·)
      done <$TMPFILE_list_dir
      
      TMPFILE=$(mktemp)
      dialog --nocancel --no-lines --no-button --no-description --menu " -" 20 50 8 \
              "${tmp_array_options[@]}" · O >&2 2>$TMPFILE
      cat $TMPFILE
      return
    fi
  fi
}

_man "c" \
 "[cd] magic change dir. Use magic paths, set shortcuts/c links"
alias c='c'

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

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
            [ -f $alias_file ] && sed -i.bak "/^${ln_name}/d" $alias_file
            shift
            argsss=$*
            linkk=$(magic_cd_helper $argsss);
            if [ -z "$linkk" ] ; then
              echo "not a valid path" #> &2
	      return
            else
              #relative to absolute path
              case $linkk in
                /*) absolute=$linkk;; # TODO shouldn't that be a \* ??
                *) absolute=$PWD/$linkk;;
              esac

              #print the result
              echo $absolute added as ${ln_name}
              #add to list
              echo $ln_name $absolute >> $alias_file
            fi
            return
          ;;
	  r|d)
            #remove a link from the list
            ln_name=$OPTARG
            echo `cat $alias_file | grep -n ^${ln_name}` link removed
            sed -i.bak "/^${ln_name}/d" $alias_file
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
Example : c -a paparchieve D la a #  ADD to your c-links the path /home/me/Documents/lava/archieve/, should this match the "D la a" magic path
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

    ### cd to anything, if it's been aliased or not ###	
    if [ `echo ${aliased} | wc -c` -eq 0 ] ; then
      cd "$(magic_cd_helper $*)"
    else 
	    #TODO to finish !
      #cd "$(magic_cd_helper \"${aliased}$\" $*)"
      #cd "${aliased}"
      aliased=`echo ${aliased} | sed 's/\/$//g'`
      cd "$(magic_cd_helper ${aliased} $*)"
    fi  

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
