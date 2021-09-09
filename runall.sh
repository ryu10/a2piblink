#!/bin/sh

if [ $# -eq 0 ] || [ $1 = all ]; then
  # Blink in Basic
  cd src/basicBlink
  ./build.sh all
  # mount
  a2setvd 2 `pwd`/build/basBlink.po
  # run
  echo "RUN BASBLINK,S2,D2" | a2term

  sleep 16

  # Blink in CC65 (C)
  cd ../cBlink
  ./build.sh all
  # mount
  a2setvd 2 `pwd`/build/cblink.po
  # brun
  echo "BRUN CBLINK,S2,D2" | a2term

  sleep 16

  # BLINK in CA65 (ASM)
  cd ../asmBlink
  ./build.sh all
  # mount
  a2setvd 2 `pwd`/build/asmblink.po
  echo "BRUN ASMBLINK,S2,D2" | a2term

  sleep 16

  cd ..
  exit 0
elif [ $1 = clean ]; then
  src/basicBlink/build.sh clean
  src/cBlink/build.sh clean
  src/asmBlink/build.sh clean
  exit 0
elif [ $1 = cleanall ]; then
  src/basicBlink/build.sh cleanall
  src/cBlink/build.sh cleanall
  src/asmBlink/build.sh cleanall
  exit 0
else
  echo $0 : unknown target $1
  exit 1
fi

#make clean
