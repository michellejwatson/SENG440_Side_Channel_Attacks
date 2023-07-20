#ifndef RSA_FUNCTIONS_H
#define RSA_FUNCTIONS_H

#include <stdio.h>
#include <stdint.h>

/** Performs Montgomery modular multiplication **/
long long int montgomery_multiplication(long long int a, long long int b, long long int modulus);

/** Computes the modular inverse of a number **/
long long int compute_modular_inverse(long long int number, long long int modulus);

/** Performs Montgomery modular reduction **/
long long int montgomery_modular_reduction(long long int result, long long int modulus, long long int Y, long long int m);

/** Performs Montgomery modular exponentiatio **/
long long int montgomery_modular_exponentiation(long long int base, long long int exponent, long long int modulus, long long int Y, long long int m);

#endif