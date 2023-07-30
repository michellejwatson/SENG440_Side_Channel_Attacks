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
	@ args = 8, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, fp}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-28]
	str	r1, [fp, #-24]
	str	r2, [fp, #-36]
	str	r3, [fp, #-32]
	sub	r2, fp, #28
	ldmia	r2, {r1-r2}
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	adds	r3, r3, r1
	adc	r4, r4, r2
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [fp, #-12]
	str	r4, [fp, #-8]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bhi	.L2
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L6
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bhi	.L2
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
.L6:
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	ldmib	fp, {r1-r2}
	subs	r3, r3, r1
	sbc	r4, r4, r2
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	b	.L4
.L2:
	sub	r4, fp, #12
	ldmia	r4, {r3-r4}
	ldmib	fp, {r1-r2}
	subs	r3, r3, r1
	sbc	r4, r4, r2
	str	r3, [fp, #-12]
	str	r4, [fp, #-8]
.L4:
	sub	r4, fp, #20
	ldmia	r4, {r3-r4}
	mov	r0, r3
	mov	r1, r4
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
	@ args = 8, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #52
	str	r0, [fp, #-44]
	str	r1, [fp, #-40]
	str	r2, [fp, #-52]
	str	r3, [fp, #-48]
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
	ldr	r3, [fp, #-52]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L9
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #36
	ldmia	r1, {r0-r1}
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	bl	montgomery_add
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	b	.L10
.L9:
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #36
	ldmia	r1, {r0-r1}
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	bl	montgomery_add
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
.L10:
	sub	r4, fp, #44
	ldmia	r4, {r3-r4}
	adds	r3, r3, r3
	adc	r4, r4, r4
	mov	r0, r3
	mov	r1, r4
	ldmib	fp, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r4, r3
	mov	r3, r2
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	str	r3, [fp, #-52]
	str	r4, [fp, #-48]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-40]
	cmp	r2, r3
	bhi	.L11
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-40]
	cmp	r2, r3
	bne	.L16
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-44]
	cmp	r2, r3
	bhi	.L11
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-44]
	cmp	r2, r3
.L16:
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #44
	ldmia	r1, {r0-r1}
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	bl	montgomery_add
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	b	.L13
.L11:
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #44
	ldmia	r1, {r0-r1}
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	bl	montgomery_add
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
.L13:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L8:
	ldr	r3, [fp, #-16]
	cmp	r3, #63
	ble	.L14
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	montgomery_multiplication, .-montgomery_multiplication
	.align	2
	.global	montgomery_modular_reduction
	.type	montgomery_modular_reduction, %function
montgomery_modular_reduction:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #52
	str	r0, [fp, #-44]
	str	r1, [fp, #-40]
	str	r2, [fp, #-52]
	str	r3, [fp, #-48]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #44
	ldmia	r1, {r0-r1}
	mov	r2, #1
	mov	r3, #0
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #28
	ldmia	r1, {r0-r1}
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
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
	@ args = 16, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #52
	str	r0, [fp, #-44]
	str	r1, [fp, #-40]
	str	r2, [fp, #-52]
	str	r3, [fp, #-48]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #44
	ldmia	r1, {r0-r1}
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	b	.L20
.L22:
	ldr	r3, [fp, #-52]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L21
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #36
	ldmia	r1, {r0-r1}
	sub	r3, fp, #20
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
.L21:
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #20
	ldmia	r1, {r0-r1}
	sub	r3, fp, #20
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	sub	r4, fp, #52
	ldmia	r4, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	str	r3, [fp, #-52]
	str	r4, [fp, #-48]
.L20:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	orr	r3, r3, r2
	cmp	r3, #0
	bne	.L22
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #36
	ldmia	r1, {r0-r1}
	ldmib	fp, {r2-r3}
	bl	montgomery_modular_reduction
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
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
	@ args = 24, pretend = 0, frame = 96
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #116
	str	r0, [fp, #-100]
	str	r1, [fp, #-96]
	str	r2, [fp, #-108]
	str	r3, [fp, #-104]
	bl	clock
	mov	r3, r0
	str	r3, [fp, #-88]
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	sub	r1, fp, #100
	ldmia	r1, {r0-r1}
	sub	r3, fp, #108
	ldmia	r3, {r2-r3}
	bl	montgomery_modular_exponentiation
	mov	r3, r0
	mov	r4, r1
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
	ldr	r0, .L26
	bl	puts
	ldr	r0, .L26+4
	sub	r3, fp, #84
	ldmia	r3, {r2-r3}
	bl	printf
	ldr	r0, .L26+8
	sub	r3, fp, #68
	ldmia	r3, {r2-r3}
	bl	printf
	bl	clock
	mov	r3, r0
	str	r3, [fp, #-56]
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	sub	r1, fp, #84
	ldmia	r1, {r0-r1}
	add	r3, fp, #12
	ldmia	r3, {r2-r3}
	bl	montgomery_modular_exponentiation
	mov	r3, r0
	mov	r4, r1
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
	ldr	r0, .L26+12
	bl	puts
	ldr	r0, .L26+16
	sub	r3, fp, #52
	ldmia	r3, {r2-r3}
	bl	printf
	ldr	r0, .L26+20
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	bl	printf
	bl	rand
	mov	r1, r0
	ldr	r3, .L26+24
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #1
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	str	r3, [fp, #-112]
	ldr	r3, [fp, #-112]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-112]
	add	r3, r3, r2
	rsb	r3, r3, r1
	str	r3, [fp, #-112]
	ldr	r2, [fp, #-112]
	add	r3, r2, #1
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	mov	r0, r3
	bl	sleep
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L27:
	.align	2
.L26:
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
