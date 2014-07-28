#!/bin/bash - 

_B="\e[1m"
B_="\e[0m"

AHH_PATH=~/.ahh

#developer mode support
if [ ! $AHH_PATH_DEV = "" ] ; then
    echo "DEVELOPER MODE: " $AHH_PATH_DEV
    AHH_PATH=$AHH_PATH_DEV
    echo "to remove developer mode type:"
    echo "export AHH_PATH_DEV="
fi
REPO_PATH=https://github.com/dominikdz/ahh.git
VERSION="1.0.15"

function run {
    echo "run here..."
}

function drop-install {

    rm -rf ~/.ahh 2> /dev/null
    rm ~/bin/ahh  2> /dev/null
}

function install {
    mkdir ~/.ahh
    if [ ! -e ~/bin ] ; then
	mkdir ~/bin
    fi

    pushd $AHH_PATH > /dev/null
    git clone -q $REPO_PATH
    popd

    ln -s ~/.ahh/ahh/ahh.sh ~/bin/ahh

    touch $AHH_PATH/last_install
}

function stop {
    #echo "ahh..."
    exit
}

function ensure-installed {
    if [ ! -d $AHH_PATH ] ; then
	echo "hint... \"ahh ?\""
	#remove any old stuff
	drop-install
	#install
	install
    else
	echo -e "\e[1mahh!\e[0m"	
    fi
}

function list-plugins {
    echo -e "available plugins"
    ls $AHH_PATH/ahh/plugins | xargs -IX echo "-" X
}

function ensure-installed-plugin {
    pushd $PLUGIN_PATH > /dev/null
    if [ ! -e $PLUGIN_PATH/install ] ; then
	echo "no install script, try ahh ++"
	popd > /dev/null
	stop
    fi

    if [ -e $WORK_PATH/$PLUGIN_NAME ] ; then
 	:
    else
	echo "not installed"
	mkdir -p $WORK_PATH

    $PLUGIN_PATH/install $AHH_PATH $PLUGIN_NAME $PLUGIN_PATH $WORK_PATH || { echo "plugin install $PLUGIN_NAME failed"; popd > /dev/null; stop; } 

	touch $WORK_PATH/$PLUGIN_NAME
    fi

    popd > /dev/null
}

function run-plugin {
    #run plugin in current dir
    pushd . > /dev/null 
    $PLUGIN_PATH/run $AHH_PATH $PLUGIN_NAME $PLUGIN_PATH $WORK_PATH $PLUGIN_ARGS || { echo "plugin $PLUGIN_NAME failed"; popd > /dev/null; stop; } 
    popd > /dev/null
}

function remove-plugin {
    pushd $PLUGIN_PATH > /dev/null
    $PLUGIN_PATH/remove || { echo "plugin remove $PLUGIN_NAME failed"; popd > /dev/null; stop; } 
    rm -R $WORK_PATH/$PLUGIN_NAME
    popd > /dev/null
}

#check for git existence
command -v git >/dev/null 2>&1 || { echo "ahh needs git" >&2; stop; }

if [ "$1" = "++" ] ; then
    echo "ahh ++"
    drop-install
    ensure-installed
    stop
fi

if [ "$1" = "--" ] ; then
    echo "ahh --"
    drop-install
    stop
fi
if [ "$1" = "?" ] ; then
    echo -e "\e[1mahh version:" $VERSION "\e[0m"
    echo "ahh       list plugins"
    echo "ahh --    remove ahh"
    echo "ahh ++    update"
    echo "ahh ?     print this help"
    echo ""
    echo "ahh plugin_name     execute plugin"
    echo "ahh plugin_name ++  update plugin"
    echo "ahh plugin_name --  remove plugin"
    echo "ahh plugin_name ?   description of plugin"
    echo ""
    echo "what is ahh? Ahh gives you quick access to favorite tools"
    echo "what is a plugin? Plugins define way how to access tools"
    echo "ahh does not install in your system, no package manager, no sudo"
    command -v ahh >/dev/null 2>&1 || { 
	echo "--- hint ---"
	echo -e "\e[1;31mahh is not on path...\e[0m"
	echo "solutions:"
	echo "a) type ahh to install"
	echo "b) logout to refresh path"
	echo "c) if not working, execute command and return to b)"
	echo "  echo PATH=\$PATH:~/bin/ahh >> .bashrc" 
        stop; 
    }
    stop
fi

ensure-installed

if [ "$1" = "" ] ; then
    list-plugins
    stop
else
    PLUGIN_PATH=$AHH_PATH/ahh/plugins/$1
    PLUGIN_NAME=$1
    WORK_PATH=$AHH_PATH/work/$PLUGIN_NAME

    if [ ! -d $PLUGIN_PATH ] ; then
	echo "!$1, try ahh ++"
	stop
    fi
    #cat $PLUGIN_PATH/url | xargs -IX echo "download from " X
    if [ "$2" = "++" ] ; then     
	echo "update plugin $PLUGIN_NAME"
	remove-plugin
	ensure-installed-plugin 
	stop
    fi
    if [ "$2" = "--" ] ; then     
	echo "remove plugin $PLUGIN_NAME"
	remove-plugin
	stop
    fi
    if [ "$2" = "?" ]; then
	echo -e "plugin name: "$_B$PLUGIN_NAME $B_
	echo "description:"
	echo "---"
	if [ -e $PLUGIN_PATH/README ] ; then 
	    cat $PLUGIN_PATH/README
	else	    
	    echo "ask author of $PLUGIN_NAME for README file"
	fi
	echo "---"
	stop
    fi

    shift
    PLUGIN_ARGS=$@
    echo "args=" $PLUGIN_ARGS

	ensure-installed-plugin 
	run-plugin
	stop

    echo "no case???"
fi
run
stop


