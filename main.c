/*
** Unoptomized RSA Routine for 64-bit key
** No implementation for hiding or masking of execution time / power consumption
*/

#include <stdio.h>
#include <stdint.h>
#include <time.h>

// Helper function to perform modular addition
unsigned long long int montgomery_add(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    unsigned long long int sum = a + b;
    if (sum >= modulus)
        sum -= modulus;
    return sum;
}

/**
* Performs Montgomery modular multiplication.
* Parameters:
* - a: The first operand.
* - b: The second operand.
* - modulus: The modulus.
* Returns: The result of the multiplication.
*/
unsigned long long int montgomery_multiplication(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    unsigned long long int result = 0;
    unsigned long long int factor = (1ULL << 32) % modulus;
    int i;

    for (i = 0; i < 32; i++) {
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
    unsigned long long int factor = (1ULL << m) % modulus;
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
    //unsigned long long int R = (1ULL << m) % modulus;
    unsigned long long int R = 1;
    unsigned long long int baseMont = montgomery_multiplication(base, R, modulus); // R is the Montgomery factor

    while (exponent > 0) {
        if (exponent & 1) {
            result = montgomery_multiplication(result, baseMont, modulus);
        }

        baseMont = montgomery_multiplication(baseMont, baseMont, modulus);
        exponent >>= 1;
    }

    return montgomery_modular_reduction(result, modulus, Y, m); // Montgomery reduction after exponentiation
}


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

    // Compute R = (2^m) % N
    unsigned long long int R = 1;
    int i;
    for (i = 0; i < m; i++) {
        R = (R << 1) % N;
    }

    // Compute Y = (R^2) % N
    unsigned long long int Y = (R * R) % N;

    // Perform RSA encryption
    clock_t start_encrypt = clock();

    unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, E, N, Y, m);

    clock_t end_encrypt = clock();
    double total_time_encrypt = (double)(end_encrypt - start_encrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Encryption **********\n");
    printf("RSA Encryption Ciphertext: %llu\n", ciphertext);
    printf("Time to execute encrypt: %.7f\n", total_time_encrypt);

    // Perform RSA decryption
    clock_t start_decrypt = clock();

    unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, D, N, Y, m);

    clock_t end_decrypt = clock();
    double total_time_decrypt = (double)(end_decrypt - start_decrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Decryption **********\n");
    printf("Decrypted: %llu\n", decrypted);
    printf("Time to execute decrypt: %.7f\n", total_time_decrypt);

    return 0;
}
