/* 
** Unoptimized RSA Helper Functions  
*/

#include "RSA_functions.h"

/** 
 * Performs Montgomery modular multiplication.
 * Parameters:
 *   - a: The first operand.
 *   - b: The second operand.
 *   - modulus: The modulus.
 * Returns: The result of the multiplication.
 */
uint32_t montgomery_multiplication(uint32_t a, uint32_t b, uint32_t modulus) {
    uint32_t result = 0;
    uint32_t factor = (1LL << 32) % modulus;
    int i;

    for (i = 0; i < 32; i++) {
        if (b % 2 == 1)
            result = (result + a) % modulus;

        a = (a << 1) % modulus;
        b = b >> 1;

        if (a >= modulus)
            a = (a - modulus) % modulus;
    }

    return result;
}

/** 
 * Performs Montgomery modular reduction.
 * Parameters:
 *   - result: The result of the modular exponentiation.
 *   - modulus: The modulus.
 *   - Y: The Montgomery factor.
 *   - m: The number of bits.
 * Returns: The reduced result after Montgomery modular reduction.
 */
uint32_t montgomery_modular_reduction(uint32_t result, uint32_t modulus, uint32_t Y, uint32_t m) {
    uint32_t factor = (1ULL << m) % modulus;
    //uint32_t R_inverse = compute_modular_inverse(factor, modulus); // Compute the modular inverse of the Montgomery factor R
    uint32_t R_inverse = 1;
    uint32_t montgomery_result = montgomery_multiplication(result, 1, modulus); // Convert the result to Montgomery form

    uint32_t reduced_result = montgomery_multiplication(montgomery_result, R_inverse, modulus); // Perform the Montgomery reduction

    return reduced_result;
}

/**
 * Performs Montgomery modular exponentiation.
 * Parameters:
 *   - base: The base value.
 *   - exponent: The exponent value.
 *   - modulus: The modulus.
 *   - Y: The Montgomery factor.
 *   - m: The number of bits.
 * Returns: The result of the modular exponentiation.
 */
uint32_t montgomery_modular_exponentiation(uint32_t base, uint32_t exponent, uint32_t modulus, uint32_t Y, uint32_t m) {
    uint32_t result = 1;
    //uint32_t R = (1ULL << m) % modulus;
    uint32_t R = 1;
    uint32_t baseMont = montgomery_multiplication(base, R, modulus);  // R is the Montgomery factor

    while (exponent > 0) {
        if (exponent & 1) {
            result = montgomery_multiplication(result, baseMont, modulus);
        }

        baseMont = montgomery_multiplication(baseMont, baseMont, modulus);
        exponent >>= 1;
    }

    return montgomery_modular_reduction(result, modulus, Y, m);  // Montgomery reduction after exponentiation
}