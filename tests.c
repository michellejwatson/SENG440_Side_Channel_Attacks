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
double find_baseline_decryption_time(unsigned long long int ciphertext, unsigned long long int D, unsigned long long int N, unsigned long long int m){
    int num_loops = 100;
    unsigned long long int decrypted;
    clock_t start_decrypt;
    clock_t end_decrypt;
    double total_time = 0;
    int i;

    for(i = 0; i < num_loops; i++)
    {
        start_decrypt = clock();
        decrypted = montgomery_modular_exponentiation(ciphertext, D, N, m).real;
        end_decrypt = clock();
        total_time += (double)(end_decrypt - start_decrypt);
    }

    total_time = (double)(total_time) / CLOCKS_PER_SEC;
    double average_time = total_time/num_loops;
    return average_time;
}

int test_side_channel(unsigned long long int plaintext, unsigned long long int modulus, unsigned long long int public_exponent, unsigned long long int private_exponent, unsigned long long int m){

    unsigned long long int invalid_private_exponant;
    double acceptance_threshold_percent = 0.10;
    double acceptance_threshold; // calculated later using given acceptance_threshold_percent.

    clock_t start, end;

    // Public Key: (E, PQ)
    // Private Key: (D, PQ)
    
    //clock_t start = clock();

    // Perform RSA encryption
    unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, public_exponent, modulus, m).real;

    // Perform RSA decryption
    start = clock();
    unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, private_exponent, modulus, m).real;
    end = clock();

    double average_decrypt_time = find_baseline_decryption_time(ciphertext, private_exponent, modulus, m);

    printf("********** RSA Side channel check **********\n");
    // check decrytion worked
    assert(decrypted == plaintext);

    printf("Decrypted: %llu", decrypted);
    printf("Average time to decrypt: %.10f\n", average_decrypt_time);
    printf("D:%lld\n", private_exponent);

    invalid_private_exponant = private_exponent;
    acceptance_threshold =  average_decrypt_time * acceptance_threshold_percent;

    printf("Acceptance threshold: %.10f \n", acceptance_threshold);

    // To test affectiveness, we perform a simplified mock attack?
    printf("Performing test...................\n");
    while(invalid_private_exponant > 0)
    {
        invalid_private_exponant = invalid_private_exponant >> 1; //need way to make sure this is always different. there is probably a better way to do this

        start = clock();

        decrypted = montgomery_modular_exponentiation(ciphertext, invalid_private_exponant, modulus, m).real;
        end = clock();

        double total_time_decrypt_semi_invalid_key = (double)(end - start) / CLOCKS_PER_SEC;

        double difference = total_time_decrypt_semi_invalid_key - average_decrypt_time;

        // apply abs value if necessary 
        if(difference < 0){
            difference = difference*-1;
        }
        
        if(difference > acceptance_threshold)
        {
            printf("********** RSA Decryption Difference detected **********\n");
            printf("Decrypted: %llu, invalid key:%llu\n", decrypted, invalid_private_exponant);
            printf("valid key: %llu\n", private_exponent);
            printf("Time to execute failed decrypt: %.10f\n", total_time_decrypt_semi_invalid_key);
            // printf("Goal time: %.10f\n", average_decrypt_time);
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
int test_encrypt_decrypt(unsigned long long int plaintext, unsigned long long int modulus, unsigned long long int public_exponent, unsigned long long int private_exponent, unsigned long long int m) {

    printf("********** test encrpyt/decrypt **********\n");
    // Perform RSA encryption
    unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, public_exponent, modulus, m).real;
    
    printf("********** RSA Encryption **********\n");
    printf("RSA Encryption Ciphertext: %llu\n", ciphertext);

    // Perform RSA decryption
    unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, private_exponent, modulus, m).real;

    printf("********** RSA Decryption **********\n");
    printf("Decrypted: %llu\n", decrypted);

    // check encryption worked
    assert(ciphertext != plaintext);
    // check decryption worked
    assert(decrypted == plaintext);
    
    return 0;
}
