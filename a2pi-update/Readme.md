# Directory: a2pi-update

RaspberryPi additional setup/tools for apple2pi.
Before using them, please make sure that the following are installed on the Raspberry Pi.

* apple2pi software
* apple2pi source tree
* AppleCommandar (ac.jar)

## a2pid.patch

This is a patch to `a2pid.c`, which makes a2pid program ignore the null command `0x00` and do not produce error logs. This prevents `syslog` and `daemon.log` from filling up the Raspi filesystem when the Apple II is turned off.

How to apply the patch: copy `a2pi.patch` to `src` directory of the `apple2pi` repo. Cd to `apple2pi/src`, and then run:
 ```
 patch < a2pid.patch
 make a2pid
 chmod a+x a2pid
 ```
Copy the newly created a2pid to the original install location (e.g. `/usr/sbin/`)

## ac.sh
A shell script command file equivalent to `java -jar ac.jar $*`.  Copy this file to where ac.jar is installed (e.g. `/usr/local/bin/ac.sh`). The path (`/usr/local/bin`) should be included in path.

## a2reset.py

With the following wiring, you can reset the Apple II from the Raspberry Pi. 

1. Pull down gpio 17 (header pin #11) to GND via a 3.3K resistor.
2. Connect gpio 17 to a NOT gate on LS04. Connect the output of the NOT to Apple II *Reset.
3. run a2reset.py