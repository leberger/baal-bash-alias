#!/bin/bash

export HISTTIMEFORMAT="%c "


#for German character, type right ctrl+ shift, let it go, then " then the letter ( a o u). For Eszett, ctrl+shift, then two times s. DONE !!!
setxkbmap -keycodes "evdev+aliases(qwerty)" -rules evdev -option terminate:ctrl_alt_bksp -option caps:super -option compose:rctrl  # -option ctrl:nocaps

# export PS1="\[\e]0;\h:\w\a\]\[\e[0;96m\]\h \[\e[0;0m\]¤\e[0;96m\] \w\[\e[$(($??7:0));37m\]\$\[\e[0;0m\]"
export PS1="\[\033[01;18m\]\w \[\033[2;90m\]\t\[\033[0m\] "
#export PS0="\e[2;100m\u@\h\e[1m\w\e[m\e[2;100m\t\$ \e[m "
# export PS1="\e[1m\w \e[m\e[2m\t\e[m\e[2;100m\$\e[m "

_man "uktx" \
	 "open up vi then libreoffice to create a ukulele music sheet"

function uktx(){
  cc uk
  vi ${1}.odt
  removeEmptyLines ${1}.odt
  libreoffice ${1}.odt &
}

