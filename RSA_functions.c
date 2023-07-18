/* 
** Unoptimized RSA Helper Functions  
*/

#include "RSA_functions.h"


/** 
 * Performs RSA encryption.
 * Parameters:
 *   - plaintext: The plaintext message to be encrypted.
 *   - exponent: The public exponent.
 *   - Y: The Montgomery factor.
 *   - N: The modulus.
 *   - m: The number of bits.
 * Returns: The encrypted ciphertext.
 */
// long long int rsa_encryption(long long int plaintext, long long int exponent, long long int Y, long long int N, long long int m){
//     return montgomery_modular_exponentiation(plaintext, exponent, N, Y, m);
// }

/** 
 * Performs RSA decryption.
 * Parameters:
 *   - ciphertext: The ciphertext to be decrypted.
 *   - d: The private exponent.
 *   - Y: The Montgomery factor.
 *   - N: The modulus.
 *   - m: The number of bits.
 * Returns: The decrypted plaintext.
 */
// long long int rsa_decryption(long long int ciphertext, long long int d, long long int Y, long long int N, long long int m){
//     return montgomery_modular_exponentiation(ciphertext, d, N, Y, m);
// }

/** 
 * Performs Montgomery modular multiplication.
 * Parameters:
 *   - a: The first operand.
 *   - b: The second operand.
 *   - modulus: The modulus.
 * Returns: The result of the multiplication.
 */
long long int montgomery_multiplication(long long int a, long long int b, long long int modulus) {
    long long int result = 0;
    long long int factor = (1ULL << 32) % modulus;
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
 * Computes the modular inverse of a number.
 * Parameters:
 *   - number: The number for which the inverse is computed.
 *   - modulus: The modulus.
 * Returns: The modular inverse of the number, or 0 if it does not exist.
 */
long long int compute_modular_inverse(long long int number, long long int modulus) {
    int64_t t = 0, new_t = 1;
    long long int r = modulus, new_r = number;

    while (new_r != 0) {
        long long int quotient = r / new_r;

        long long int temp_t = new_t;
        new_t = t - quotient * new_t;
        t = temp_t;

        long long int temp_r = new_r;
        new_r = r - quotient * new_r;
        r = temp_r;
    }

    if (r > 1) {
        // The number is not invertible (not relatively prime to modulus)
        return 0;
    }

    if (t < 0) {
        t += modulus;
    }

    return t;
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
long long int montgomery_modular_reduction(long long int result, long long int modulus, long long int Y, long long int m) {
    long long int factor = (1ULL << m) % modulus;
    long long int R_inverse = compute_modular_inverse(factor, modulus); // Compute the modular inverse of the Montgomery factor R

    long long int montgomery_result = montgomery_multiplication(result, 1, modulus); // Convert the result to Montgomery form

    long long int reduced_result = montgomery_multiplication(montgomery_result, R_inverse, modulus); // Perform the Montgomery reduction

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
long long int montgomery_modular_exponentiation(long long int base, long long int exponent, long long int modulus, long long int Y, long long int m) {
    long long int result = 1;
    long long int R = (1ULL << m) % modulus;
    long long int baseMont = montgomery_multiplication(base, R, modulus);  // R is the Montgomery factor

    while (exponent > 0) {
        if (exponent & 1) {
            result = montgomery_multiplication(result, baseMont, modulus);
        }

        baseMont = montgomery_multiplication(baseMont, baseMont, modulus);
        exponent >>= 1;
    }

    return montgomery_modular_reduction(result, modulus, Y, m);  // Montgomery reduction after exponentiation
}

/** 
 * Checks if two integers are relatively prime.
 * Parameters:
 *   - a: The first integer.
 *   - b: The second integer.
 * Returns: 1 if the integers are relatively prime, 0 otherwise.
 */
int are_relatively_prime(long long int a, long long int b) {
    long long int temp;
    while (b != 0) {
        temp = b;
        b = a % b;
        a = temp;
    }
    return a == 1;
}

/** 
 * Finds the desired value of X in the formula D = (X(P-1)(Q-1) + 1) / E.
 * Parameters:
 *   - P: The prime number P.
 *   - Q: The prime number Q.
 *   - E: The public exponent.
 * Returns: The desired value of X.
 */
long long int find_desired_x(long long int P, long long int Q, long long int E) {
    long long int X = 1;
    while ((X * (P - 1) * (Q - 1) + 1) % E != 0) {
        X++;
    }
    return X;
}

/** 
 * Computes the private exponent using D = (X(P-1)(Q-1) + 1) / E.
 * Parameters:
 *   - X: The desired value X.
 *   - P: The prime number P.
 *   - Q: The prime number Q.
 *   - E: The public exponent.
 * Returns: The private exponent.
 */
long long int compute_private_exponent(long long int X, long long int P, long long int Q, long long int E) {
    long long int phi = (P - 1) * (Q - 1);
    long long int D = ((X * phi) + 1) / E;
    return D;
}
