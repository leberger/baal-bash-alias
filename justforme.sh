#!/bin/bash


#for German character, type right ctrl+ shift, let it go, then " then the letter ( a o u). For Eszett, ctrl+shift, then two times s. DONE !!!
setxkbmap -keycodes "evdev+aliases(qwerty)" -rules evdev -option terminate:ctrl_alt_bksp -option caps:super -option compose:rctrl  # -option ctrl:nocaps


