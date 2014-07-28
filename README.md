ahh
===

Ahh is easy... 

* what is ahh? Ahh gives you quick access to favorite tools.
* what is a plugin? Plugins define way how to access tools. 
* What I need? linux, git, bash 


Warnings
===
* ahh is a new kid on the block, that means it can be buggy. please, dont' use it on production enviroments.
* ahh -- removes ahh from system, that means to use it again you will have to download it from this page
* ahh plugin_name ++/-- may remove temporary folders used by tools (eg .m2, .lein)
* please, be aware that most plugins create/override/remove respective link ~/bin/*
* all plugins assume there's no other copy of software, if you are not sure what version of software you use, try ```which plugin_name``` 
* dont' try to call ahh++ while being in ~/.ahh folder

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
