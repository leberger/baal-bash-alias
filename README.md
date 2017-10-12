# baal-bash-alias

_**BAAL, Bash Alias, for a smooth and better daily life on your Linux**_



@author Cedric Pain
[BAAL's Github](https://github.com/leberger/baal-bash-alias)
[Cedric Pain's Linkedin profile](https://linkedin.com/in/cedricpain/)
 
I have always liked writing bash scripts - that is why I have always had well-maintained bash aliases - to speed up and ease my daily routines

# CAUTIOUS :
The file named "justforme.sh" is actually a set of commands and aliases just for me.

*please delete the file named justforme.sh"*

# HOW TO :

add these lines at the end of your ~/.bashrc file :

```
if [ -f ~/baal-bash-alias/_main.sh ]; then
  . ~/baal-bash-alias/_main.sh
fi

```

Note that if you have custom aliases, they could be rewritten if they have the same names as the ones from these ones.


You should see a random adage given by fortune - or an error message that states "fortune: command not found" .
In that case, either install fortune from your Linux' repository, or comment out the line which states "fortune"
