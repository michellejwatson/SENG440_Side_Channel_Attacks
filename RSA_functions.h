#ifndef RSA_FUNCTIONS_H
#define RSA_FUNCTIONS_H

#include <stdio.h>
#include <stdint.h>

/** Performs RSA encryption **/
uint64_t rsa_encryption(uint64_t plaintext, uint64_t exponent, uint64_t Y, uint64_t N, uint64_t m);

/** Performs RSA decryption **/
uint64_t rsa_decryption(uint64_t ciphertext, uint64_t d, uint64_t Y, uint64_t N, uint64_t m);

/** Performs Montgomery modular multiplication **/
uint64_t montgomery_multiplication(uint64_t a, uint64_t b, uint64_t modulus);

/** Computes the modular inverse of a number **/
uint64_t compute_modular_inverse(uint64_t number, uint64_t modulus);

/** Performs Montgomery modular reduction **/
uint64_t montgomery_modular_reduction(uint64_t result, uint64_t modulus, uint64_t Y, uint64_t m);

/** Performs Montgomery modular exponentiatio **/
uint64_t montgomery_modular_exponentiation(uint64_t base, uint64_t exponent, uint64_t modulus, uint64_t Y, uint64_t m);

/** Checks if numbers are relatively prime **/
int are_relatively_prime(uint64_t a, uint64_t b);

/** Finds desired value of X in the formula D = (X(P-1)(Q-1) + 1) / E **/
uint64_t find_desired_x(uint64_t P, uint64_t Q, uint64_t E);

/** Computes private exponent using D = (X(P-1)(Q-1) + 1) / E **/
uint64_t compute_private_exponent(uint64_t X, uint64_t P, uint64_t Q, uint64_t E);

#endif