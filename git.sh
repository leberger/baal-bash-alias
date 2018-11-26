#!/bin/bash

alias gish="git-sh"


_man "gulw" \
  "start gulp and watch it"
alias gulw='gulp && gulp watch'

alias checkout='fucking gulp;git checkout'
alias stash='fucking stash;git stash'
_man "co" "checkout" \
  "[git] properly checking out by killing instances of gulp that could mess up everything"
alias co='checkout'

_man "copast" \
	  "[git] #checkout the last branch checked-out before the current"

alias copast='echo "make sure the egrep takes into account checkout AND co ; make sure history works, even if we have some weird histvars or so for history (if it displays dates,...)"; #checkout $( history | egrep "^[ ]*[0-9]*[ ]*(checkout|co) [ ]*([A-Za-z]|-b)" | sed "s/^[ ]*[0-9]*[ ]*checkout *\(-b\)* *//g" | sed "s/\"//g" | grep -v `rev-parse --abbrev-ref HEAD` | tail -1) #checkout the last branch checked-out before the current'


_man "ch" "checkouthistory" \
  "[git] Checkout history"
alias checkouthistory='history | egrep "^[ ]*[0-9]*[ ]*checkout [ ]*([A-Za-z]|-b)" | sed "s/^[ ]*[0-9]*[ ]*checkout *//g" | grep -v `git rev-parse --abbrev-ref HEAD`'
alias ch=checkouthistory;

# Git Aliases
# alias gs='git status '
# alias ga='git add '
# alias gb='git branch '
# alias gam='git commit --amend '
# alias gc='git commit'
# alias gd='git diff'
# alias gt='git checkout '
# alias gk='gitk --all&'
# alias gx='gitx --all'
# alias pull='git pull'
# alias pullo='git pull origin'
# alias push='git push'
# alias pusho='git push origin'
# alias pushf='git push -f origin'
# alias pushu='git push -u origin'
# alias merge='git merge'
# alias got='git '
# alias get='git '
# alias clone='git clone'
# alias add='git add'

_man "glistlastci" \
  "[git] list files changed in last commit"
alias glistlastci='git diff-tree --no-commit-id --name-only -r  $(l | head -1 | cut -f1 -d" ")'

