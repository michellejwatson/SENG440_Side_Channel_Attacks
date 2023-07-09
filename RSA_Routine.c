/* 
** RSA Routine for 32 bit integers
** No implementation for hiding or masking of execution time / power consumption 
*/

#include "arm_neon.h"
#include <stdio.h>

uint32_t RSA_Routine(uint32_t T, uint32_t X, uint32_t Y, uint32_t M, uint32_t m){
    int i;
 
    for (i = 0; i < m; i++) {
        uint32_t eta = (T & 0b00001) ^ ((X >> i) & 0b00001);
        uint64_t product = (uint64_t)((X >> i) & 0b00001) * (Y & 0b00001);
        uint32_t result = product % M;
        T = (T + result + eta * M) >> 1;
        if (T >= M) {
            T -= M;
        }
    }
    
    return T;
}

int main() {
    uint32_t T = 0; 
    uint32_t X = 0b10001; // Example value for X (5-bit integer)
    uint32_t Y = 0b10110; // Example value for Y (5-bit integer)
    uint32_t M = 0b10111; // Example value for Y (5-bit integer)
    uint32_t m = 32; // Value for m for 32-bit integers 

    uint32_t Z = RSA_Routine(T, X, Y, M, m);
    
    printf("Z = %u\n", Z);
    
    return 0;
}