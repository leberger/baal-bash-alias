#!/bin/bash

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