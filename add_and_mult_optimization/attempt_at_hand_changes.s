	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"RSA_functions.c"
	.text
	.align	2
	.global	montgomery_add
	.type	montgomery_add, %function
montgomery_add:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, fp}
	add	fp, sp, #4
	sub	sp, sp, #40
	str	r0, [fp, #-40]
	str	r2, [fp, #-28]
	str	r3, [fp, #-24]
	sub	r2, fp, #28
	ldmia	r2, {r1-r2}
	ldmib	fp, {r3-r4}
	adds	r3, r3, r1
	adc	r4, r4, r2
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-12]
	str	r4, [fp, #-8]
	sub	r3, fp, #20
	ldmia	r3, {r2-r3}
	str	r2, [fp, #-36]
	str	r3, [fp, #-32]
	ldr	r3, [fp, #16]			
	ldr	r4, [fp, #-32]
	cmp	r3, r4
	bhi	TWO_MORE_COMPARE_L2					@ start of hand coded section
	ldr	r3, [fp, #12]
	ldr	r4, [fp, #-36]
	cmp	r3, r4
	bhi	ONE_MORE_COMPARE_L2
	ldr	r3, [fp, #16]
	ldr	r2, [fp, #-32]
	cmp	r3, r2
	bne	ONE_MORE_COMPARE_L6
	ldr	r3, [fp, #12]
	ldr	r2, [fp, #-36]
	cmp	r3, r2
	b .L6
ONE_MORE_COMPARE_L6:
	ldr	r5, [fp, #12]
	ldr	r6, [fp, #-36]
	cmp	r5, r6
.L6:
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	add	r2, fp, #12
	ldmia	r2, {r1-r2}
	subs	r3, r3, r1
	sbc	r4, r4, r2
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	b	.L4
TWO_MORE_COMPARE_L2:
	ldr	r5, [fp, #12]
	ldr	r6, [fp, #-36]
	cmp	r5, r6
ONE_MORE_COMPARE_L2:
	ldr	r5, [fp, #12]
	ldr	r6, [fp, #-36]
	cmp	r5, r6
.L2:
	sub	r4, fp, #12
	ldmia	r4, {r3-r4}
	add	r2, fp, #12
	ldmia	r2, {r1-r2}
	subs	r3, r3, r1
	sbc	r4, r4, r2
	str	r3, [fp, #-12]
	str	r4, [fp, #-8]
.L4:
	ldr	ip, [fp, #-40]
	sub	r3, fp, #20
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	ldr	r0, [fp, #-40]
	sub	sp, fp, #4
	ldmfd	sp!, {r4, fp}
	bx	lr
	.size	montgomery_add, .-montgomery_add
	.global	__aeabi_uldivmod
	.align	2
	.global	montgomery_multiplication
	.type	montgomery_multiplication, %function
montgomery_multiplication:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 96
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #116
	str	r0, [fp, #-104]
	str	r2, [fp, #-76]
	str	r3, [fp, #-72]
	sub	r4, fp, #76
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	sub	r4, fp, #76
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-60]
	str	r4, [fp, #-56]
	mov	r3, #0
	mov	r4, #0
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	mov	r3, #0
	mov	r4, #0
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L8
.L14:
	ldr	r3, [fp, #4]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L9
	sub	r2, fp, #36
	ldmia	r2, {r1-r2}
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	sub	r0, fp, #52
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r3, r2
	mov	r2, r1
	bl	montgomery_add
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	b	.L10
.L9:
	sub	r2, fp, #28
	ldmia	r2, {r1-r2}
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	sub	r0, fp, #92
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r3, r2
	mov	r2, r1
	bl	montgomery_add
	sub	ip, fp, #52
	sub	r3, fp, #92
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	sub	r4, fp, #44
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
.L10:
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	adds	r3, r3, r3
	adc	r4, r4, r4
	mov	r0, r3
	mov	r1, r4
	add	r3, fp, #12
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r4, r3
	mov	r3, r2
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	ldmib	fp, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	stmib	fp, {r3-r4}
	sub	r3, fp, #68
	ldmia	r3, {r2-r3}
	str	r2, [fp, #-100]
	str	r3, [fp, #-96]
	ldr	r3, [fp, #16]					@ Here is where it starts. my plan was to add extra ldr,compares by hand. see addition.
	ldr	r4, [fp, #-96]					@ this section either goes to .L11 or .L16
	cmp	r3, r4
	bhi	.L11
	ldr	r3, [fp, #16]
	ldr	r2, [fp, #-96]
	cmp	r3, r2
	bne	.L16
	ldr	r3, [fp, #12]
	ldr	r4, [fp, #-100]
	cmp	r3, r4
	bhi	.L11
	ldr	r3, [fp, #12]
	ldr	r2, [fp, #-100]
	cmp	r3, r2							@ end of problem area
.L16:
	sub	r2, fp, #68
	ldmia	r2, {r1-r2}
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	sub	r0, fp, #92
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r3, r2
	mov	r2, r1
	bl	montgomery_add
	sub	ip, fp, #52
	sub	r3, fp, #92
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	b	.L13
.L11:
	sub	r2, fp, #68
	ldmia	r2, {r1-r2}
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	sub	r0, fp, #92
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r3, r2
	mov	r2, r1
	bl	montgomery_add
	sub	ip, fp, #52
	sub	r3, fp, #92
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-60]
	str	r4, [fp, #-56]
.L13:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L8:
	ldr	r3, [fp, #-16]
	cmp	r3, #63
	ble	.L14
	ldr	ip, [fp, #-104]
	sub	r3, fp, #36
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	ldr	r0, [fp, #-104]
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	montgomery_multiplication, .-montgomery_multiplication
	.align	2
	.global	montgomery_modular_reduction
	.type	montgomery_modular_reduction, %function
montgomery_modular_reduction:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #92
	str	r0, [fp, #-60]
	str	r1, [fp, #-56]
	str	r2, [fp, #-68]
	str	r3, [fp, #-64]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	sub	r2, fp, #52
	mov	r3, #1
	mov	r4, #0
	stmia	sp, {r3-r4}
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r0, r2
	sub	r3, fp, #60
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	sub	r2, fp, #84
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r0, r2
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	sub	ip, fp, #52
	sub	r3, fp, #84
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	montgomery_modular_reduction, .-montgomery_modular_reduction
	.align	2
	.global	montgomery_modular_exponentiation
	.type	montgomery_modular_exponentiation, %function
montgomery_modular_exponentiation:
	@ Function supports interworking.
	@ args = 24, pretend = 0, frame = 144
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #164
	str	r0, [fp, #-152]
	str	r2, [fp, #-132]
	str	r3, [fp, #-128]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	sub	r2, fp, #108
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r0, r2
	sub	r3, fp, #132
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	sub	r4, fp, #108
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	mov	r3, #0
	mov	r4, #0
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	mov	r2, #0
	str	r2, [fp, #-136]
	b	.L20
.L23:
	ldr	r3, [fp, #4]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L21
	sub	r2, fp, #92
	sub	r4, fp, #28
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r0, r2
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	sub	r4, fp, #92
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	b	.L22
.L21:
	sub	r2, fp, #76
	sub	r4, fp, #28
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r0, r2
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	sub	r4, fp, #76
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
.L22:
	sub	r2, fp, #60
	sub	r4, fp, #28
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	r0, r2
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	sub	r4, fp, #60
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	ldmib	fp, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	stmib	fp, {r3-r4}
	ldr	r3, [fp, #-136]
	add	r3, r3, #1
	str	r3, [fp, #-136]
.L20:
	ldr	r3, [fp, #-136]
	mov	r2, r3
	mov	r3, r2, asr #31
	str	r2, [fp, #-148]
	str	r3, [fp, #-144]
	ldr	r3, [fp, #24]
	ldr	r4, [fp, #-144]
	cmp	r3, r4
	bhi	.L23
	ldr	r3, [fp, #24]
	ldr	r2, [fp, #-144]
	cmp	r3, r2
	bne	.L26
	ldr	r3, [fp, #20]
	ldr	r4, [fp, #-148]
	cmp	r3, r4
	bhi	.L23
	ldr	r3, [fp, #20]
	ldr	r2, [fp, #-148]
	cmp	r3, r2
.L26:
	add	r4, fp, #20
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #44
	ldmia	r1, {r0-r1}
	add	r3, fp, #12
	ldmia	r3, {r2-r3}
	bl	montgomery_modular_reduction
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-124]
	str	r4, [fp, #-120]
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-116]
	str	r4, [fp, #-112]
	ldr	ip, [fp, #-152]
	sub	r3, fp, #124
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	ldr	r0, [fp, #-152]
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	montgomery_modular_exponentiation, .-montgomery_modular_exponentiation
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.section	.rodata
	.align	2
.LC0:
	.ascii	"********** RSA Encryption **********\000"
	.align	2
.LC1:
	.ascii	"RSA Encryption Ciphertext: %llu\012\000"
	.align	2
.LC2:
	.ascii	"Time to execute encrypt: %.7f\012\000"
	.align	2
.LC3:
	.ascii	"********** RSA Decryption **********\000"
	.align	2
.LC4:
	.ascii	"Decrypted: %llu\012\000"
	.align	2
.LC5:
	.ascii	"Time to execute decrypt: %.7f\012\000"
	.text
	.align	2
	.global	RSA_encryption_decryption
	.type	RSA_encryption_decryption, %function
RSA_encryption_decryption:
	@ Function supports interworking.
	@ args = 24, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #156
	str	r0, [fp, #-132]
	str	r1, [fp, #-128]
	str	r2, [fp, #-140]
	str	r3, [fp, #-136]
	bl	clock
	mov	r3, r0
	str	r3, [fp, #-88]
	sub	r2, fp, #124
	sub	r4, fp, #140
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	ldmib	fp, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	add	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [sp, #16]
	str	r4, [sp, #20]
	mov	r0, r2
	sub	r3, fp, #132
	ldmia	r3, {r2-r3}
	bl	montgomery_modular_exponentiation
	sub	r4, fp, #124
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-84]
	str	r4, [fp, #-80]
	bl	clock
	mov	r3, r0
	str	r3, [fp, #-72]
	ldr	r2, [fp, #-72]
	ldr	r3, [fp, #-88]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r5, #0
	mov	r6, #1090519040
	add	r6, r6, #3047424
	add	r6, r6, #1152
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	ldr	r0, .L29
	bl	puts
	ldr	r0, .L29+4
	sub	r3, fp, #84
	ldmia	r3, {r2-r3}
	bl	printf
	ldr	r0, .L29+8
	sub	r3, fp, #68
	ldmia	r3, {r2-r3}
	bl	printf
	bl	clock
	mov	r3, r0
	str	r3, [fp, #-56]
	sub	r2, fp, #108
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	ldmib	fp, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	add	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [sp, #16]
	str	r4, [sp, #20]
	mov	r0, r2
	sub	r3, fp, #84
	ldmia	r3, {r2-r3}
	bl	montgomery_modular_exponentiation
	sub	r4, fp, #108
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-52]
	str	r4, [fp, #-48]
	bl	clock
	mov	r3, r0
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-56]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r5, #0
	mov	r6, #1090519040
	add	r6, r6, #3047424
	add	r6, r6, #1152
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	ldr	r0, .L29+12
	bl	puts
	ldr	r0, .L29+16
	sub	r3, fp, #52
	ldmia	r3, {r2-r3}
	bl	printf
	ldr	r0, .L29+20
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	bl	printf
	bl	rand
	mov	r1, r0
	ldr	r3, .L29+24
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #1
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	str	r3, [fp, #-144]
	ldr	r3, [fp, #-144]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-144]
	add	r3, r3, r2
	rsb	r3, r3, r1
	str	r3, [fp, #-144]
	ldr	r2, [fp, #-144]
	add	r3, r2, #1
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	mov	r0, r3
	bl	sleep
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L30:
	.align	2
.L29:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	1717986919
	.size	RSA_encryption_decryption, .-RSA_encryption_decryption
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
