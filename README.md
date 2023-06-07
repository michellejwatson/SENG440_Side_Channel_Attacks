# SENG440_Side_Channel_Attacks

## HOW TO USE WITH SSH
1. Open terminal, run `shh <netlinkid>@ugls.ece.uvic.ca`
2. Run `make neon`: this will compile and create executable 
3. Open another terminal, run ssh <netlinkid>@seng440.ece.uvic.ca
4. Go to where make made the executable (where is this?)
5. Run lftp user1@arm : sign in with password: q6coHjd7P and go to <our_folder>
6. Run `put RSA_Routine.exe`
7. Run `chmod +x RSA_Routine.exe`
8. Exit lftp: i think just command `exit`
9. Run `telnet arm` and sign in 
10. Go to /<our_folder> again using `cd`
11. Run `./RSA_Routine.exe`          

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

