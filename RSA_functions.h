#ifndef RSA_FUNCTIONS_H
#define RSA_FUNCTIONS_H

#include <stdio.h>
#include <stdint.h>

/** Performs RSA encryption **/
//long long int rsa_encryption(long long int plaintext, long long int exponent, long long int Y, long long int N, long long int m);

/** Performs RSA decryption **/
//long long int rsa_decryption(long long int ciphertext, long long int d, long long int Y, long long int N, long long int m);

/** Performs Montgomery modular multiplication **/
long long int montgomery_multiplication(long long int a, long long int b, long long int modulus);

/** Computes the modular inverse of a number **/
long long int compute_modular_inverse(long long int number, long long int modulus);

/** Performs Montgomery modular reduction **/
long long int montgomery_modular_reduction(long long int result, long long int modulus, long long int Y, long long int m);

/** Performs Montgomery modular exponentiatio **/
long long int montgomery_modular_exponentiation(long long int base, long long int exponent, long long int modulus, long long int Y, long long int m);

/** Checks if numbers are relatively prime **/
// int are_relatively_prime(long long int a, long long int b);

/** Finds desired value of X in the formula D = (X(P-1)(Q-1) + 1) / E **/
// long long int find_desired_x(long long int P, long long int Q, long long int E);

/** Computes private exponent using D = (X(P-1)(Q-1) + 1) / E **/
// long long int compute_private_exponent(long long int X, long long int P, long long int Q, long long int E);

#endif