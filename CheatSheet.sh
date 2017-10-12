## This file is a set of concatated random information  I need to classify


Running a different types of containers

Next I have two simple aliases that provide shoutcuts to my most common options for running interactive and daemonized containers.

The first alias runs a daemonized container.

alias dkd="docker run -d -P"

I use it like so:

$ dkd jamtur01/ssh

This will launch a daemonized container running my jamtur01/ssh image. I could also add a command override at the end of the command also.

My second alias is very similar but runs an interactive container instead.

alias dki="docker run -t -i -P"

I use this like so:

$ dki ubuntu /bin/bash

This will launch a interactive container with a TTY running the ubuntu image and executed with the /bin/bash command.
Docker build function

Finally I have a function for interacting with the docker build command. The function allows me to skip typing the -t flag for tagging my new images.2

db() { docker build -t="$1" .; }

I use it like so:

$ db jamtur01/ssh

It assumes a Dockerfile in my current directory and then builds that file and tags the subsequent build with jamtur01/ssh.

I hope those are useful to folks and feel free to add others you use in the comments.








checkout

docker ps -aq | xargs docker stop
docker ps -aq | xargs docker rm
docker-compose up -d

docker-image

docker info
docker-machine ip default
docker ps
docker exec -it ecomercefull_app_1 bash
 
docker-compose build
docker-compose up -d

en cas de changement addr ip :
docker-machine restart default
 
installer manuellement une dependence :
docker exec -it ecomercefull_app_1 bash
yum -y install php-mbstring
/etc/init.d/php-fpm reload
 
 
ssh
ssh-add ~/.ssh/alpabb_identity
Could not open a connection to your authentication agent.
 eval `ssh-agent -s`
Agent pid 11948
$ ssh-add.exe -l
The agent has no identities.
 

installer manuellement une dependence :
docker exec -it ecomercefull_app_1 bash
yum -y install php-mbstring
/etc/init.d/php-fpm reload
 
 
ssh
ssh-add ~/.ssh/bi_identity
Could not open a connection to your authentication agent.
 eval `ssh-agent -s`
Agent pid 11948
$ ssh-add.exe -l
The agent has no identities.
 

=================
#connect to nginx
docker exec -it `docker ps | grep nginx | cut -f1 -d' '`  bash

=======
added in php-fpm/Dockerfile-71

#####################################
## NODE:
######################################

ARG INSTALL_NPM=false
RUN if [ ${INSTALL_NPM} = true ]; then \
    # Install the soap extension
        apt-get update -yqq && \
        apt-get -y install npm \
;fi




 
 
docker-compose logs elasticsearch
gulp serv
npm install --only=dev

#Tools
swagger
postman
seedentry
git flow
https://github.com/barryvdh/laravel-debugbar
http://try.airbrake.io/
apache j meter



Software quality checking
Static checkers

As a begining point we could start integrating this ones:

        PHP Code Sniffer - tokenizes PHP, JavaScript and CSS files to detect and fix violations of a defined set of coding standards.
        PHP Mess Detector -  is a multi faceted static analysis PHP Tool
        PHP Copy/Paste Detector - Copy/Paste Detector (CPD) for PHP code.
        PHP Coding Standards Fixer - fixes most issues in your code when you want to follow the PHP coding standards as defined in the PSR-1 and PSR-2 documents

Most of this tools can be integrated with the IDE or could be used on a git hook, like "post-commit".

And are install-able via composer as a project dependency or as a system global dependency.
Unit Testing

        PHPUnit
        SimpleTest

 
Continuous Integration Server:

    Sismo - for testing in local environment
    Bamboo - for testing on server
    Jenkins - is usable with Bamboo too

 
Software documentation libraries

    phpDocumentor - makes it possible to generate documentation directly from your PHP source code
    Doxygen
        can be integrated with Graphviz (a graph visualization server)
    Sami - API documentation generator

 

 
 
 
 
 
 
  563  git remote add origin-ro ssh://git@stash.b-i.com:7999/pmi_iqos/ecomerce-multistore-core---ro.git
  564  git remote -v
  565  git status
  566  git fetch origin-ro
  569  git checkout -b h

  573  git checkout origin-ro/release/1.5
  574  git checkout -b origin-ro/release/1.5

  576  git status
  577  ls
  578  vim .gitignore 
  579  git status
  580  git commit -a -m "TICKETREF-221 changement of .gitignore test"
  581  git push
  582  git push origin-ro
  583  git push --upstream origin-ro/
  584  git status
  585  git push --upstream origin-ro/bugfix/TICKETREF-221-remove-timp-de-livrare-preferat-new

 1747  branch -vv
 1748  remote -v
 1749  push
 1750  git remote -v
 1751  git push --set-upstream origin bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section
 1752  git pull
 1754  git branch --set-upstream-to=origin/bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section

 1760  git reset --hard HEAD
 
 1762  git checkout -b test-branch
 1763  git checkout --
 1764  git reset --hard origin/bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section 
 1765  git cherry-pick test-branch 
 1766  git log test-branch 
 1767  git status
 
 1769  git pull
 1770  git checkout --
 1771  git checkout bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section 
 1772  git reset --hard origin/bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section RO-235
 1773  git reset --hard origin/bugfix/TICKETREF-235-reduce-font-size-of-ecomerce-section 
 1774  status
 1775  log test-branch
 1776  status
 1777  commit -a design
 1778  add design/
 1779  status
 1780  # commit -m "TICKETREF-235 - Reduce font size of Ecom section on MyiQos page"
 1781      Edit
 1782      Comment
 1783      Assign
 1784      More
 1785      Stop Progress
 1786      Resolve Issue
 1787  commit -m "TICKETREF-235 - Reduce font size of Ecom section on MyiQos page"
 1788  status
 1789  pull
 1790  push
 1791  hl
  
  
  
  
checkout -b release/1.5  --track origin-core/release/1.5  


  
  mysql -uwebappstgu -p nwebappstg
  
  
display port > dmi


 * checkez le ticket jira

 * cliquez sur “Create Branch” dans development à droite

 * Choisissez la branche de base en fonction du ticket, ou demandez (release/1.5,6,7,8)

 * Faites votre commit

 * Mergez vers la branche development pour que vos changements se voient en dev (dev.multistorecore.salesconquest.com)

git fetch
git checkout -t -b release/1.5 origin-core/release/1.5
composer install
ecomercetb --cc
./vendor/bin/phinx migrate  # phinx migrate # 
php -f sd_updater.php

Create a hook
Clear cache, 
php sd_updater.php 
# (use sd_updater instead) http://ecomerce-multistore-core.b-i.dev/backend.php?dispatch=addon_updater.settings
   then press "Create"


When adding an add on :
./composer.json : add a line in post-install-cmd
./ app add on ... / add on name / composer.json



git merge -

mergetool

merge --abort

VPN:
pptp
vpn.b-i.com

./vendor/robmorgan/phinx/bin/phinx migrate  


SELECT * FROM `ecomerce-multistore-core---ro`.cscart_users 
WHERE user_login="admin";
-- cscart_access_restriction_blockcscart_access_restriction_reason_descriptionscscart_also_bought_productshttp://md5.gromweb.com/?md5=21232f297a57a5a743894a0e4a801fc3acscart_userscscart_users

UPDATE `ecomerce-multistore-core---ro`.cscart_users
SET salt= "", password = 'XXXXXXXXXXX' ;

SELECT * FROM `ecomerce-multistore-core---ro`.cscart_users 
WHERE accept_terms='Y' AND (status='A' OR status='active');



Pour code review :
~~~~~~~~~~~~~~~~~~
Commun :
NOPE Ansel
 Etienne Favre
 Jérôme Brügger
 Nikola Zelenkov
 Laurent Pochon
 Adrien

Back : [~efavre] [~jbrugger] [~nzelenkov] [~lpochon] [~dnistor] [~pguarnieri] [~araimbault]
 dan
 pierre garnieri

Front :
 David Giardi
 Gwenael.Gourevich

Gars PMI : Robert Diak*
 
 
$$$$ vi /etc/php.d/xdebug.ini 

zend_extension=/usr/lib64/php/modules/xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1

xdebug.idekey = "PHPSTORM"

//# xdebug.remote_handler=dbgp
//# xdebug.remote_host=127.0.0.1
xdebug.remote_port=9001
xdebug.remote_autostart=1
//#xdebug.remote_connect_back=0


If you know you want to use git reset, it still depends what you mean by "uncommit". If all you want to do is undo the act of committing, leaving everything else intact, use:
git reset --soft HEAD^

If you want to undo the act of committing and everything you have staged, but leave the work tree (your files intact):
git reset HEAD^


And if you actually want to completely undo it, throwing away all uncommitted changes, resetting everything to the previous commit (as the original question asked):
git reset --hard HEAD^








~~~~~~  tmp ~~~~~~
Debug session was finished without being paused
It may be caused by path mappings misconfiguration or not synchronized local and remote projects.  To figure out the problem check path mappings configuration for '~((.*)\.|)(? .+)\.b-i\.dev$' server at PHP|Servers or enable Break at first line in PHP scripts option (from Run menu). Do not show again



error_log

fn_print_die

fn_print_r($order_info);

Method 2:

{$var|@print_r}

Method 3:

{$var|@var_dump}



docker-machine restart default




Add on :
http://ecomerce-multistore-core.b-i.dev/backend.php?dispatch=addon_updater.settings
>Create




Log on server :
/var/www/vhosts/system/***/logs/proxy_error_log



Pour debloquer le Wifi :
sudo rfkill unblock all


 /index.php?dispatch=auth.login_form&confirm_user=[id]&hash=[hash_confirm]&hipster=
[16:37:25] Cedric Pain - BI: hipster toi meme
[16:37:26] Mat: pour le id, tu le trouve dans la DB, le dernier user créé
[16:37:47] Mat: oui je sais mais que veux-tu, des fois les variables sont chelou
[16:38:12] Mat: le hash de confirmation se trouve dans la DB confirm_email
[16:38:31] Mat: prendre celui lié au user_id





$config['db_name'] = 'ngpscstg';
$config['db_user'] = 'ngpscstgu';
$config['db_password'] = 'XXXXXXXXXp';

$
===========


 Privileges
 ==========


    fn_check_user_access(fn_get_session_user_id(), 'my_privilege');

app/schemas/permissions/admin.php


 * migration script REPLACE INTO cscart_privileges('myprivilege','section');

 * addon.xml <item> REPLACE INTO cscart_privileges('myprivilege','section');
<item for="uninstall">

<lang>

<item lang="en" id="privileges.myprivilege">SEA. User update by API</item>


/home/ced/x/docker-images/ecomerce-full/app-data/ecomerce-multistore-core/app/addons/bi_loyaltybox/schemas/permissions/admin.post.php






re order
> create another shipping method ;
> cash on delivery




0848 133133 centrale des medecins



-----------------
SELECT status, type, lang_code, description, email_subj, email_header FROM ngpscstg.cscart_status_descriptions order by lang_code ASC, status ASC, type ASC; 


= xdebug =
==========

Dans /etc/php.d/xdebug.ini
==========================

zend_extension=/usr/lib64/php/modules/xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1

xdebug.idekey = "PHPSTORM"

//# xdebug.remote_handler=dbgp
//# xdebug.remote_host=127.0.0.1
xdebug.remote_port=9001
xdebug.remote_autostart=1
//#xdebug.remote_connect_back=0

//netbeans asked that :
output_buffering = off



Dans la conf de l'extension firefox
===================================
ça doit listen to 9001

Dans l'ide
==========
mettre le port

Docker
==========
Changer info pour Faire le port forwarding 


Documentations du docker
https://stash.b-i.com/projects/PMI_IQOS/repos/docker-images/browse/ecomerce-full/docs/Mail.md







Installed on Docker machine
---------------------------
yum-utils


cd /var/www/vhosts/system/dev.multistorecore.salesconquest.com/logs/
tail -f proxy_error_log | grep -v age_gate



(pas testé, mais pour rester la dev au cas où)
reset --hard origin/development





$settings.theme_variations.my_iqos_page.my_iqos_page_reorder
  administration>stores>[click on store's name]>(more>) theme variation>(more>) my iqos
                                                        Show User's last order link

                                                        
                                                        
                                                        
Disable add-on "Catalog mode"


# grep process that runs on port 9000
netstat -plten | grep LISTEN | grep 9000

# kill what run on port 9000
sudo kill $(sudo lsof -t -i:9000)









Hi,

I only went there because of the insistence of my practice manager - even if frankly, I really didn't want to go, as I knew it couldn't help me, nor the company, but just waste my time. Now, you tell me that, in addition of wasting my time, as well as the company's time, I have also wasted more than 50 Francs ? C'est un peu fort de café.

Cordialement,


















nouveau pass pour local :
4321admin


product > delivery address > delivery mode > payment mode


find . -type f -printf '%T@ %p\n' | sort -k 1 -n | sed 's/^[^ ]* //' | grep -v "/var/" | grep less





 - -How to show the last queries executed on MySQL?

Execute SET GLOBAL general_log = 'ON';

    Take a look at the table mysql.general_log



If you want to output to the log file:



    SET GLOBAL log_output = "FILE";

    SET GLOBAL general_log_file = "/path/to/your/logfile.log"

    SET GLOBAL general_log = 'ON';



Restart MySQL to apply the changes if you edit the config, e.g. /etc/mysql/my.cnf



Now, if you wouldd like you can tail -f /var/log/mysql/mysql.log



 UPDATE cscart_addons SET status = 'D' WHERE addon = 'uddapi_promocode' ;

UPDATE cscart_addon_statuses SET status = 'D' where addon = 'uddapi_promocode' ;


to delete migration stuff
for VARIABLE in `./vendor/bin/phinx status | tr -s ' '| grep 'down' | grep -v 2016 | cut -f3 -d' '`;do rm migrations/$VARIABLE*; done    


Constant
/home/ced/x/docker-images/ecomerce-full/app-data/ecomerce-multistore-core/app/addons/shipping_data/config.php
shipping_data/config.php




use Tygh\Debugger;
fn_print_r(var_export(end(Debugger::$queries),true));
fn_print_r(var_export(end(Debugger::$queries)['query'],true));





file with many different config, including : can an add-on be disabled ?
app/addons/ngp/init.php