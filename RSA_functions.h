#ifndef RSA_FUNCTIONS_H
#define RSA_FUNCTIONS_H

#include <stdio.h>
#include <stdint.h>

/** Performs Montgomery modular multiplication **/
uint32_t montgomery_multiplication(uint32_t a, uint32_t b, uint32_t modulus);

/** Performs Montgomery modular reduction **/
uint32_t montgomery_modular_reduction(uint32_t result, uint32_t modulus, uint32_t Y, uint32_t m);

/** Performs Montgomery modular exponentiatio **/
uint32_t montgomery_modular_exponentiation(uint32_t base, uint32_t exponent, uint32_t modulus, uint32_t Y, uint32_t m);

#endif