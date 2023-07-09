#ifndef RSA_FUNCTIONS_H
#define RSA_FUNCTIONS_H
/* 
** Unoptimized Montgomery Multiplication Function  
*/

#include <stdio.h>
#include <stdint.h>

/** encryption **/
uint64_t rsa_encryption(uint64_t plaintext, uint64_t exponent, uint64_t Y, uint64_t N, uint64_t m);

/** decryption **/
uint64_t rsa_decryption(uint64_t ciphertext, uint64_t d, uint64_t Y, uint64_t N, uint64_t m);

/** unoptomized modular exponentiation function **/
uint64_t modular_exponentiation(uint64_t base, uint64_t exponent, uint64_t modulus);

/** unoptomized montgomery multiplication function **/
uint64_t montgomery_modular_multiplication(uint64_t T, uint64_t X, uint64_t Y, uint64_t M, uint64_t m);

/** unoptomized check if numbers are relatively prime **/
int are_relatively_prime(uint64_t a, uint64_t b);

/** find desired value of X in the formula D = (X(P-1)(Q-1) + 1) / E **/
uint64_t find_desired_x(uint64_t P, uint64_t Q, uint64_t E);

/** compute private exponent using D = (X(P-1)(Q-1) + 1) / E **/
uint64_t compute_private_exponent(uint64_t X, uint64_t P, uint64_t Q, uint64_t E);

#endif