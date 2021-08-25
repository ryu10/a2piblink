# A2PiTest 

An experimantal remote development environment for Apple IIe, using Apple II Pi + Applesoft Basic + CC65.

![VSCode remote](a2pitest_demo.png)

This repo, `a2pitest`, should be placed on a Raspberry Pi (3+ or 4 recommended) connected to [Apple2Pi](https://github.com/dschmenk/apple2pi). By setting up [VSCode Remote Development](https://code.visualstudio.com/docs/remote/remote-overview) on the Raspbery Pi, you can develop Apple II software in Basic, C or Assembly language, from your modern PC (Win/Mac/Linux). Auto build with [cc65-toolchain-example](https://github.com/fo-fo/cc65-toolchain-example.git).

## Prerequisites

Install the following on a Raspberry Pi which is connected to the Apple2Pi card:

* [Apple2Pi card & software](https://github.com/dschmenk/apple2pi)
* [CC65](https://github.com/cc65/cc65)
* [AppleCommander](https://github.com/AppleCommander/AppleCommander)
* (optional) [VSCode](https://code.visualstudio.com/download) [Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)

## Quick Run
```
git clone https://github.com/ryu10/a2pitest.git
cd a2pitest
./runall.sh
./runall.sh cleanall
```

## Source Directories

* `src/basicHello` : Helloworld sample in Applesoft Basic
* `src/cHello` : Helloworld sample in  C (CC65)
* `src/asmHello` : Helloworld sample in 6502 Assembly language (CA65)
