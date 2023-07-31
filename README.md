# SENG440_Side_Channel_Attacks
This project aims to remove the ability to perform side-channel attacks on a Rivest, Shamir, and Adleman (RSA) cryptography algorithm in embedded systems by regularizing the execution time and power consumption. The implementation of the RSA algorithm in C uses modular exponentiation and Montgomery modular multiplication. To defend against these attacks, hiding and masking techniques are used.

## CODE ORGANIZATION 
copy from report when done

## ARM PROCESSOR
The processor used for this project is the real 32-bit ARM processor that is access remotely through telnet arm with the ssh @seng440.ece.uvic.ca. 
The methods for assembling and compiling with this processor are described below. The ARM processor has a RISC (Reduce Instruction Set Architecture) and it supports SIMD (NEON) intrinsics for vectorizations but this capability was not required for our project. 

## HOW TO CLONE REPO IN SSH SERVER 
1. Generate SSH key pair: On your SSH server, use the `ssh-keygen` command to generate the keys. This will create a public key (id_rsa.pub) and a private key (id_rsa) in the ~/.ssh/ directory.
2. Log in to your GitHub account and go to "Settings". Under "SSH and GPG keys", click on "New SSH key" or "Add SSH key". Provide a descriptive title for the key and paste the contents of your SSH public key (id_rsa.pub) into the designated field. Save the key
3. Test ssh connection in ssh server with: `ssh -T git@github.com`
4. Clone with: `git@github.com:michellejwatson/SENG440_Side_Channel_Attacks.git` 

## STEPS TO ASSEMBLE AND COMPILE WITH SSH
1. Open terminal, run `ssh <netlinkid>@ugls.ece.uvic.ca`
2. Go to the SENG_440_Side_Channel_Attacks repository (wherever you cloned it to)
2. Run `make exe`: this will assemble files and create an executable without neon or any optimization flags 
3. Open another terminal, run `ssh <netlinkid>@seng440.ece.uvic.ca`
4. Go to location where you ran  `make exe`
5. Run `lftp user1@arm`, sign in with password: `q6coHjd7P` and go to rsa folder using `cd rsa` or `mkdir rsa` if it doesn't exist
6. Run `put RSA_Routine.exe`
7. Run `chmod +x RSA_Routine.exe`
8. Exit lftp: run `exit`
9. Run `telnet arm` and sign in using user1 login info again 
10. Go to our rsa folder again using `cd rsa`
11. Run `./RSA_Routine.exe`


