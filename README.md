ahh
===

Ahh is easy... 

* what is ahh? Ahh gives you quick access to favorite tools.
* what is a plugin? Plugins define way how to access tools. 
* What I need? linux, git, wget, bash 

What I can do with ahh?
===
```
Sometimes, when you work, you need to take last version of tool, download, install it and run.
Ahh will do it for you.
```

Getting started
===
```
Please do read Warning section - it's really important.

I assume you have Debian-like system
step 1: prepare system: sudo apt-get install bash git wget
step 2: install ahh: cd ~/;wget https://raw.githubusercontent.com/dominikdz/ahh/master/ahh.sh;bash ./ahh.sh;rm -r ./ahh.sh
step 3: logout & logon
step 4: test ahh: ahh ?
step 5: run tomcat8: ahh tomcat8 run
step 6: open link: http://127.0.0.1:8080
step 7: stop tomcat8: type CTRL+C to stop tomcat
step 8: remove tomcat8 from system: ahh tomcat8 --
step 9: remove ahh from system: ahh --
```

Warnings
===
* ahh is a new kid on the block, that means it can be buggy. please, dont' use it on production enviroments.
* ahh -- removes ahh from system, that means to use it again you will have to download it from this page
* ahh plugin_name ++/-- may remove temporary folders used by tools (eg .m2, .lein)
* please, be aware that most plugins create/override/remove respective link ~/bin/*
* all plugins assume there's no other copy of software, if you are not sure what version of software you use, try ```which plugin_name``` 
* dont' try to call ahh++ while being in ~/.ahh folder
* dont' run ahh as sudo, or root

ahh commands
===
```
ahh version: 1.0.25 
ahh       list plugins
ahh --    remove ahh
ahh ++    update
ahh ?     print this help

ahh plugin_name     execute plugin
ahh plugin_name ++  update plugin
ahh plugin_name --  remove plugin
ahh plugin_name ?   description of plugin
```

Installation
====

[run me](ahh/ahh.sh)

1. Make sure you have git and wget
2. wget download ahh.sh from this page and execute it
3. or just type in terminal: ```wget https://raw.githubusercontent.com/dominikdz/ahh/master/ahh.sh;bash ./ahh.sh;rm -r ./ahh.sh```
4. logout & login to apply path changes
5. type ```ahh ?```

How to remove ahh from my system?
====
```
ahh plugin_name --
ahh --   remove ahh
```

Where does ahh store files?
====
~/.ahh (it's hidden folder in your home directory)
