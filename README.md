# baal-bash-alias

_**BAAL, Bash Alias, for a smooth and better daily life on your Linux**_



@author Cedric Pain
github.com/leberger/baal-bash-alias
linkedin.com/in/cedricpain/
 
I have always liked writing bash scripts - that is why I have always had well-maintained bash aliases - to speed up and ease my daily routines

# CAUTIOUS :
Because of the use of setxkbmap below, your keyboard should have the right ctrl and the padlock disabled and used as a special key to write special characters . Please comment out these lines to disable it

# HOW TO :

add these lines in your ~/.bashrc file :

if [ -f ~/.bash_aliases.sh ]; then
   . ~/.bash_aliases.sh
fi



 (if you add it, just type "source ~/.bash_aliases.sh" in your console to load the file
  You should see a random adage given by fortune - or an error message that states "fortune: command not found" .
 In that case, either install fortune from your Linux' repository, or comment out the line which states "fortune"
