# SENG440_Side_Channel_Attacks

## HOW TO USE WITH SSH
Login on any lab machine in the ECE Undergraduate Lab using your netlink ID and password:
$ ``ssh <netlinkid>@ugls.ece.uvic.ca``       

Copy the file to the ssh server or git clone this repository to folder in lab machine 

The compiler is available under "/opt/arm/4.3.2/bin/" directory. To compile RSA_Routine.c:

$ ``arm-linux-gcc -static -o RSA_Routine.exe RSA_Routine.c``       

The compiler supports SIMD (NEON) intrinsics. To use SIMD intrinsince, add NEON header to source code:

$ ``#include "arm_neon.h"``       

To compile with NEON intrinsics:

$ ``/opt/arm/4.3.2/bin/arm-linux-gcc -mfloat-abi=softfp -mfpu=neon -static -O3 -S RSA_Routine.c``          

To access the Real ARM Machine you first need to ssh into seng440.ece.uvic.ca using your unix/netlink password, and then telnet into the ARM Machine:

$ ``ssh <netlinkid>@seng440.ece.uvic.ca``            
$ ``telnet arm``       

There are four users defined (user1, user2, user3, user4). The password for these four users on the ARM Machine is q6coHjd7P

To execute the file.exe file, just type:

$ chmod +x RSA_Routine.exe

$ ``./RSA_Routine.exe``        

To upload the executable file previously generated you can use lftp command:

$ ``lftp user1@arm``          

## RSA_Routine.c 
This file implements the montgomery modular multiplication algorithm pseudocode in c code. 
Currently, the values of X, Y, M, and m are hardcoded. 
The value m can be changed to reflect the number of bits.
m is set to 32 bits but to check with the example in the slides change the value of m to 5.

#### HOW TO RUN LOCALLY
Compile: ``gcc RSA_Routine.c -o RSA_Routine``     
Run: ``./RSA_Routine``         

## RSA_Routine.cpp
This file implements the montgomery modular multiplication algorithm pseudocode in c++ code. 
Currently, the values of X, Y, M, and m are hardcoded. 

#### HOW TO RUN LOCALLY
Compile: ``g++ RSA_Routine.cpp -o RSA_Routine_cpp``      
Run: ``./RSA_Routine_cpp``         

