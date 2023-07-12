/* 
** Unoptomized RSA Routine for 256-bit key
** No implementation for hiding or masking of execution time / power consumption 
*/

#include "arm_neon.h"
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include "RSA_functions.h"


int main() {
    /** initial test **/
    uint64_t P = 61; // Example prime number p
    uint64_t Q = 53; // Example prime number q
    uint64_t N = P * Q; // Modulus N
    uint64_t phi = (P - 1) * (Q - 1); // Euler's totient function value
    uint64_t E = 17; // Public exponent
    uint64_t plaintext = 440;
    uint64_t m = 64; // temp, eventually need to be implemented for 256 bit 
    uint64_t D;

    // Check 1 < E < PQ
    if (E <= 1 || E >= N) {
        printf("Invalid public exponent 'E'. It must satisfy 1 < E < PQ.\n");
        return -1;
    }

    // Check if E, P-1, and Q-1 are relatively prime
    if (!are_relatively_prime(E, phi) || !are_relatively_prime(E, P - 1) || !are_relatively_prime(E, Q - 1)) {
        printf("Invalid public exponent 'E'. It must be relatively prime to (P-1) and (Q-1).\n");
        return -1;
    }

    // Check that plaintext is < PQ
    if (plaintext >= N) {
        printf("Invalid plaintext value. It must satisfy plaintext < PQ.\n");
        return -1;
    }

    // Calculate the private exponent d using the formula D = (X(P-1)(Q-1) + 1) / E
    D = compute_private_exponent(find_desired_x(P, Q, E), P, Q, E);

    // Public Key: (E, PQ)
    // Private Key: (D, PQ)

    // Compute R = (2^m) % N
    uint64_t R = 1;
    for (int i = 0; i < m; i++) {
        R = (R << 1) % N;
    }

    // Compute Y = (R^2) % N
    uint64_t Y = (R * R) % N;

    // Perform RSA encryption
    clock_t start_encrypt = clock();

    uint64_t ciphertext = rsa_encryption(plaintext, E, Y, N, m);

    clock_t end_encrypt = clock();
    double total_time_encrypt = (double)(end_encrypt - start_encrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Encryption **********\n");
    printf("RSA Encryption Ciphertext: %llu\n", ciphertext);
    printf("Time to execute encrypt: %.7f\n", total_time_encrypt);

    // Perform RSA decryption
    clock_t start_decrypt = clock();

    uint64_t decrypted = rsa_decryption(ciphertext, D, (R * R) % N, N, m);

    clock_t end_decrypt = clock();
    double total_time_decrypt = (double)(end_decrypt - start_decrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Decryption **********\n");
    printf("Decrypted: %llu\n", decrypted);
    printf("Time to execute decrypt: %.7f\n", total_time_decrypt);

    return 0;
}