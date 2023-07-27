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

int main() {
    /** initial test **/
    unsigned long long int P = 61; // Prime Number P
    unsigned long long int Q = 53; // Prime Number Q
    unsigned long long int N = P * Q; // Modulus N
    unsigned long long int phi = (P - 1) * (Q - 1); // Euler's totient function value
    unsigned long long int E = 17; // Public exponent
    unsigned long long int plaintext = 440;
    unsigned long long int m = 64; // 64 bits
    unsigned long long int D;

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
    unsigned long long int X = 1;
    while ((X * (P - 1) * (Q - 1) + 1) % E != 0) {
        X++;
    }

    D = ((X * phi) + 1) / E;

    // Public Key: (E, PQ)
    // Private Key: (D, PQ)

    RSA_encryption_decryption(plaintext, E, N, D, m);





    // test_side_channel(plaintext, P, Q, E);

    // printf("********** Test Addition **********\n");

    // test_montgomery_addition(P, Q, N);

    // printf("********** Test Multiplication **********\n");

    // test_montgomery_multiplication();
    return 0;
}
