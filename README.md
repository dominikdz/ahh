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
* ahh plugin_name ++/-- may remove plugin folders, please, be aware that most plugins override/remove respective link 
  from ~/bin/something and ~/.something
* all plugins assume there's no other copy of software, if you are not sure what version of software you use, try ```which plugin_name``` 

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
2. wget downlad ahh.sh from this page and execute it
3. or ```wget https://raw.githubusercontent.com/dominikdz/ahh/master/ahh.sh | bash; rm ./ahh.sh```
4. logout & login to apply path changes
5. type ```ahh ?```

How to remove ahh from my system?
====
```
ahh plugin_name --
ahh --   remove ahh
```
