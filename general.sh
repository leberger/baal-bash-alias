#!/bin/bash


_man "reloadbashalias" "reload your aliases"
alias reloadbashalias="source $BASH_ALIAS_FILE_DIR/_main.sh" 

_man "openbashrcfile" "open your bash alias file"
alias openbashrcfile="vi $BASH_ALIAS_FILE_DIR/main.sh"


_man "hibernate"\
  "Your computer will be suspended to RAM"
alias hibernate='dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend'

# reboot / halt / poweroff
_man "reboot" "poweroff" "halt" "shutdown" "reboot / halt / poweroff"
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown now'

alias rm='rm -i'
_man "rf" "force remove directory"
alias rf='rm -fR'

alias p='pwd'

alias l='ls -last --color=auto'
_man lr \
 "[ls] l reversed - earliest modified last"
alias lr='ls -lastr --color=auto'

_man "le" "[ls] ls less"
alias le='ls -lth | less'

_man "lg" "[ls] ls grep"
alias lg='ls -lth --color=auto | grep --color=auto'
alias la='ls -lth --color=auto'

_man "lsd" "[ls] list directories"
alias lsd='ls -d */'

alias gv='grep -v' 
alias gr='grep'
_man "g" \
	"[grep] grep files in current dir, and trim the result. Any arguments after the first one will exclude the directory.
Example :
g tail git
will match any line of any files in the current directory (and recursiverly) BUT not in 'git' directories"
alias g='g'

function g(){
 #if [ $# -eq 1 ];then  
 # grep -rHin -B 1 -A 1 $1 | cut -c1-130 | grep $1
 #else
  #echo "## grep - at least one invert-match"	 
  cond="$1"
  condV='--exclude-dir=.git --exclude-dir=\.idea --exclude-dir=generated' #By Default, we exclude .git directory
  condVarray=${@:-1}
  for item in "${@:2}";do
   condV="$condV --exclude-dir=$item"
  done
  echo "$condV" "$cond"
  grep -rHin -B 1 -A 1 $condV "$cond" | cut -c1-130 | grep  --color=auto  "$cond"
 #fi

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
  echo 'only available for .com , .co , .at , .cc , .de , .ca, .io'
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
   if [ `whois $i | grep -c -e "No match for " -e "No Data Found" -e "NOT FOUND" -e "Status: free" -e "Status: AVAILABLE" -e "Domain status:         available" -e "We do not have an entry in our database matching your query" -e "NOT FOUND"` -eq 1 ] ; then
     echo "";
     echo "Free - $i";
     if [ ${#output_file} -ge 1 ];then
       echo $i >> $output_file
     fi
   else
     echo -n ":x - $i:";
   fi
   sleep 1.5
  done;

  echo ''
  echo $*
  echo $start_date
  date
}

_man permutation "find all possible permutation of given letters, find all orders"

alias permutation='permutation'

function permutation(){
echo $(python - $*  << EOF
import sys, itertools;
print('\n'.join([''.join(item) for item in itertools.permutations("\n".join(sys.argv[1:]))]))
EOF
) | tr ' ' '\n' | sort | uniq 
}




_man f "find with wildcards - find . -iname *${*}*"
alias f='f'
function f(){
  find -L . -iname "*${*}*"
}

_man hg "history grep. (now you can use !2008 to repeat command #2008)"
alias hg='echo "(now you can use !2008 to repeat command #2008)";history | grep --color=auto'

_man "ht" "history tail"
alias ht='history | tail'

_man "hl" "[history] history less"
alias hl="history | less"

alias memorySpace='du ./* -sh'
alias ziiiiaf='this is not an alias but a reminder : ifconfig, ipconfig /all for windows /// env !! screen'
alias logs="tail -f /var/log/messages /var/log/*log"
alias tc="tar cfvz"
alias tx="tar xfvz"

  
alias linuxVersion="uname -a ; echo ; cat /etc/*release ; echo ; inxi -S ; cat /etc/issue ; cat /etc/issue.net ; cat /etc/lsb-release ; cat /etc/os-release ; cat /etc/issue ; cat /etc/issue.net ; cat /etc/lsb-release ; cat /etc/os-release"




alias mkdir="mkdir -pv"
_man "mkcd"\
	  "create a directory ang go into it"
mkcd() { mkdir $1;cd $1; }

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


## set some other defaults ##
alias df='df -H'
alias du='du -ch'

alias du="ncdu"
alias df="pydf"
 
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

_man "jump" "memorise the current folder path. You can then do anything you want. When you type again the command jump, it will go back to the other path. If you provide any kind of argument when ready to jump, it will unjump (not jump and reset the jump stuff)"
alias jump='jump'
function jump () {
   #added a jump function : now, instead of typing bash to navigate in directories, do something, and come back to the initial place with ctr+d, I just have to type jump once, then do whatever I want, then type jump later on"
   if [ $# -eq 1 ];then
     echo "[unjumpped !]";
     unset JUMPPPPED;
     return;
   fi
   if [ `echo "$JUMPPPPED" | wc -c ` -gt 1 ];then 
     echo "[jump to $JUMPPPPED]";
     cd $JUMPPPPED;
     unset JUMPPPPED;
   else
     JUMPPPPED=`pwd`
     echo '[ready to jump]';
   fi
}

_man "createXdir" "createWorkingDir" "createBoiler" "Creates the basic working directory structure for a new web project"
alias createXdir='createXdir'
alias createWorkingDir='createXdir'
alias createBoiler='createXdir'


function createXdir(){
  mkdir test w/public/{js/vendor,css/vendor,css/fonts,img} Documents Images Download config
}

_man "findBig" "find big files ; find files over 5 Mb"
alias findBig='find . -type f -size +50000k 2>/dev/null'


_man "removeEmptyLines" "rws" "remove empty lines from a file"
alias removeEmptyLines='sed -i.bak.6789 "/^\s*$/d"'
alias rel=removeEmptyLines

_man "week" "get the week number"
alias week='date +%V'

_man "timer" "stopwatch" "stopwatc"
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias stopwatch='timer'


# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"


# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""


#This is a function to show some system information (the KDE line will only work if KDE is installed):
myinfo () {
  printf "CPU: "
  cat /proc/cpuinfo | grep "model name" | head -1 | awk '{ for (i = 4; i <= NF; i++) printf "%s ", $i }'
  printf "\n"

  cat /etc/issue | awk '{ printf "OS: %s %s %s %s | " , $1 , $2 , $3 , $4 }'
  uname -a | awk '{ printf "Kernel: %s " , $3 }'
  uname -m | awk '{ printf "%s | " , $1 }'
  kded4 --version | grep "KDE Development Platform" | awk '{ printf "KDE: %s", $4 }'
  printf "\n"
  uptime | awk '{ printf "Uptime: %s %s %s", $3, $4, $5 }' | sed 's/,//g'
  printf "\n"
  cputemp | head -1 | awk '{ printf "%s %s %s\n", $1, $2, $3 }'
  cputemp | tail -1 | awk '{ printf "%s %s %s\n", $1, $2, $3 }'
  #cputemp | awk '{ printf "%s %s", $1 $2 }'
}

# https://superuser.com/questions/480928/is-there-any-command-like-time-but-for-memory-usage
# time {command} will output information about the command in the following format
#  may be only available with zsh on your distro, sometime time might be not a shell-built-in time but a standalone command (you could try /usr/bin/time -v uname). On macOS, use /usr/bin/time -l

TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M MB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'
