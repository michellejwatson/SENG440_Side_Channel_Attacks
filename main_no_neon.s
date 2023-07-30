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
	.file	"main.c"
	.global	__aeabi_uldivmod
	.global	__aeabi_uldivmod
	.text
	.align	2
	.global	generate_private_exponent
	.type	generate_private_exponent, %function
generate_private_exponent:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #44
	str	r0, [fp, #-52]
	str	r1, [fp, #-48]
	str	r2, [fp, #-60]
	str	r3, [fp, #-56]
	sub	r2, fp, #52
	ldmia	r2, {r1-r2}
	mvn	r3, #0
	mvn	r4, #0
	mov	r0, r1
	mov	r1, r2
	adds	r0, r0, r3
	adc	r1, r1, r4
	sub	r6, fp, #60
	ldmia	r6, {r5-r6}
	mvn	r3, #0
	mvn	r4, #0
	adds	r3, r3, r5
	adc	r4, r4, r6
	mul	r2, r3, r1
	mul	ip, r0, r4
	add	r2, r2, ip
	umull	r5, r6, r0, r3
	mov	r3, r5
	mov	r4, r6
	add	r2, r2, r4
	mov	r4, r2
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	b	.L2
.L3:
	sub	r4, fp, #28
	ldmia	r4, {r3-r4}
	mov	r1, #1
	mov	r2, #0
	adds	r3, r3, r1
	adc	r4, r4, r2
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
.L2:
	sub	r2, fp, #52
	ldmia	r2, {r1-r2}
	mvn	r3, #0
	mvn	r4, #0
	adds	r3, r3, r1
	adc	r4, r4, r2
	ldr	r2, [fp, #-28]
	mul	r0, r4, r2
	ldr	r2, [fp, #-24]
	mul	r2, r3, r2
	add	r0, r0, r2
	ldr	r2, [fp, #-28]
	umull	r5, r6, r2, r3
	mov	r1, r5
	mov	r2, r6
	add	r0, r0, r2
	mov	r2, r0
	sub	r6, fp, #60
	ldmia	r6, {r5-r6}
	mvn	r3, #0
	mvn	r4, #0
	adds	r3, r3, r5
	adc	r4, r4, r6
	mul	r0, r3, r2
	mul	ip, r1, r4
	add	r0, r0, ip
	umull	r5, r6, r1, r3
	mov	r3, r5
	mov	r4, r6
	add	r0, r0, r4
	mov	r4, r0
	mov	r1, #1
	mov	r2, #0
	adds	r3, r3, r1
	adc	r4, r4, r2
	mov	r0, r3
	mov	r1, r4
	ldmib	fp, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r4, r3
	mov	r3, r2
	mov	r1, r3
	mov	r2, r4
	mov	r3, r1
	orr	r3, r3, r2
	cmp	r3, #0
	bne	.L3
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-44]
	mul	r2, r3, r2
	ldr	r1, [fp, #-40]
	ldr	r3, [fp, #-28]
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r1, [fp, #-28]
	ldr	r3, [fp, #-44]
	umull	r5, r6, r1, r3
	mov	r3, r5
	mov	r4, r6
	add	r2, r2, r4
	mov	r4, r2
	mov	r1, #1
	mov	r2, #0
	adds	r3, r3, r1
	adc	r4, r4, r2
	ldmib	fp, {r5-r6}
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_uldivmod
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
	.size	generate_private_exponent, .-generate_private_exponent
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Invalid public exponent 'E'. It must satisfy 1 < E "
	.ascii	"< PQ.\000"
	.align	2
.LC1:
	.ascii	"Invalid plaintext value. It must satisfy plaintext "
	.ascii	"< PQ.\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #100
	mov	r3, #61
	mov	r4, #0
	str	r3, [fp, #-84]
	str	r4, [fp, #-80]
	mov	r3, #53
	mov	r4, #0
	str	r3, [fp, #-76]
	str	r4, [fp, #-72]
	ldr	r2, [fp, #-80]
	ldr	r3, [fp, #-76]
	mul	r2, r3, r2
	ldr	r1, [fp, #-72]
	ldr	r3, [fp, #-84]
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r1, [fp, #-84]
	ldr	r3, [fp, #-76]
	umull	r5, r6, r1, r3
	mov	r3, r5
	mov	r4, r6
	add	r2, r2, r4
	mov	r4, r2
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	mov	r3, #17
	mov	r4, #0
	str	r3, [fp, #-60]
	str	r4, [fp, #-56]
	mov	r3, #440
	mov	r4, #0
	str	r3, [fp, #-52]
	str	r4, [fp, #-48]
	mov	r3, #64
	mov	r4, #0
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	bne	.L14
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	bne	.L6
	ldr	r3, [fp, #-60]
	cmp	r3, #1
	bhi	.L14
	ldr	r3, [fp, #-60]
	cmp	r3, #1
	b	.L6
.L14:
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	bhi	.L8
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	bne	.L6
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-60]
	cmp	r2, r3
	bhi	.L8
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-60]
	cmp	r2, r3
.L6:
	ldr	r0, .L16
	bl	puts
	mvn	r6, #0
	str	r6, [fp, #-88]
	b	.L10
.L8:
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-48]
	cmp	r2, r3
	bhi	.L11
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-48]
	cmp	r2, r3
	bne	.L15
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-52]
	cmp	r2, r3
	bhi	.L11
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-52]
	cmp	r2, r3
.L15:
	ldr	r0, .L16+4
	bl	puts
	mvn	r3, #0
	str	r3, [fp, #-88]
	b	.L10
.L11:
	sub	r4, fp, #60
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #84
	ldmia	r1, {r0-r1}
	sub	r3, fp, #76
	ldmia	r3, {r2-r3}
	bl	generate_private_exponent
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	sub	r4, fp, #60
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	sub	r4, fp, #44
	ldmia	r4, {r3-r4}
	str	r3, [sp, #16]
	str	r4, [sp, #20]
	sub	r1, fp, #52
	ldmia	r1, {r0-r1}
	sub	r3, fp, #68
	ldmia	r3, {r2-r3}
	bl	test_encrypt_decrypt
	sub	r4, fp, #68
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	sub	r4, fp, #44
	ldmia	r4, {r3-r4}
	str	r3, [sp, #16]
	str	r4, [sp, #20]
	sub	r1, fp, #52
	ldmia	r1, {r0-r1}
	sub	r3, fp, #60
	ldmia	r3, {r2-r3}
	bl	RSA_encryption_decryption
	mov	r5, #0
	str	r5, [fp, #-88]
.L10:
	ldr	r3, [fp, #-88]
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L17:
	.align	2
.L16:
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
