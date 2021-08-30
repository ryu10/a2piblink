#!/usr/bin/bash

set -e

# cd to scriptDir
pushd . &> /dev/null
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd ${scriptDir}

# project-specific params
buildDir=build
srcDir=src
srcFile=BlinkTest.bas
exeFile=BLINKTEST
diskImage=blinkTest.po

# params
acCmd=ac.sh
diskPath=${buildDir}/${diskImage}
srcPath=${srcDir}/${srcFile}


# subtasks as functions
function mk_build_dir(){
  if [ ! -d ${buildDir} ]; then
      mkdir -p ${buildDir}
  fi
}

function build(){
  mk_build_dir
  #cmake --build ${buildDir} 
}

function clean(){
  if [ -d ${buildDir} ]; then
    rm -rf ${diskPath}
  else
    echo Directory ${buildDir} does not exist. Do nothing.
  fi
}

function writeDisk(){
  ${acCmd} -d ${diskPath} ${exeFile}
# for BASIC program
  ${acCmd} -bas ${diskPath} ${exeFile} < ${srcPath} 
}

function disk(){
  if [ ! -e ${diskPath} ]; then # no *.po image file, create one
    ${acCmd} -pro140 ${diskPath} NONAME
    writeDisk
  elif [ ${srcPath} -nt ${diskPath} ]; then # .po exists, and new exe was created
    writeDisk
  else
    echo ${diskImage} is newer than ${exeFile}. ${diskImage} is not updated. 
  fi
}

#
# other funcs come here
#

function all(){
  build
  disk
}

# main

# special case : no args at all
if [ $# -eq 0 ]; then
  all
  popd &> /dev/null # from scriptdir
  exit 0
fi

# swtich loop
case $1 in
  all)
    all
    ;;
  build)
    build
    ;;
  disk)
    build
    disk
    ;;
  clean)
    clean
    ;;
  cleanall)
    clean
    if [ -d ${buildDir} ]; then
      rm -rf ${buildDir}
      echo $0 : Removed directory ${buildDir}.
    fi
    ;;
  *)
    echo $0 : unknown target $1
    exit 1
    ;;
esac

popd &> /dev/null # from scriptDir