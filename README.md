# SENG440_Side_Channel_Attacks

## RSA_Routine.c 
This file implements the montgomery modular multiplication algorithm pseudocode in c code. 
Currently, the values of X, Y, M, and m are hardcoded. 
The value m can be changed to reflect the number of bits.
m is set to 32 bits but to check with the example in the slides change the value of m to 5.

#### HOW TO RUN 
Compile: gcc RSA_Routine.c -o RSA_Routine   
Run: ./RSA_Routine

## RSA_Routine.cpp
This file implements the montgomery modular multiplication algorithm pseudocode in c++ code. 
Currently, the values of X, Y, M, and m are hardcoded. 

#### HOW TO RUN 
Compile: 
g++ RSA_Routine.cpp -o RSA_Routine_cpp   
Run: ./RSA_Routine_cpp
