/*
** Unoptomized RSA Routine for 64-bit key
** No implementation for hiding or masking of execution time / power consumption
*/

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>
#include "RSA_functions.h"
#include "tests.h"

/**
* Generates private exponent for decryption of message.
* Parameters:
* - prime_1: prime number 1
* - prime_2: prime number 2, not the same as prime_1
* - public_exponent: the public exponent used for encryption
* Returns: a private exponent for decrypting associated messages.
*/
unsigned long long int generate_private_exponent(unsigned long long int prime_1, unsigned long long int prime_2, unsigned long long int public_exponent){

    unsigned long long int phi = (prime_1 - 1) * (prime_2 - 1); // Euler's totient function value
    unsigned long long int private_exponent;

    // Calculate the private exponent d using the formula D = (X(P-1)(Q-1) + 1) / E
    unsigned long long int X = 1;
    while ((X * (prime_1 - 1) * (prime_2 - 1) + 1) % public_exponent != 0) {
        X++;
    }

    private_exponent = ((X * phi) + 1) / public_exponent;
    return private_exponent;
}

// Dead code
// /**
// * Calculates montgomery factor needed for encryption/decryption
// * Parameters:
// * - N: modulus
// * - m: number of bits
// * Returns: associated Montgomery Factor.
// */
// unsigned long long int calculate_montgomery_factor(unsigned long long int N, unsigned long long int m){

//     // Compute R = (2^m) % N
//     unsigned long long int R = 1;
//     int i;
//     for (i = 0; i < m; i++) {
//         R = (R << 1) % N;
//     }

//     // Compute Montgomery Factor: Y = (R^2) % N
//     unsigned long long int Y = (R * R) % N;
//     return Y;
// }

int main() {
    /** initial test **/
    unsigned long long int P = 61; // Prime Number P
    unsigned long long int Q = 53; // Prime Number Q
    unsigned long long int N = P * Q; // Modulus N
    unsigned long long int E = 17; // Public exponent
    unsigned long long int plaintext = 440;
    unsigned long long int m = 64; // 64 bits
    unsigned long long int D;
    unsigned long long int montgomery_factor;

    // Public Key: (E, PQ)
    // Private Key: (D, PQ)

    // Perform checks to ensure valid variables
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

    // Calculate required values
    D = generate_private_exponent(P, Q, E);

    // test baseline functionality of program works
    // test_encrypt_decrypt(plaintext, N, E, D, m);

    // // Public Key: (E, PQ)
    // // Private Key: (D, PQ)

    // RSA_encryption_decryption(plaintext, E, N, D, m);



    // EXTRA TESTS ------------------------------------------------------------------
    // test_side_channel(plaintext, P, Q, E);

    // printf("********** Test Addition **********\n");

    // test_montgomery_addition(P, Q, N);

    // printf("********** Test Multiplication **********\n");

    // test_montgomery_multiplication();
    return 0;
}
