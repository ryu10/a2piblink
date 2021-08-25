#!/bin/sh

if [ $# -eq 0 ] || [ $1 = all ]; then
  # HelloWorld in Basic
  cd src/basicHello
  ./build.sh all
  # mount
  a2setvd 2 `pwd`/build/basicTest.po
  # run
  echo "RUN HELLOTEST,S2,D2" | a2term

  sleep 2

  # HelloWorld in CC65 (C)
  cd ../cHello
  ./build.sh all
  # mount
  a2setvd 2 `pwd`/build/chello.po
  # brun
  echo "BRUN CHELLO,S2,D2" | a2term

  sleep 2

  # HelloWorld in CA65 (ASM)
  cd ../asmHello
  ./build.sh all
  # mount
  a2setvd 2 `pwd`/build/asmhello.po
  echo "BRUN ASMHELLO,S2,D2" | a2term

  cd ..
  exit 0
elif [ $1 = clean ]; then
  src/basicHello/build.sh clean
  src/cHello/build.sh clean
  src/asmHello/build.sh clean
  exit 0
elif [ $1 = cleanall ]; then
  src/basicHello/build.sh cleanall
  src/cHello/build.sh cleanall
  src/asmHello/build.sh cleanall
  exit 0
else
  echo $0 : unknown target $1
  exit 1
fi

#make clean
