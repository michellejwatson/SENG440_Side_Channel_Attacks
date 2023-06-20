# SENG440_Side_Channel_Attacks

## HOW TO CLONE IN SSH SERVER 
1. Generate SSH key pair: On your SSH server, use the `ssh-keygen` command to generate the keys. This will create a public key (id_rsa.pub) and a private key (id_rsa) in the ~/.ssh/ directory.
2. Log in to your GitHub account and go to "Settings". Under "SSH and GPG keys", click on "New SSH key" or "Add SSH key". Provide a descriptive title for the key and paste the contents of your SSH public key (id_rsa.pub) into the designated field. Save the key
3. Test ssh connection in ssh server with: `ssh -T git@github.com`
4. Clone with: `git@github.com:michellejwatson/SENG440_Side_Channel_Attacks.git` 

## HOW TO USE WITH SSH
1. Open terminal, run `ssh <netlinkid>@ugls.ece.uvic.ca`
2. Go to the SENG_440_Side_Channel_Attacks repository
2. Run `make neon`: this will compile and create executable 
3. Open another terminal, run `ssh <netlinkid>@seng440.ece.uvic.ca`
4. Go to location where you ran `make neon`
5. Run `lftp user1@arm`, sign in with password: `q6coHjd7P` and go to rsa folder using `cd rsa`
6. Run `put RSA_Routine.exe`
7. Run `chmod +x RSA_Routine.exe`
8. Exit lftp: run `exit`
9. Run `telnet arm` and sign in using user1 login info again 
10. Go to our rsa folder again using `cd rsa`
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

