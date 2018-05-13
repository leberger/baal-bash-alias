# baal-bash-alias

_**BAAL, Bash Alias, for a smooth and better daily life on your Linux**_



@author [Cedric Pain](https://linkedin.com/in/cedricpain/)

[BAAL's Github](https://github.com/leberger/baal-bash-alias)


# WHY

I have always liked writing bash scripts - that is why I have always had well-maintained bash aliases - to speed up and ease my daily routines.
I am now happy to share them with you ! Don't hesitate to get in touch

# FEATURES

To get the full list of added "aliases", type manalias in your comman line

`manlias`

There are numerous features :
- Some for your daily life (the one I use the most are *c* - a magic 'cd' function ; *l* ; *f* - a easy to use quick find alias ; *youdl* - download a music from a youtube link ; *g* - find a word into any files from current directory)
- Some others are specific for development (*tf* - print the line added to a log, like error logs ; *gish* ; *copast* - in git, to checkout the last branch you were into  ; ; *checkout* (or co) - properly checkout, killing any gulp process)

# CAUTIOUS :
The file named "justforme.sh" is actually a set of commands and aliases just for me.

*please delete the file named justforme.sh*

# HOW TO :

add these lines at the end of your ~/.bashrc file :

```
if [ -f ~/baal-bash-alias/_main.sh ]; then
  . ~/baal-bash-alias/_main.sh
fi

```

Note that if you have custom aliases, they could be rewritten if they have the same names as the ones from these ones.


