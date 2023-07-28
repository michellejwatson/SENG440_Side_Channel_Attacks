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
	.file	"while_exponentiation_optimization.c"
	.text
	.align	2
	.global	montgomery_add
	.type	montgomery_add, %function
montgomery_add:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, fp}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-20]
	str	r1, [fp, #-16]
	str	r2, [fp, #-28]
	str	r3, [fp, #-24]
	sub	r2, fp, #20
	ldmia	r2, {r1-r2}
	sub	r4, fp, #28
	ldmia	r4, {r3-r4}
	adds	r3, r3, r1
	adc	r4, r4, r2
	str	r3, [fp, #-12]
	str	r4, [fp, #-8]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bhi	.L2
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bne	.L5
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	bhi	.L2
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
.L5:
	sub	r4, fp, #12
	ldmia	r4, {r3-r4}
	ldmib	fp, {r1-r2}
	subs	r3, r3, r1
	sbc	r4, r4, r2
	str	r3, [fp, #-12]
	str	r4, [fp, #-8]
.L2:
	sub	r4, fp, #12
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
	@ args = 8, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #44
	str	r0, [fp, #-36]
	str	r1, [fp, #-32]
	str	r2, [fp, #-44]
	str	r3, [fp, #-40]
	mov	r3, #0
	mov	r4, #0
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L7
.L11:
	ldr	r3, [fp, #-44]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L8
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #28
	ldmia	r1, {r0-r1}
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	bl	montgomery_add
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
.L8:
	sub	r4, fp, #36
	ldmia	r4, {r3-r4}
	adds	r3, r3, r3
	adc	r4, r4, r4
	mov	r0, r3
	mov	r1, r4
	ldmib	fp, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r4, r3
	mov	r3, r2
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	sub	r4, fp, #44
	ldmia	r4, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	bhi	.L9
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	bne	.L13
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	bhi	.L9
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
.L13:
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #36
	ldmia	r1, {r0-r1}
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	bl	montgomery_add
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
.L9:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L7:
	ldr	r3, [fp, #-16]
	cmp	r3, #63
	ble	.L11
	sub	r4, fp, #28
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
	@ args = 24, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #84
	str	r0, [fp, #-52]
	str	r1, [fp, #-48]
	str	r2, [fp, #-60]
	str	r3, [fp, #-56]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	mov	r3, #1
	mov	r4, #0
	str	r3, [fp, #-36]
	str	r4, [fp, #-32]
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #52
	ldmia	r1, {r0-r1}
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	mov	r3, #0
	mov	r4, #0
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	mov	r2, #0
	str	r2, [fp, #-64]
	b	.L17
.L20:
	ldr	r3, [fp, #-60]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L18
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #44
	ldmia	r1, {r0-r1}
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-44]
	str	r4, [fp, #-40]
	b	.L19
.L18:
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
.L19:
	ldmib	fp, {r3-r4}
	stmia	sp, {r3-r4}
	sub	r1, fp, #28
	ldmia	r1, {r0-r1}
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	bl	montgomery_multiplication
	mov	r3, r0
	mov	r4, r1
	str	r3, [fp, #-28]
	str	r4, [fp, #-24]
	sub	r4, fp, #60
	ldmia	r4, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	str	r3, [fp, #-60]
	str	r4, [fp, #-56]
	ldr	r3, [fp, #-64]
	add	r3, r3, #1
	str	r3, [fp, #-64]
.L17:
	ldr	r3, [fp, #-64]
	mov	r2, r3
	mov	r3, r2, asr #31
	str	r2, [fp, #-76]
	str	r3, [fp, #-72]
	ldr	r3, [fp, #24]
	ldr	r4, [fp, #-72]
	cmp	r3, r4
	bhi	.L20
	ldr	r3, [fp, #24]
	ldr	r2, [fp, #-72]
	cmp	r3, r2
	bne	.L23
	ldr	r3, [fp, #20]
	ldr	r4, [fp, #-76]
	cmp	r3, r4
	bhi	.L20
	ldr	r3, [fp, #20]
	ldr	r2, [fp, #-76]
	cmp	r3, r2
.L23:
	add	r4, fp, #12
	ldmia	r4, {r3-r4}
	stmia	sp, {r3-r4}
	add	r4, fp, #20
	ldmia	r4, {r3-r4}
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	sub	r1, fp, #44
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
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
