#!/bin/bash

alias gish="git-sh"


_man "gulw" \
  "start gulp and watch it"
alias gulw='gulp && gulp watch'

# put following line in  vi ~/.gitshrc
alias checkout='fucking gulp;git checkout'
alias stash='fucking stash;git stash'
_man "co" "checkout" \
  "[git] properly checking out by killing instances of gulp that could mess up everything"
alias co='checkout'

_man "copast" \
	  "[git] #checkout the last branch checked-out before the current"

alias copast='checkout $( history | egrep "^[ ]*[0-9]*[ ]*checkout [ ]*([A-Za-z]|-b)" | sed "s/^[ ]*[0-9]*[ ]*checkout *\(-b\)* *//g" | sed "s/\"//g" | grep -v `rev-parse --abbrev-ref HEAD` | tail -1) #checkout the last branch checked-out before the current'


_man "ch" "checkouthistory" \
  "[git] Checkout history"
alias checkouthistory='history | egrep "^[ ]*[0-9]*[ ]*checkout [ ]*([A-Za-z]|-b)" | sed "s/^[ ]*[0-9]*[ ]*checkout *//g" | grep -v `git rev-parse --abbrev-ref HEAD`'
alias ch=checkouthistory;
