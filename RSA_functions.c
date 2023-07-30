/* 
** Unoptimized RSA Helper Functions  
*/

#include "RSA_functions.h"
#include <time.h>
#include <stdlib.h>
#include <unistd.h>


// Helper function to perform modular addition
// to help with overflow
struct returnValue montgomery_add(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    struct returnValue sum;
    sum.real = a + b;
    sum.dummy = sum.real;

    if (sum.real >= modulus){
        sum.real -= modulus;
    } else {
        sum.dummy -= modulus;
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
struct returnValue montgomery_multiplication(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    struct returnValue result;
    struct returnValue catcher;
    struct returnValue a_plus;

    a_plus.real = a;
    a_plus.dummy = a;
    result.real = 0;
    result.dummy = 0;
    int i = 0;

    while ( i < 64) { //modulus instead of static?
        if (b % 2 == 1)
        {
            catcher = montgomery_add(result.real, a_plus.real, modulus);
            result.real = catcher.real;
        } else {
            catcher = montgomery_add(result.dummy, a_plus.real, modulus);
            result.dummy = catcher.dummy;
        }

        a_plus.real = (a_plus.real << 1) % modulus;
        b = b >> 1;

        if (a_plus.real >= modulus){
            catcher = montgomery_add(a_plus.real, a_plus.real, modulus);
            a_plus.real = catcher.real;
        } else {
            catcher = montgomery_add(a_plus.real, a_plus.real, modulus);
            a_plus.dummy = catcher.real;
        }
        i++;
    }

    return result;
}

/**
* Performs Montgomery modular reduction.
* Parameters:
* - result: The result of the modular exponentiation.
* - modulus: The modulus.
* - m: The number of bits.
* Returns: The reduced result after Montgomery modular reduction.
*/
unsigned long long int montgomery_modular_reduction(unsigned long long int result, unsigned long long int modulus, unsigned long long int m) {
    unsigned long long int R_inverse = 1;
    struct returnValue fromMult = montgomery_multiplication(result, 1, modulus); // Convert the result to Montgomery form
    unsigned long long int montgomery_result = fromMult.real;
    fromMult = montgomery_multiplication(montgomery_result, R_inverse, modulus); // Perform the Montgomery reduction
    unsigned long long int reduced_result = fromMult.real;

    return reduced_result;
}

/**
* Performs Montgomery modular exponentiation.
* Parameters:
* - base: The base value.
* - exponent: The exponent value.
* - modulus: The modulus.
* - m: The number of bits.
* Returns: The result of the modular exponentiation.
*/
struct returnValue montgomery_modular_exponentiation(unsigned long long int base, unsigned long long int exponent, unsigned long long int modulus, unsigned long long int m) {
    unsigned long long int result = 1;
    unsigned long long int R = 1;
    unsigned long long int baseMont = montgomery_multiplication(base, R, modulus).real;
    unsigned long long int dummy = 0;
    register int i;
    struct returnValue final_result;

    for (i = 0; i < m; i++) {
        if (exponent & 1) {
            result = montgomery_multiplication(result, baseMont, modulus).real;
        }
        else {
            dummy= montgomery_multiplication(result, baseMont, modulus).real;
        }

        baseMont = montgomery_multiplication(baseMont, baseMont, modulus).real;
        exponent >>= 1;
    }

    final_result.real = montgomery_modular_reduction(result, modulus, m);
    final_result.dummy = dummy;

    return final_result; // Montgomery reduction after exponentiation
}

void RSA_encryption_decryption(unsigned long long int plaintext, unsigned long long int E, unsigned long long int N, unsigned long long int D, unsigned long long int m){
    // Perform RSA encryption
    clock_t start_encrypt = clock();

    unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, E, N, m).real;

    clock_t end_encrypt = clock();
    double total_time_encrypt = (double)(end_encrypt - start_encrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Encryption **********\n");
    printf("RSA Encryption Ciphertext: %llu\n", ciphertext);
    printf("Time to execute encrypt: %.7f\n", total_time_encrypt);

    // Perform RSA decryption
    clock_t start_decrypt = clock();

    unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, D, N, m).real;

    clock_t end_decrypt = clock();
    double total_time_decrypt = (double)(end_decrypt - start_decrypt) / CLOCKS_PER_SEC;

    printf("********** RSA Decryption **********\n");
    printf("Decrypted: %llu\n", decrypted);
    printf("Time to execute decrypt: %.7f\n", total_time_decrypt);

    // Introduce Masking (andom delay of 1 to 5 seconds)
    int delay_seconds = rand() % 5 + 1;
    sleep(delay_seconds);
}