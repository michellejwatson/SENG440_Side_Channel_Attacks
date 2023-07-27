/*
** Unoptomized RSA Routine for 64-bit key
** No implementation for hiding or masking of execution time / power consumption
*/

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>

// Helper function to perform modular addition
unsigned long long int montgomery_add(unsigned long long int a, unsigned long long int b, unsigned long long int modulus) {
    unsigned long long int sum = a + b;
    if (sum >= modulus)
        sum -= modulus;
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

    for (i = 0; i <  64; i++) { //modulus instead of static?
        if (b % 2 == 1) result = montgomery_add(result, a, modulus);

        a = (a << 1) % modulus;
        b = b >> 1;

        if (a >= modulus) a = montgomery_add(a, a, modulus);
    }

    return result;
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

    for(int i = 0; i < num_loops; i++)
    {
        start_decrypt = clock();
        decrypted = montgomery_modular_exponentiation(ciphertext, D, N, Y, m);
        end_decrypt = clock();
        total_time += (double)(end_decrypt - start_decrypt);
    }

    total_time = (double)(total_time) / CLOCKS_PER_SEC;
    double average_time = total_time/num_loops;
    return average_time;
}

// TODO:
void test_montgomery_reduction(){}
void test_montgomery_addition(){}
void test_montgomery_modular_exponentiation(){}

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

// 

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

    // // Check 1 < E < PQ
    // if (E <= 1 || E >= N) {
    //     printf("Invalid public exponent 'E'. It must satisfy 1 < E < PQ.\n");
    //     return -1;
    // }

    // // Check that plaintext is < PQ
    // if (plaintext >= N) {
    //     printf("Invalid plaintext value. It must satisfy plaintext < PQ.\n");
    //     return -1;
    // }

    // // Calculate the private exponent d using the formula D = (X(P-1)(Q-1) + 1) / E
    // unsigned long long int X = 1;
    // while ((X * (P - 1) * (Q - 1) + 1) % E != 0) {
    //     X++;
    // }

    // D = ((X * phi) + 1) / E;

    // // Public Key: (E, PQ)
    // // Private Key: (D, PQ)

    // // Compute R = (2^m) % N
    // unsigned long long int R = 1;
    // int i;
    // for (i = 0; i < m; i++) {
    //     R = (R << 1) % N;
    // }

    // // Compute Y = (R^2) % N
    // unsigned long long int Y = (R * R) % N;

    // // Perform RSA encryption
    // clock_t start_encrypt = clock();

    // unsigned long long int ciphertext = montgomery_modular_exponentiation(plaintext, E, N, Y, m);

    // clock_t end_encrypt = clock();
    // double total_time_encrypt = (double)(end_encrypt - start_encrypt) / CLOCKS_PER_SEC;

    // printf("********** RSA Encryption **********\n");
    // printf("RSA Encryption Ciphertext: %llu\n", ciphertext);
    // printf("Time to execute encrypt: %.7f\n", total_time_encrypt);

    // // Perform RSA decryption
    // clock_t start_decrypt = clock();

    // unsigned long long int decrypted = montgomery_modular_exponentiation(ciphertext, D, N, Y, m);

    // clock_t end_decrypt = clock();
    // double total_time_decrypt = (double)(end_decrypt - start_decrypt) / CLOCKS_PER_SEC;

    // printf("********** RSA Decryption **********\n");
    // printf("Decrypted: %llu\n", decrypted);
    // printf("Time to execute decrypt: %.7f\n", total_time_decrypt);

    test_side_channel(plaintext, P, Q, E);
    
    printf("********** Test Multiplication **********\n");

    test_montgomery_multiplication();

    printf("********** Test Multiplication **********\n");
    return 0;
}
