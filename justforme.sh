#!/bin/bash


#for German character, type right ctrl+ shift, let it go, then " then the letter ( a o u). For Eszett, ctrl+shift, then two times s. DONE !!!
setxkbmap -keycodes "evdev+aliases(qwerty)" -rules evdev -option terminate:ctrl_alt_bksp -option caps:super -option compose:rctrl  # -option ctrl:nocaps

alias rel=removeEmptyLines

_man "uktx" \
	 "open up vi then libreoffice to create a ukulele music sheet"

function uktx(){
  cc uk
  vi ${1}.odt
  removeEmptyLines ${1}.odt
  libreoffice ${1}.odt &
}

