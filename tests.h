#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>
#include "RSA_functions.h"

// TODO: so this runs well sometimes, and wrong othertimes. idk why, because it really shouldn't
// either swap how we time it, or decide it's negligable?
// or maybe clock isn't fine enough to get the difference, and we should run it a bunch of times?
int test_montgomery_addition(unsigned long a, unsigned long long int b, unsigned long long int modulus);

/**
* gets time required for Montgomery modular multiplication for 64-bit word.
* Parameters:
* - a: The first operand.
* - b: The second operand.
* - modulus: The modulus.
* Returns: time required to compute the multiplication.
*/
long double get_time_montgomery_multiplication(unsigned long long int a, unsigned long long int b, unsigned long long int modulus);

void test_montgomery_multiplication();

void test_montgomery_reduction();

void test_montgomery_modular_exponentiation();


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
double find_baseline_decryption_time(unsigned long long int ciphertext, unsigned long long int D, unsigned long long int N, unsigned long long int Y, unsigned long long int m);

// big long test to see if over all works.
int test_side_channel(unsigned long long int plaintext, unsigned long long int prime_num_1, unsigned long long int prime_num_2, unsigned long long int public_exponent);

// Test program can encrypt and decrypt successfully.
int test_encrypt_decrypt(unsigned long long int plaintext, unsigned long long int modulus, unsigned long long int public_exponent, unsigned long long int private_exponent, unsigned long long int montgomery_factor);
