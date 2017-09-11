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
# if [ -f ~/.bash_aliases.sh ]; then
#    . ~/.bash_aliases.sh
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
 
_man "alias_man" "aliasman" "man_alias" "manalias"\
  "gives the list of alias, and their short description when available"

##TODO aliasman c -> this should ONLY return the aliasman for c !!!! NOT the WHOLE list !!

alias alias_man='alias_man'
alias aliasman='alias_man'
function alias_man(){
      local alias_regex='[A-Za-z0-9_-.]*'
      \alias |\
	while read i; do
	    if [[ $i =  *[A-Za-z0-9_-.]*  ]];then
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

#scripts that I do not need to share on git
if [ -f ~/.bash_aliases_secret.sh ]; then
	    . ~/.bash_aliases_secret.sh
fi

alias yiic='/o/x-kz/mvcdir/yii/framework/yiic'

#see mntsshfs and sshfsmnt in bash_aliases_secret.sh

alias l='ls -last --color=auto'
_man lr \
 "[ls] l reversed - earliest modified last"
alias lr='ls -lastr --color=auto'


_man "g" \
  "grep files in current dir, and trim the result"

alias g='g'
function g(){
 grep -rHin -B 1 -A 1 $1 | cut -c1-130 | grep $1
}


_man "killThat" "FUCKING" "fucking" "k" \
  "kill ALL process matching the parameter"
function killThat(){
 ps aux | grep $1 | tr -s ' ' | cut -f2 -d" " | xargs kill -9
}
alias FUCKING='killThat'
alias fucking='killThat'
alias k='killThat'

_man "whoisb" "bwhois" \
	"lookup if a website is free with a whois. Whoisb can accept multiple arguments (hundreds...).
\tExample : bwhois{aa,top,}{red,black}dog.com"

alias bwhois='whoisb'
alias whoisb='whoisb'

function whoisb(){
  # A POSIX variable
  OPTIND=1         # Reset in case getopts has been used previously in the shell.

  start_date=`date`;echo $q
  
  output_file=""
  
  while getopts "hf:" opt; do
    case "$opt" in
    h|\?)
        echo "whoisb or bwhois
usage
 bwhois [-f filename] arg [arg1 [arg2 [arg3 ...]]]
   args: site to be tested"        
        return
        ;;
    f)  output_file=$OPTARG
    esac
  done
  shift $((OPTIND-1))
  
  
  if [ ${#output_file} -ge 1 ];then
    touch $output_file
  fi
  
  echo "";
  for i in $@; do
   if [ `whois $i | grep -c "No match for"` -eq 1 ] ; then
     echo "";
     echo "Free - $i";
     if [ ${#output_file} -ge 1 ];then
       echo $i >> $output_file
     fi
   else
     echo -n ":x - $i:";
   fi
   sleep 0.4
  done;

  echo ''
  echo $*
  echo $start_date
  date
}



_man "vu" "[vagrant] vagrant up"
_man "vh" "[vagrant] vagrant halt"
_man "vr" "[vagrant] reboot : first vagrant halt then vagrant up"
_man "vssh" "[vagrant] vagrant ssh"

# vagrant aliases
alias vu='vagrant up'
alias vh='vagrant halt'
alias vr='vh && echo "\n vh<- - - - - - - - - >vu \n" && vu'
alias vssh='vagrant ssh'

# END vagrant aliases

_man f "find with wildcards - find . -iname *${*}*"
alias f='f'
function f(){
  find -L . -iname "*${*}*"
}

_man hg "history grep"
alias hg='history | grep --color=auto'

_man "ht" "history tail"
alias ht='history | tail -n'

_man "le" "[ls] ls less"
alias le='ls -lth | less'

_man "lg" "[ls] ls grep"
alias lg='ls -lth --color=auto | grep --color=auto'
alias la='ls -lth --color=auto'

_man "lsd" "[ls] list directories"
alias lsd='ls -d */'

_man "getResume" "Get a *kind of* resume from a PHP file - list function names and classes"
alias getResume='g -n -e "^var .* =\ *" -ie "function" -ie "DEPRECATED" -ie "public" -ie "private" -ie "protected" -ie "class"'
#alias cc='clear;clear'
alias rm='rm -i'

_man "reloadbashalias" "reload your aliases"
alias reloadbashalias="source ~/.bash_aliases.sh" 

alias openbashrcfile='vi ~/.bash_aliases.sh'

alias p='pwd'

unset -f magic_cd_helper

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

function magic_cd_helper(){

  declare arguments startOfLine endOfLine list_dir TMPFILE tmp_quoted_string

  arguments=$( echo "$*" | sed 's/%/*/g'  )

  if [ $# -eq 0 ];then
    return;
  else
    if [ $(echo $arguments | grep -c '^/') -eq 0 ];then
      startOfLine='*'
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

_man "..c" \
 "[cd] c from upper directory.
Example : ~/Documents/$ ..c Ex #will go in ~/Example"
alias -- -c='_-c3'
alias '..c'='_-c1'

_man "...c" "[cd] see ..c"
alias '...c'='_-c2'

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
                /*) absolute=$linkk;;
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
Example : c D Pap # will go to ~/Document/Paperasse
Example : c -a D la a # will ADD to your c-links the path /home/me/Documents/lava/archieve/, should this match th "D la a" magic path
Example: c -r D la a # will REMOVE the c-link path
Example: c -l will list the c-links
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
    cd "${aliased}$(magic_cd_helper $*)"

  fi
  return;
}

_man "cc" "[cd] use easily c-links (type c -h for help)"
alias cc='cc'
#shortcut of c :{link} , to access your private links - 
function cc(){
  c :$1
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

alias memorySpace='du ./* -sh'
alias ziiiiaf='this is not an alias but a reminder : ifconfig, ipconfig /all for windows /// env !! screen'
alias logs="tail -f /var/log/messages /var/log/*log"
alias tc="tar cfvz"
alias tx="tar xfvz"
_man "zz" "list many available commands with their short explanation"
alias zz="ls  /usr/bin | xargs whatis | less"
#   apropos
#   df
#   which
  
alias linuxVersion="uname -a ; echo ; cat /etc/*release ; echo ; inxi -S ; cat /etc/issue ; cat /etc/issue.net ; cat /etc/lsb-release ; cat /etc/os-release ; cat /etc/issue ; cat /etc/issue.net ; cat /etc/lsb-release ; cat /etc/os-release"
 
alias ll='ls -l'
#alias la='ls -A' #alias l='ls -CF'


alias gish="git-sh"
alias tf="echo "";echo "";tail -f -n 0 -q *"
alias sshaws='ssh -i ~/.ssh/id_rsa cpain@52.28.59.240'
alias sshaws-qa='ssh -i ~/.ssh/id_rsa cpain@52.29.73.74'
alias sshaws_ttm_be_ums='ssh -i ~/.ssh/id_rsa cpain@52.28.158.58'
alias tfh="tf | head"

_man "hl" "[history] history less"
alias hl="history | less"

_man "gulw" \
  "start gulp and watch it"
alias gulw='gulp && gulp watch'

# put following line in  vi ~/.gitshrc
alias checkout='fucking gulp;git checkout'
alias stash='fucking stash;git stash'
_man "co" "checkout" \
  "[git] properly checking out by killing instances of gulp that could mess up everything"
alias co='fucking gulp;git checkout'

_man "copast" \
	  "[git] #checkout the last branch checked-out before the current"

alias copast='checkout $( history | egrep "^[ ]*[0-9]*[ ]*checkout [ ]*([A-Za-z]|-b)" | sed "s/^[ ]*[0-9]*[ ]*checkout *\(-b\)* *//g" | sed "s/\"//g" | grep -v `rev-parse --abbrev-ref HEAD` | tail -1) #checkout the last branch checked-out before the current'


_man "ch" "checkouthistory" \
  "[git] Checkout history"
alias checkouthistory='history | egrep "^[ ]*[0-9]*[ ]*checkout [ ]*([A-Za-z]|-b)" | sed "s/^[ ]*[0-9]*[ ]*checkout *//g" | grep -v `rev-parse --abbrev-ref HEAD`'
alias ch=checkouthistory;

function shawim(){
 #ssh -i ~/.ssh/id_rsa cpain@52.28.59.240 -t  'sudo sed -i.bak '\''s/^AWS_IMAGE_CLOUDFRONT.*/AWS_IMAGE_CLOUDFRONT=https:\/\/dmzr5ikm7nos4.cloudfront.net #good for test/g'\'' /srv/www/ttm_fe_portal/current/.env'
 ssh -i ~/.ssh/id_rsa cpain@52.28.59.240 -t  'sudo sed -i.bak '\''s/^AWS_IMAGE_CLOUDFRONT.*/AWS_IMAGE_CLOUDFRONT=https:\/\/s3.eu-central-1.amazonaws.com\/ttm-static-prod #good for test/g'\'' /srv/www/ttm_fe_portal/current/.env'
}

function shawimi-qa(){
 ssh -i ~/.ssh/id_rsa cpain@52.29.73.74 -t  'sudo sed -i.bak '\''s/^AWS_IMAGE_CLOUDFRONT.*/AWS_IMAGE_CLOUDFRONT=https:\/\/s3.eu-central-1.amazonaws.com\/ttm-static-prod #good for test/g'\'' /srv/www/ttm_fe_portal/current/.env'
}

alias shawim='shawim #modify the AWS IMAGE CLOUDRONT param for the test AWS server'
alias shawim-qa='shawim-qa #modify the AWS IMAGE CLOUDRONT param for the test AWS server'

_man "replaceAll"\
  "/!\ Dangerous !! Replace all string by the other accross files from current direcotry"
alias replaceAll='replaceAll'

function replaceAll(){
  read -p "Are you sure you would like to : sed -i 's/$1/$2/g'? " $yn
    case ${yn:0:1}  in
       y|Y )
         sed -i 's/$1/$2/g'; echo "done";
         break;;
       * )
         echo "Aborted"
       ;;
    esac
}

_man "hibernate"\
  "Your computer will be suspended to RAM"
alias hibernate='dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend'

alias youdl='youdl'
alias yd='youdl'

function youdl(){
  currDir=`pwd`
  musicMainDirectory='/home/z/Music/myMisc/'

  currentPlaylistDirectory=$musicMainDirectory`ls -t $musicMainDirectory | head -1`

  while getopts ":d:h:" opt; do

   case $opt in
    d)
       TMPFILE=$(mktemp)

       dialog --no-lines --menu "Choose one:" 10 50 3 \
       `find "$musicMainDirectory"* -type d -prune | sed 's/^.*\/\(.*\)$/\1 -/g'` 2>$TMPFILE
       clear
       currentPlaylistDirectory=$musicMainDirectory$(cat $TMPFILE)
       
       #if is option is canceled, stop the download
       if [ -z "$currentPlaylistDirectory" ]; then
         return
       fi

       shift

      ;;
    h|*)
      echo "usage : youdl [-d] [-h] music_url
-d gives you the option to choose the directory you want to save this music in"
      return;

      ;;
    \?)
      echo "Invalid option: -$OPTARG" 
      return;

      ;;
   esac

  done 


  echo -n $currentPlaylistDirectory
  sleep 2
  echo " ###"
  cd $currentPlaylistDirectory
  youtube-dl --restrict-filenames --no-overwrites --no-mtime -x $1 | \
        tee youdl.log | \
        grep Destination | \
        sed 's/^.*Destination: \(.*\)$/\1/g' | \
        while read filename ; do [ -f "$filename" ] && \
            { touch "$filename" ; echo "$filename" ; cleanMusicDir $filename; } ; \
        done
  cd $currDir
}



#alias id3andrename='ls | sed 's/^\(\(.*\)-\(.*\)\)\(-.*\)*$/id3 -a "\2" -t "\3" "\1"/g'
#'

#tr \~ \-  | sed 's/[^A-Za-z0-9 \&\.-]//g' | sed 's/ \+/ /g' | sed 's/\-[A-Za-z0-9]\{8,18\}\(.[a-z0-9]\{2,4\}\)/\1/g'

#ls | while read filename; do mv -n "$filename" "`echo $filename | tr \~ \-  | sed 's/[^A-Za-z0-9 \&\.-]//g' | sed 's/ \+/ /g' | sed 's/\-[A-Za-z0-9\-]\{8,18\}\(.[a-z0-9]\{2,4\}\)/\1/g'`"; done


function cleanMusicDir(){
ls | while read filename; do mv -n "$filename"  "`echo $filename |  sed 's/[ ]*\-[A-Za-z0-9_-]\{8,12\}\(\.[a-z0-9]\{2,4\}\)/\1/g' | sed 's/\+/&/g'| sed 's/ *\((\|\[\).*[Oo][Ff][Ff][Ii][Cc][Ii][Aa][Ll].*\()\|\]\)//g' |tr \_ \  | tr \~ \-  | sed 's/[^A-Za-z0-9 \&\.-]//g' | sed 's/ \+/ /g' | sed 's/ \(\..\{1,5\}\)^/\1/g' | sed 's/ *-* *[Oo][Ff][Ff][Ii][Cc][Ii][Aa][Ll] *\([Mm][Uu][Ss][Ii][Cc] \)*\([Vv][Ii][Dd][Ee][Oo]\|[lL][yY][rR][iI][cC][sS]*\).*\./\./g' | sed 's/ *[Vv][Ii][Dd][Ee][Oo] *[cC][lL][iI][pP] *//g' | sed 's/ *[lL][yY][rR][iI][cC][sS]* *//g' | sed 's/^ *//g' | sed 's/\.\.*/./g'      `" 2>&1 | grep -v 'are the same file'; done  ;
}

alias clearnMusicDir=cleanMusicDir;


alias mkdir="mkdir -pv"

alias wget="wget -c"


_man "myip"\
  "get my ip. See also getmyip"
_man "getmyip"\
  "get my ip. See also myip"
  
alias myip="curl http://ipecho.net/plain; echo"
alias getmyip='echo "====what gateway (netstat -rn | g ^0.0.0.0)";netstat -rn | 
g ^0.0.0.0;   echo "====ifconfig eth0 | g inet";ifconfig eth0 | g "inet ";  echo 
"====lynx -dump checkip.dyndns.org";lynx -dump checkip.dyndns.org'


# mogrify to optimize images for web  (sudo apt-get install imagemagick ) // alias webify="mogrify -resize 690\> *.png"

_man "extract"\
  "extract (almost) any compressed files, with (almost) any compression format"
alias extract='extract'

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

alias historystats='history_stats';
alias history_stats='history_stats';

function history_stats(){
 history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n100
}




_man "bc" "Start calculator with math support"
alias bc='bc -l'

_man "ports" "Show open ports"
alias ports='netstat -tulanp'

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'



# reboot / halt / poweroff
_man "reboot" "poweroff" "halt" "shutdown" "reboot / halt / poweroff"
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown now'


## set some other defaults ##
alias df='df -H'
alias du='du -ch'
 
alias top='atop'

_man "mcdstats" "[memcached] memecached server status"
alias mcdstats='/usr/bin/memcached-tool 10.10.27.11:11211 stats'

_man "mcdshow" "[memcached] memecached server display"
alias mcdshow='/usr/bin/memcached-tool 10.10.27.11:11211 display'

_man "flushmcd" "quickly flush out memcached server"
alias flushmcd='echo "flush_all" | nc 10.10.27.11 11211'

alias svi='sudo vi' 

_man "psg" "grep to current process snapshot"
alias psg='psg'
function psg () {
        echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
        ps aux | grep $1
}

_man "cjson" "curl json"
alias cjson='cjson' 

function cjson (){ 
  curl -s $1 | python -mjson.tool
}
