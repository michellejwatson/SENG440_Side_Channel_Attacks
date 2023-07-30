	.arch armv4t
	.eabi_attribute 27, 3
	.fpu neon
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"RSA_Routine.c"
	.global	__aeabi_uldivmod
	.text
	.align	2
	.global	RSA_Routine
	.type	RSA_Routine, %function
RSA_Routine:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #12
	ldr	r4, [sp, #48]
	cmp	r4, #0
	mov	r8, r0
	mov	fp, r1
	mov	sl, r3
	beq	.L2
	mov	r1, r2
	mov	r2, #0
	mov	r3, #1
	mov	r4, #0
	and	r5, r1, r3
	and	r6, r2, r4
	mov	r9, sl
	mov	r7, #0
.L5:
	mov	ip, fp, lsr r7
	mov	r1, ip
	mov	r2, #0
	mov	r3, r1
	mov	r1, #1
	and	r3, r3, r1
	mul	lr, r3, r6
	mov	r4, r2
	mov	r2, #0
	and	r4, r4, r2
	mla	r2, r5, r4, lr
	umull	r0, r1, r3, r5
	eor	ip, r8, ip
	add	r1, r2, r1
	and	ip, ip, #1
	mov	r2, r9
	mov	r3, #0
	mla	r4, sl, ip, r8
	bl	__aeabi_uldivmod
	add	r4, r4, r2
	mov	r4, r4, lsr #1
	ldr	r2, [sp, #48]
	cmp	sl, r4
	add	r7, r7, #1
	rsb	r3, sl, r4
	movhi	r8, r4
	movls	r8, r3
	cmp	r2, r7
	bhi	.L5
.L2:
	mov	r0, r8
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	RSA_Routine, .-RSA_Routine
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r1, #0
	mov	r0, r1
	mov	ip, #17
.L12:
	eor	r3, r1, ip, lsr r0
	and	r3, r3, #1
	mov	r2, r3, asl #5
	sub	r2, r2, r3, asl #3
	rsb	r2, r3, r2
	add	r2, r2, r1
	mov	r2, r2, lsr #1
	cmp	r2, #22
	add	r0, r0, #1
	sub	r3, r2, #23
	movls	r1, r2
	movhi	r1, r3
	cmp	r0, #32
	bne	.L12
	ldr	r0, .L15
	bl	printf
	mov	r0, #0
	ldmfd	sp!, {r4, lr}
	bx	lr
.L16:
	.align	2
.L15:
	.word	.LC0
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Z = %u\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
