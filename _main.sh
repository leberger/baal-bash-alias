#!/bin/bash

# @author Cedric Pain
# github.com/leberger/
# linkedin.com/in/cedricpain/
# 
# The README file is very important to you. You want to read it. You want to read it so badly.


fortune

export HISTCONTROL=ignoredups; HISTSIZE=4000; HISTFILESIZE=8000

AAABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
BASH_ALIAS_FILE_DIR=$(dirname $AAABSOLUTE_PATH)

declare -a _AF #alias files

#if you wish to add your own aliases, you could either add them in
# secret.sh
# or in justforme.sh
# You can obviously add another .sh file ,
# - don't forget to make them executable though (chmod +x yourScriptFile.sh)

_AF+=('manalias.sh') # type manalias to get documentation for all the alias commands
_AF+=('general.sh')
_AF+=('justforme.sh') # scripts just for me. You (if you are not me) should delete the justforme.sh file - or empty it, and input all the things you want in it.
_AF+=('cd.sh')
_AF+=('secret.sh') # scripts that I do not need to share on git
_AF+=('youdl.sh') # my script to download easily music
_AF+=('git.sh')
_AF+=('vagrant.sh')
_AF+=('docker.sh')
_AF+=('miscdeveloperstuff.sh')


## now loop through the above array
for alias_file in "${_AF[@]}";do
  if [ -f $BASH_ALIAS_FILE_DIR/$alias_file ]; then
    . $BASH_ALIAS_FILE_DIR/$alias_file
  fi
done


#   apropos
#   df
#   which
