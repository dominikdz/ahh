#!/bin/bash - 

AHH_PATH=~/.ahh
REPO_PATH=https://github.com/dominikdz/ahh.git
VERSION="1.0.6"

function run {
    echo
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

    pushd $AHH_PATH
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
    pushd $PLUGIN_PATH
    if [ ! -e $PLUGIN_PATH/install ] ; then
	echo "no install script, try ahh ++"
	popd
	stop
    fi
    $PLUGIN_PATH/install
    popd
}

function run-plugin {
    pushd $PLUGIN_PATH
    $PLUGIN_PATH/run
    popd
}

function remove-plugin {
    $PLUGIN_PATH/remove    
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
    if [ ! -d $PLUGIN_PATH ] ; then
	echo "!$1, try ahh ++"
	stop
    fi
    cat $PLUGIN_PATH/url | xargs -IX echo "download from " X
    if [ "$2" = "++" ] ; then     
	echo "update plugin $PLUGIN_NAME"
	stop
    fi
    if [ "$2" = "--" ] ; then     
	echo "remove plugin $PLUGIN_NAME"
	stop
    fi
    if [ "$2" = "" ] ; then     
	ensure-installed-plugin $PLUGIN_NAME $PLUGIN_PATH
	run-plugin $PLUGIN_NAME $PLUGIN_PATH
	stop
    fi
fi
run
stop


