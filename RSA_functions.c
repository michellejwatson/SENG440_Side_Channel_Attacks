/* 
** Unoptimized Modular Exponentiation Function  
*/

#include "RSA_functions.h"


/** encryption **/
uint64_t rsa_encryption(uint64_t plaintext, uint64_t exponent, uint64_t Y, uint64_t N, uint64_t m){
    uint64_t me_result = modular_exponentiation(plaintext, exponent, N);
    uint64_t mmm_result = montgomery_modular_multiplication(me_result, plaintext, Y, N, m);
    return mmm_result;
}


/** decryption **/
uint64_t rsa_decryption(uint64_t ciphertext, uint64_t d, uint64_t Y, uint64_t N, uint64_t m){
    uint64_t me_result = modular_exponentiation(ciphertext, d, N);
    uint64_t decrypted = montgomery_modular_multiplication(me_result, 1, Y, N, m);
    return decrypted;
}


/** modular exponentiation **/
uint64_t modular_exponentiation(uint64_t base, uint64_t exponent, uint64_t modulus){
    uint64_t result = 1;

    while (exponent > 0) {
        if (exponent & 1) {
            result = (result * base) % modulus;
        }

        base = (base * base) % modulus;
        exponent >>= 1;
    }

    return result;
}


/** montgomery modular multiplication **/
uint64_t montgomery_modular_multiplication(uint64_t T, uint64_t X, uint64_t Y, uint64_t M, uint64_t m){
    int i;
 
    for (i = 0; i < m; i++) {
        uint64_t eta = (T & 0b00001) ^ ((X >> i) & 0b00001);
        uint64_t product = (uint64_t)((X >> i) & 0b00001) * (Y & 0b00001);
        uint64_t result = product % M;
        T = (T + result + eta * M) >> 1;
        if (T >= M) {
            T -= M;
        }
    }

    if (T >= M) {
        T -= M;
    }
    
    return T;
}


/** check if two integers are relatively prime **/
int are_relatively_prime(uint64_t a, uint64_t b) {
    uint64_t temp;
    while (b != 0) {
        temp = b;
        b = a % b;
        a = temp;
    }
    return a == 1;
}

/** find desired value of X in the formula D = (X(P-1)(Q-1) + 1) / E **/
uint64_t find_desired_x(uint64_t P, uint64_t Q, uint64_t E) {
    uint64_t X = 1;
    while ((X * (P - 1) * (Q - 1) + 1) % E != 0) {
        X++;
    }
    return X;
}

/** compute private exponent using D = (X(P-1)(Q-1) + 1) / E **/
uint64_t compute_private_exponent(uint64_t X, uint64_t P, uint64_t Q, uint64_t E) {
    uint64_t phi = (P - 1) * (Q - 1);
    uint64_t D = ((X * phi) + 1) / E;
    return D;
}