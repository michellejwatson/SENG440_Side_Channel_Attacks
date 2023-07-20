/* 
** Unoptomized RSA Routine for 64-bit key
** No implementation for hiding or masking of execution time / power consumption 
*/

//#include "arm_neon.h"
#include <stdio.h>
#include <stdint.h>
#include <time.h>

/** 
 * Performs Montgomery modular multiplication.
 * Parameters:
 *   - a: The first operand.
 *   - b: The second operand.
 *   - modulus: The modulus.
 * Returns: The result of the multiplication.
 */
int64_t montgomery_multiplication(int64_t a, int64_t b, int64_t modulus) {
    int64_t result = 0;
    int64_t factor = (1ULL << 32) % modulus;
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
int64_t compute_modular_inverse(int64_t number, int64_t modulus) {
    int64_t t = 0, new_t = 1;
    int64_t r = modulus, new_r = number;

    while (new_r != 0) {
        int64_t quotient = r / new_r;

        int64_t temp_t = new_t;
        new_t = t - quotient * new_t;
        t = temp_t;

        int64_t temp_r = new_r;
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
int64_t montgomery_modular_reduction(int64_t result, int64_t modulus, int64_t Y, int64_t m) {
    int64_t factor = (1ULL << m) % modulus;
    int64_t R_inverse = compute_modular_inverse(factor, modulus); // Compute the modular inverse of the Montgomery factor R

    int64_t montgomery_result = montgomery_multiplication(result, 1, modulus); // Convert the result to Montgomery form

    int64_t reduced_result = montgomery_multiplication(montgomery_result, R_inverse, modulus); // Perform the Montgomery reduction

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
int64_t montgomery_modular_exponentiation(int64_t base, int64_t exponent, int64_t modulus, int64_t Y, int64_t m) {
    int64_t result = 1;
    int64_t R = (1ULL << m) % modulus;
    int64_t baseMont = montgomery_multiplication(base, R, modulus);  // R is the Montgomery factor

    while (exponent > 0) {
        if (exponent & 1) {
            result = montgomery_multiplication(result, baseMont, modulus);
        }

        baseMont = montgomery_multiplication(baseMont, baseMont, modulus);
        exponent >>= 1;
    }

    return montgomery_modular_reduction(result, modulus, Y, m);  // Montgomery reduction after exponentiation
}

int main() {
    /** initial test **/
    int64_t P = 61; // Prime Number P
    int64_t Q = 53; // Prime Number Q
    int64_t N = P * Q; // Modulus N
    int64_t phi = (P - 1) * (Q - 1); // Euler's totient function value
    int64_t E = 17; // Public exponent
    int64_t plaintext = 440;
    int64_t m = 64; // 64 bits
    int64_t D;

    // Check 1 < E < PQ
    if (E <= 1 || E >= N) {
        printf("Invalid public exponent 'E'. It must satisfy 1 < E < PQ.\n");
        return -1;
    }

    // Check that plaintext is < PQ
    if (plaintext >= N) {
        printf("Invalid plaintext value. It must satisfy plaintext < PQ.\n");
        return -1;
    }

    // Calculate the private exponent d using the formula D = (X(P-1)(Q-1) + 1) / E
    int64_t X = 1;
    while ((X * (P - 1) * (Q - 1) + 1) % E != 0) {
        X++;
    }

    D = ((X * phi) + 1) / E;

    // Public Key: (E, PQ)
    // Private Key: (D, PQ)

    // Compute R = (2^m) % N
    int64_t R = 1;
    int i;
    for (i = 0; i < m; i++) {
        R = (R << 1) % N;
    }

    // Compute Y = (R^2) % N
    int64_t Y = (R * R) % N;

    // Perform RSA encryption
    clock_t start_encrypt = clock();

    int64_t ciphertext = montgomery_modular_exponentiation(plaintext, E, N, Y, m);

    clock_t end_encrypt = clock();
    double total_time_encrypt = (double)(end_encrypt - start_encrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Encryption **********\n");
    printf("RSA Encryption Ciphertext: %llu\n", ciphertext);
    printf("Time to execute encrypt: %.7f\n", total_time_encrypt);

    // Perform RSA decryption
    clock_t start_decrypt = clock();

    int64_t decrypted = montgomery_modular_exponentiation(ciphertext, D, N, Y, m);

    clock_t end_decrypt = clock();
    double total_time_decrypt = (double)(end_decrypt - start_decrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Decryption **********\n");
    printf("Decrypted: %llu\n", decrypted);
    printf("Time to execute decrypt: %.7f\n", total_time_decrypt);

    return 0;
}
