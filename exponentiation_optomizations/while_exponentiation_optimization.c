/* 
** Unoptimized RSA Helper Functions  
*/

#include "RSA_functions.h"

// Helper function to perform modular addition
// to help with overflow
unsigned long long int montgomery_add(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    unsigned long long int sum = a + b;
    if (sum >= modulus){
        sum -= modulus;
    }
    return sum;
}

/**
* Performs Montgomery modular multiplication for 64-bit word.
* Parameters:
* - a: The first operand.
* - b: The second operand.
* - modulus: The modulus.
* Returns: The result of the multiplication.
*/
unsigned long long int montgomery_multiplication(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    unsigned long long int result = 0;
    int i;

    for (i = 0; i < 64; i++) { //modulus instead of static?
        if (b % 2 == 1) result = montgomery_add(result, a, modulus);

        a = (a << 1) % modulus;
        b = b >> 1;

        if (a >= modulus) a = montgomery_add(a, a, modulus);
    }

    return result;
}

/**
* Performs Montgomery modular reduction.
* Parameters:
* - result: The result of the modular exponentiation.
* - modulus: The modulus.
* - Y: The Montgomery factor.
* - m: The number of bits.
* Returns: The reduced result after Montgomery modular reduction.
*/
unsigned long long int montgomery_modular_reduction(unsigned long long int result, unsigned long long int modulus, unsigned long long int Y, unsigned long long int m) {
    //unsigned long long int R_inverse = compute_modular_inverse(factor, modulus); // Compute the modular inverse of the Montgomery factor R
    unsigned long long int R_inverse = 1;
    unsigned long long int montgomery_result = montgomery_multiplication(result, 1, modulus); // Convert the result to Montgomery form

    unsigned long long int reduced_result = montgomery_multiplication(montgomery_result, R_inverse, modulus); // Perform the Montgomery reduction

    return reduced_result;
}

/**
* Performs Montgomery modular exponentiation.
* Parameters:
* - base: The base value.
* - exponent: The exponent value.
* - modulus: The modulus.
* - Y: The Montgomery factor.
* - m: The number of bits.
* Returns: The result of the modular exponentiation.
*/
unsigned long long int montgomery_modular_exponentiation(unsigned long long int base, unsigned long long int exponent, unsigned long long int modulus, unsigned long long int Y, unsigned long long int m) {
    unsigned long long int result = 1;
    unsigned long long int R = 1;
    unsigned long long int baseMont = montgomery_multiplication(base, R, modulus); // R is the Montgomery factor
    unsigned long long int dummy = 0;
    register int i;

    for (i = 0; i < m; i++) {
        if (exponent & 1) {
            result = montgomery_multiplication(result, baseMont, modulus);
        }
        else {
            dummy = montgomery_multiplication(result, baseMont, modulus);
        }

        baseMont = montgomery_multiplication(baseMont, baseMont, modulus);
        exponent >>= 1;
    }

    return montgomery_modular_reduction(result, modulus, Y, m); // Montgomery reduction after exponentiation
}