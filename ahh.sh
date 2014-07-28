#!/bin/bash - 

AHH_PATH=~/.ahh
REPO_PATH=https://github.com/dominikdz/ahh.git
VERSION="1.0.0"

function run {
    echo
}

function drop-install {

    rm -rf ~/.ahh 2> /dev/null
    rm ~/bin/ahh  2> /dev/null
}

function install {
    echo "ahh++"
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
	echo "ahh!"	
    fi
}

#check for git existence
command -v git >/dev/null 2>&1 || { echo "ahh needs git" >&2; stop; }

if [ "$1" = "++" ] ; then
    echo "ahh ++"
    drop-install
    ensure-installed
fi

if [ "$1" = "--" ] ; then
    echo "ahh --"
    drop-install
    stop
fi
if [ "$1" = "?" ] ; then
    echo "ahh version:" $VERSION
    echo "ahh --    remove ahh"
    echo "ahh ?     print this help"
    command -v ahh >/dev/null 2>&1 || { echo "hint... echo ~/bin/ahh >> .bashrc" >&2; stop; }
    stop
fi
ensure-installed
run
stop


