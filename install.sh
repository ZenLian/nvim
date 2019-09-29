#!/bin/bash


basepath=$(cd `dirname $0`; pwd)
targetpath=~/.config/nvim

if [ -e ${targetpath} ]; then
    curTime=`date +%Y%m%d%H%M%S`
    mv ${targetpath} ${targetpath}.${curTime} || exit -1
fi

ln -s ${basepath} ${targetpath} \
	|| exit -1
