IMPORTANT NOTE: The modified ZMap provided here has *only* been tested with the provided run scripts. In particular, the packet retransmission modifications are intended for single-threaded ZMap scan only. 

* Running this software in any other way might have unintended possibly adverse effects. *

To get the ZMap modifications code, contact s.bano@ucl.ac.uk

================
Only the first time do the following to set up zmap dependencies
================

Note: ZMap with our modifications will only be provided on request.

- Install dependencies:
        Debian or Ubuntu: sudo apt-get install build-essential cmake libgmp3-dev libpcap-dev gengetopt byacc flex
        apt-get install libunistring-dev

	Red Hat Enterprise Linux or CentOS: sudo yum install cmake gmp gmp-devel libpcap-devel gengetopt byacc flex

	Mac OS: brew install cmake gmp gengetopt json-c byacc libdnet or sudo port install gmp libdnet byacc flex gengetopt cmake


=========
For each zmap folder (<zmap_folder>), separately install the instance as follows
=========

- cd into <zmap_folder>
- remove CMakeCache.txt
- In Makefile and CMake generated file (cmake_install.cmake, CPackConfig.cmake, CPackSourceConfig.cmake), fix zmap dir path by setting it to <zmap_folder>
- cmake -DWITH_JSON=OFF(if you want support, then do: sudo apt-get install libjson-c-dev)
- cmake -DENABLE_DEVELOPMENT=OFF
- make
- then use <zmap_folder>/src/zmap
