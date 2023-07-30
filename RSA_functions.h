#ifndef RSA_FUNCTIONS_H
#define RSA_FUNCTIONS_H

#include <stdio.h>
#include <stdint.h>

struct returnValue {
    unsigned long long int real;
    unsigned long long int dummy;
};

struct returnValue montgomery_add(unsigned long long int a, unsigned long long int b, unsigned long long int modulus);

/** Performs Montgomery modular multiplication **/
struct returnValue montgomery_multiplication(unsigned long long int a, unsigned long long int b, unsigned long long int modulus);

/** Performs Montgomery modular reduction **/
unsigned long long int montgomery_modular_reduction(unsigned long long int result, unsigned long long int modulus, unsigned long long int m);

/** Performs Montgomery modular exponentiatio **/
struct returnValue montgomery_modular_exponentiation(unsigned long long int base, unsigned long long int exponent, unsigned long long int modulus, unsigned long long int m);

/** Performs full RSA encryption and decryption **/
void RSA_encryption_decryption(unsigned long long int base, unsigned long long int exponent, unsigned long long int N, unsigned long long int D, unsigned long long int m);

#endif