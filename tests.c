#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>
#include "RSA_functions.h"

// TODO: so this runs well sometimes, and wrong othertimes. idk why, because it really shouldn't
// either swap how we time it, or decide it's negligable?
// or maybe clock isn't fine enough to get the difference, and we should run it a bunch of times?
int test_montgomery_addition(unsigned long a, unsigned long long int b, unsigned long long int modulus){
    clock_t start;
    clock_t end;

    a = 2;
    b = 20;
    modulus = 2*20;
    //Do with a < modulus
    start = clock();
    montgomery_add(a, b, modulus);
    end = clock();

    double time_1 = (double)(end - start);

    // Do addition with a > modulus
    a = a + modulus;
    start = clock();
    montgomery_add((a+modulus), b, modulus);
    end = clock();

    double time_2 = (double)(end - start);

    if(time_1 == time_2) {
        printf("passed\n");
        return 1;
    }
    printf("FAILED\n");
    printf("t1: %.10f t2: %.10f\n", time_1, time_2);
    return 0;
}




/**
* gets time required for Montgomery modular multiplication for 64-bit word.
* Parameters:
* - a: The first operand.
* - b: The second operand.
* - modulus: The modulus.
* Returns: time required to compute the multiplication.
*/
long double get_time_montgomery_multiplication(unsigned long long int a, unsigned long long int b, unsigned long long int modulus){
    clock_t start;
    clock_t end;

    //start timer
    start = clock();

    montgomery_multiplication(a, b, modulus);

    //end timer
    end = clock();

    return ((long double)(end - start) / CLOCKS_PER_SEC);
}

void test_montgomery_multiplication(){

    unsigned long long int a = 42;
    unsigned long long int b = 77;
    unsigned long long int b2 = 76;
    unsigned long long int modulus = a*b;
    
    //expected problem areas:
    // b is odd vs b is even
    double b1_time = get_time_montgomery_multiplication(a, b, modulus);
    double b2_time = get_time_montgomery_multiplication(a, b2, modulus);

    // so these are sometimes different, but doesn't always show up. 
    // Do we care? Am i wasting time? staytuned! 
    printf("b1: %lld time:%.10f\n", b, b1_time);
    printf("b2: %lld time:%.10f\n", b2, b2_time);
    
    //a > modulus vs a <= modulus

}

void test_montgomery_reduction(){}

void test_montgomery_modular_exponentiation(){}


/**
* Finds average time to decrypt a ciphertext
* Parameters:
* - ciphertext: to be decrypted.
* - D: The exponent value.
* - N: The modulus.
* - Y: The Montgomery factor.
* - m: The number of bits.
* Returns: The average time to perform the decryption
*/
double find_baseline_decryption_time(unsigned long long int ciphertext, unsigned long long int D, unsigned long long int N, unsigned long long int Y, unsigned long long int m){
    int num_loops = 100;
    unsigned long long int decrypted;
    clock_t start_decrypt;
    clock_t end_decrypt;
    double total_time = 0;
    int i;

    for(i = 0; i < num_loops; i++)
    {
        start_decrypt = clock();
        decrypted = montgomery_modular_exponentiation(ciphertext, D, N, Y, m);
        end_decrypt = clock();
        total_time += (double)(end_decrypt - start_decrypt);
    }

    total_time = (double)(total_time) / CLOCKS_PER_SEC; // >> do a shift instead to optimize a little better
    double average_time = total_time/num_loops;
    return average_time;
}

int test_side_channel(unsigned long long int plaintext, unsigned long long int prime_num_1, unsigned long long int prime_num_2, unsigned long long int public_exponent){

    unsigned long long int modulus = prime_num_1 * prime_num_2; // Modulus N
    unsigned long long int phi = (prime_num_1 - 1) * (prime_num_2 - 1); // Euler's totient function value
    unsigned long long int m = 64; // 64 bit expected
    unsigned long long int private_exponent;
    unsigned long long int D_invalid;
    double acceptance_threshold_percent = 0.10;
    double acceptance_threshold; // calculated later using given acceptance_threshold_percent.

    clock_t start, end;

    // Check 1 < E < PQ
    if (public_exponent <= 1 || public_exponent >= modulus) {
        printf("Invalid public exponent 'E'. It must satisfy 1 < E < PQ.\n");
        return -1;
    }

    // Check that plaintext is < PQ
    if (plaintext >= modulus) {
        printf("Invalid plaintext value. It must satisfy plaintext < PQ.\n");
        return -1;
    }

    // Calculate the private exponent d using the formula D = (X(P-1)(Q-1) + 1) / E
    unsigned long long int X = 1;
    while ((X * (prime_num_1 - 1) * (prime_num_2 - 1) + 1) % public_exponent != 0) {
        X++;
    }

    private_exponent = ((X * phi) + 1) / public_exponent;

    // Public Key: (E, PQ)
    // Private Key: (D, PQ)

    // Compute R = (2^m) % N
    unsigned long long int R = 1;
    int i;
    for (i = 0; i < m; i++) {
        R = (R << 1) % modulus;
    }

    // Compute Y = (R^2) % N
    unsigned long long int Y = (R * R) % modulus;
    
    //clock_t start = clock();

    // Perform RSA encryption
    unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, public_exponent, modulus, Y, m);

    // Perform RSA decryption
    start = clock();
    unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, private_exponent, modulus, Y, m);
    end = clock();
    double once_around = (double)(end - start) / CLOCKS_PER_SEC;

    double average_decrypt_time = find_baseline_decryption_time(ciphertext, private_exponent, modulus, Y, m);

    printf("********** RSA Decryption **********\n");
    // check decrytion worked
    assert(decrypted == plaintext);
    printf("Decrypted: %llu time: %.10f\n", decrypted, once_around);
    printf("Average time to decrypt: %.10f\n", average_decrypt_time);
    printf("D:%lld\n", private_exponent);

    D_invalid = private_exponent;
    acceptance_threshold =  average_decrypt_time * acceptance_threshold_percent;

    printf("Acceptance threshold: %.10f \n", acceptance_threshold);

    // To test affectiveness, we perform a simplified mock attack?
    printf("Performing test...................\n");
    while(D_invalid > 0)
    {
        D_invalid = D_invalid >> 1; //need way to make sure this is always different. there is probably a better way to do this

        start = clock();

        decrypted = montgomery_modular_exponentiation(ciphertext, D_invalid, modulus, Y, m);
        end = clock();

        double total_time_decrypt_semi_invalid_key = (double)(end - start) / CLOCKS_PER_SEC;

        // printf("start: %ld end: %ld \n", start, end);

        double difference = total_time_decrypt_semi_invalid_key - average_decrypt_time;

        // printf("loop D:%lld  \n", D_invalid);
        // printf("Time to execute decrypt: %.10f\n", total_time_decrypt_semi_invalid_key);
        // printf("difference: %f\n", difference);

        // apply abs value if necessary TODO: make mask to optimize process? 
        if(difference < 0){
            difference = difference*-1;
        }
        
        if(difference > acceptance_threshold)
        {
            printf("********** RSA Decryption Difference detected **********\n");
            printf("Decrypted: %llu, invalid key:%llu\n", decrypted, D_invalid);
            printf("valid key: %llu\n", private_exponent);
            printf("Time to execute failed decrypt: %.10f\n", total_time_decrypt_semi_invalid_key);
            // printf("Goal time: %.10f\n", average_decrypt_time);
            // TODO: add assert?
            return 1;
        }
    }

    return 0;
}

/**
 * Verifies program can encrypt and decrypt plaintext
 * Parameters:
 *  - plaintext: to be encrypted
 *  - modulus: shared portion of public and private key. Used for encryption and decryption
 *  - public_exponent: second part of public key, used to encrypt message
 *  - private_exponent: second part of private key, used to decrypt message
 *  - montgomery_factor: TODO: check needed.
*/
int test_encrypt_decrypt(unsigned long long int plaintext, unsigned long long int modulus, unsigned long long int public_exponent, unsigned long long int private_exponent, unsigned long long int montgomery_factor) {
    unsigned long long int m = 64; // 64 bit expected -> TODO: is this always hardcoded?

    // Perform RSA encryption
    unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, public_exponent, modulus, montgomery_factor, m);
    
    printf("********** RSA Encryption **********\n");
    printf("RSA Encryption Ciphertext: %llu\n", ciphertext);

    // Perform RSA decryption
    unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, private_exponent, modulus, montgomery_factor, m);

    printf("********** RSA Decryption **********\n");
    printf("Decrypted: %llu\n", decrypted);

    // check encryption worked
    assert(ciphertext != plaintext);
    // check decryption worked
    assert(decrypted == plaintext);
    
    return 0;
}
