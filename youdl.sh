#!/bin/bash

alias youdl='youdl'
alias yd='youdl'
alias youtube-dl='youtube-dl --no-mtime'

_man "youdl" "Download a video and transform it into a music, put it in the lastest modified folder located in your Music Directory. 'youdl -h' for help"

function youdl(){
  currDir=`pwd`
  
  musicMainDirectory="`realpath ~`/Music/" #this should be your base music folder, where all your music directories are
  #because my music folder is in ~/Music/myMisc/
  if [ 'z' = `whoami` ];then 
    musicMainDirectory=${musicMainDirectory}'myMisc/'
  fi

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


