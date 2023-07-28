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
	.file	"RSA_functions.c"
	.text
	.align	2
	.global	montgomery_add
	.type	montgomery_add, %function
montgomery_add:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5}
	adds	r2, r2, r0
	add	r5, sp, #8
	ldmia	r5, {r4-r5}
	adc	r3, r3, r1
	cmp	r5, r3
	bhi	.L2
	beq	.L7
.L5:
	subs	r2, r2, r4
	sbc	r3, r3, r5
.L2:
	mov	r1, r3
	mov	r0, r2
	ldmfd	sp!, {r4, r5}
	bx	lr
.L7:
	cmp	r4, r2
	bhi	.L2
	b	.L5
	.size	montgomery_add, .-montgomery_add
	.global	__aeabi_uldivmod
	.align	2
	.global	montgomery_multiplication
	.type	montgomery_multiplication, %function
montgomery_multiplication:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r9, r3
	sub	sp, sp, #12
	mov	r3, #0
	add	fp, sp, #48
	ldmia	fp, {sl-fp}
	mov	r4, r0
	mov	r5, r1
	mov	r8, r2
	mov	r6, #0
	mov	r7, #0
	str	r3, [sp, #4]
	b	.L15
.L18:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	fp, r5
	bhi	.L11
	beq	.L21
.L19:
	subs	r4, r4, sl
	sbc	r5, r5, fp
.L11:
	ldr	r3, [sp, #4]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #4]
	beq	.L14
.L23:
	movs	r9, r9, lsr #1
	mov	r8, r8, rrx
.L15:
	and	r3, r8, #1
	cmp	r3, #0
	beq	.L9
	adds	r6, r6, r4
	adc	r7, r7, r5
	cmp	fp, r7
	bhi	.L9
	beq	.L22
.L17:
	subs	r6, r6, sl
	sbc	r7, r7, fp
.L9:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, sl
	mov	r3, fp
	bl	__aeabi_uldivmod
	cmp	fp, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L11
	bne	.L18
	cmp	sl, r2
	bls	.L18
	ldr	r3, [sp, #4]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #4]
	bne	.L23
.L14:
	mov	r1, r7
	mov	r0, r6
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L22:
	cmp	sl, r6
	bhi	.L9
	b	.L17
.L21:
	cmp	sl, r4
	bhi	.L11
	b	.L19
	.size	montgomery_multiplication, .-montgomery_multiplication
	.align	2
	.global	montgomery_modular_exponentiation
	.type	montgomery_modular_exponentiation, %function
montgomery_modular_exponentiation:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
	sub	sp, sp, #16
	stmia	sp, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	mov	r2, #1
	mov	sl, #0
	mov	fp, #0
	mov	r6, #0
	b	.L30
.L63:
	adds	r4, r4, r4
	ldr	r1, [sp, #52]
	adc	r5, r5, r5
	cmp	r1, r5
	bhi	.L27
	beq	.L84
.L64:
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r4, r4, r0
	sbc	r5, r5, r1
.L27:
	add	r6, r6, #1
	cmp	r6, #64
	mov	r2, #0
	beq	.L85
.L30:
	and	r3, r2, #1
	cmp	r3, #0
	beq	.L25
	adds	sl, sl, r4
	ldr	r0, [sp, #52]
	adc	fp, fp, r5
	cmp	r0, fp
	bhi	.L25
	beq	.L86
.L62:
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	subs	sl, sl, r2
	sbc	fp, fp, r3
.L25:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r5, r3
	ldr	r3, [sp, #52]
	cmp	r3, r5
	mov	r4, r2
	bhi	.L27
	bne	.L63
	ldr	r0, [sp, #48]
	cmp	r0, r4
	bls	.L63
	add	r6, r6, #1
	cmp	r6, #64
	mov	r2, #0
	bne	.L30
.L85:
	ldmia	sp, {r1, r2}	@ phole ldm
	orrs	r1, r1, r2
	beq	.L31
	ldr	r0, [sp, #0]
	and	r3, r0, #1
	cmp	r3, #0
	mov	r4, #1
	mov	r5, #0
	bne	.L87
.L32:
	str	r4, [sp, #8]
	str	r5, [sp, #12]
.L38:
	mov	r4, sl
	mov	r5, fp
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	b	.L46
.L69:
	adds	r4, r4, r4
	ldr	r3, [sp, #52]
	adc	r5, r5, r5
	cmp	r3, r5
	bhi	.L42
	beq	.L88
.L70:
	add	r2, sp, #48
	ldmia	r2, {r1-r2}
	subs	r4, r4, r1
	sbc	r5, r5, r2
.L42:
	add	r8, r8, #1
	cmp	r8, #64
	beq	.L45
.L90:
	movs	fp, fp, lsr #1
	mov	sl, sl, rrx
.L46:
	and	r3, sl, #1
	cmp	r3, #0
	beq	.L40
	adds	r6, r6, r4
	ldr	r2, [sp, #52]
	adc	r7, r7, r5
	cmp	r2, r7
	bhi	.L40
	beq	.L89
.L68:
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r6, r6, r0
	sbc	r7, r7, r1
.L40:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r1, [sp, #52]
	mov	r5, r3
	cmp	r1, r5
	mov	r4, r2
	bhi	.L42
	bne	.L69
	ldr	r2, [sp, #48]
	cmp	r2, r4
	bls	.L69
	add	r8, r8, #1
	cmp	r8, #64
	bne	.L90
.L45:
	ldmia	sp, {r2-r3}
	movs	r3, r3, lsr #1
	mov	r2, r2, rrx
	stmia	sp, {r2-r3}
	orrs	r2, r2, r3
	beq	.L47
	ldr	r0, [sp, #0]
	and	r3, r0, #1
	cmp	r3, #0
	add	r5, sp, #8
	ldmia	r5, {r4-r5}
	mov	sl, r6
	mov	fp, r7
	beq	.L32
.L87:
	mov	r1, #0
	mov	r2, #0
	mov	r6, sl
	mov	r7, fp
	str	r1, [sp, #8]
	str	r2, [sp, #12]
	mov	r8, #0
	b	.L39
.L66:
	adds	r4, r4, r4
	ldr	r3, [sp, #52]
	adc	r5, r5, r5
	cmp	r3, r5
	bhi	.L35
	beq	.L91
.L67:
	add	r2, sp, #48
	ldmia	r2, {r1-r2}
	subs	r4, r4, r1
	sbc	r5, r5, r2
.L35:
	add	r8, r8, #1
	cmp	r8, #64
	beq	.L38
	movs	r7, r7, lsr #1
	mov	r6, r6, rrx
.L39:
	and	r3, r6, #1
	cmp	r3, #0
	beq	.L33
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	ldr	r0, [sp, #52]
	adds	r2, r2, r4
	adc	r3, r3, r5
	cmp	r0, r3
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bhi	.L33
	beq	.L92
.L65:
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r2, r2, r0
	sbc	r3, r3, r1
	str	r2, [sp, #8]
	str	r3, [sp, #12]
.L33:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r1, [sp, #52]
	mov	r5, r3
	cmp	r1, r5
	mov	r4, r2
	bhi	.L35
	bne	.L66
	ldr	r2, [sp, #48]
	cmp	r2, r4
	bhi	.L35
	b	.L66
.L86:
	ldr	r1, [sp, #48]
	cmp	r1, sl
	bhi	.L25
	b	.L62
.L84:
	ldr	r2, [sp, #48]
	cmp	r2, r4
	bhi	.L27
	b	.L64
.L89:
	ldr	r3, [sp, #48]
	cmp	r3, r6
	bhi	.L40
	b	.L68
.L88:
	ldr	r0, [sp, #48]
	cmp	r0, r4
	bhi	.L42
	b	.L70
.L91:
	ldr	r0, [sp, #48]
	cmp	r0, r4
	bhi	.L35
	b	.L67
.L92:
	ldr	r1, [sp, #48]
	cmp	r1, r2
	bhi	.L33
	b	.L65
.L31:
	mov	r3, #1
	mov	r4, #0
	str	r3, [sp, #8]
	str	r4, [sp, #12]
.L47:
	mov	r0, #1
	mov	r4, #0
	mov	r5, #0
	mov	r6, #0
	b	.L54
.L72:
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	ldr	r1, [sp, #52]
	adds	r2, r2, r2
	adc	r3, r3, r3
	cmp	r1, r3
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bhi	.L51
	beq	.L93
.L73:
	add	r1, sp, #8
	ldmia	r1, {r0-r1}
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	subs	r0, r0, r2
	sbc	r1, r1, r3
	str	r0, [sp, #8]
	str	r1, [sp, #12]
.L51:
	add	r6, r6, #1
	cmp	r6, #64
	mov	r0, #0
	mov	r1, #0
	beq	.L94
.L54:
	and	r3, r0, #1
	cmp	r3, #0
	beq	.L49
	add	r1, sp, #8
	ldmia	r1, {r0-r1}
	adds	r4, r4, r0
	adc	r5, r5, r1
	ldr	r1, [sp, #52]
	cmp	r1, r5
	bhi	.L49
	beq	.L95
.L71:
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r4, r4, r0
	sbc	r5, r5, r1
.L49:
	add	r1, sp, #8
	ldmia	r1, {r0-r1}
	adds	r0, r0, r0
	adc	r1, r1, r1
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r0, [sp, #52]
	cmp	r0, r3
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bhi	.L51
	bne	.L72
	ldr	r1, [sp, #48]
	cmp	r1, r2
	bls	.L72
	add	r6, r6, #1
	cmp	r6, #64
	mov	r0, #0
	mov	r1, #0
	bne	.L54
.L94:
	mov	r6, r0
	mov	r7, r1
	mov	r2, #1
	mov	r8, #0
	b	.L60
.L75:
	adds	r4, r4, r4
	ldr	r0, [sp, #52]
	adc	r5, r5, r5
	cmp	r0, r5
	bhi	.L57
	beq	.L96
.L76:
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	subs	r4, r4, r2
	sbc	r5, r5, r3
.L57:
	add	r8, r8, #1
	cmp	r8, #64
	mov	r2, #0
	beq	.L97
.L60:
	and	r3, r2, #1
	cmp	r3, #0
	beq	.L55
	adds	r6, r6, r4
	ldr	r3, [sp, #52]
	adc	r7, r7, r5
	cmp	r3, r7
	bhi	.L55
	beq	.L98
.L74:
	add	r2, sp, #48
	ldmia	r2, {r1-r2}
	subs	r6, r6, r1
	sbc	r7, r7, r2
.L55:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r4, r2
	ldr	r2, [sp, #52]
	mov	r5, r3
	cmp	r2, r5
	bhi	.L57
	bne	.L75
	ldr	r3, [sp, #48]
	cmp	r3, r4
	bls	.L75
	add	r8, r8, #1
	cmp	r8, #64
	mov	r2, #0
	bne	.L60
.L97:
	mov	r1, r7
	mov	r0, r6
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
	bx	lr
.L95:
	ldr	r2, [sp, #48]
	cmp	r2, r4
	bhi	.L49
	b	.L71
.L93:
	ldr	r3, [sp, #48]
	cmp	r3, r2
	bhi	.L51
	b	.L73
.L98:
	ldr	r0, [sp, #48]
	cmp	r0, r6
	bhi	.L55
	b	.L74
.L96:
	ldr	r1, [sp, #48]
	cmp	r1, r4
	bhi	.L57
	b	.L76
	.size	montgomery_modular_exponentiation, .-montgomery_modular_exponentiation
	.align	2
	.global	RSA_encryption_decryption
	.type	RSA_encryption_decryption, %function
RSA_encryption_decryption:
	@ Function supports interworking.
	@ args = 24, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	fstmfdd	sp!, {d8}
	sub	sp, sp, #16
	add	r9, sp, #56
	ldmia	r9, {r8-r9}
	mov	r6, r0
	mov	r7, r1
	mov	r4, r2
	mov	r5, r3
	bl	clock
	mov	r2, r4
	mov	r3, r5
	add	r5, sp, #72
	ldmia	r5, {r4-r5}
	mov	sl, r0
	mov	r1, r7
	mov	r0, r6
	str	r4, [sp, #8]
	str	r5, [sp, #12]
	stmia	sp, {r8-r9}
	bl	montgomery_modular_exponentiation
	mov	r6, r1
	mov	r5, r0
	bl	clock
	mov	r4, r0
	ldr	r0, .L101+8
	bl	puts
	rsb	r4, sl, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L101+12
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fldd	d8, .L101
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L101+16
	bl	printf
	bl	clock
	mov	r7, r0
	mov	r0, r5
	add	r5, sp, #72
	ldmia	r5, {r4-r5}
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	mov	r1, r6
	str	r4, [sp, #8]
	str	r5, [sp, #12]
	stmia	sp, {r8-r9}
	bl	montgomery_modular_exponentiation
	mov	r6, r1
	mov	r5, r0
	bl	clock
	mov	r4, r0
	ldr	r0, .L101+20
	bl	puts
	rsb	r4, r7, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L101+24
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L101+28
	bl	printf
	bl	rand
	ldr	r3, .L101+32
	smull	r2, r1, r3, r0
	mov	r2, r0, asr #31
	rsb	r2, r2, r1, asr #1
	mov	r3, r2, asl #2
	add	r3, r3, r2
	rsb	r0, r3, r0
	add	r0, r0, #1
	bl	sleep
	add	sp, sp, #16
	fldmfdd	sp!, {d8}
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L102:
	.align	3
.L101:
	.word	0
	.word	1093567616
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	1717986919
	.size	RSA_encryption_decryption, .-RSA_encryption_decryption
	.align	2
	.global	montgomery_modular_reduction
	.type	montgomery_modular_reduction, %function
montgomery_modular_reduction:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r4, r0
	mov	r5, r1
	mov	r8, r2
	mov	r9, r3
	mov	r0, #1
	mov	r6, #0
	mov	r7, #0
	mov	sl, #0
	b	.L109
.L118:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r9, r5
	bhi	.L106
	beq	.L127
.L119:
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L106:
	add	sl, sl, #1
	cmp	sl, #64
	mov	r0, #0
	mov	r1, #0
	beq	.L128
.L109:
	and	r3, r0, #1
	cmp	r3, #0
	beq	.L104
	adds	r6, r6, r4
	adc	r7, r7, r5
	cmp	r9, r7
	bhi	.L104
	beq	.L129
.L117:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L104:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L106
	bne	.L118
	cmp	r8, r2
	bls	.L118
	add	sl, sl, #1
	cmp	sl, #64
	mov	r0, #0
	mov	r1, #0
	bne	.L109
.L128:
	mov	sl, r0
	mov	fp, r1
	mov	r3, #1
	mov	r5, #0
	b	.L115
.L121:
	adds	r6, r6, r6
	adc	r7, r7, r7
	cmp	r9, r7
	bhi	.L112
	beq	.L130
.L122:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L112:
	add	r5, r5, #1
	cmp	r5, #64
	mov	r3, #0
	mov	r4, #0
	beq	.L131
.L115:
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L110
	adds	sl, sl, r6
	adc	fp, fp, r7
	cmp	r9, fp
	bhi	.L110
	beq	.L132
.L120:
	subs	sl, sl, r8
	sbc	fp, fp, r9
.L110:
	adds	r0, r6, r6
	adc	r1, r7, r7
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r6, r2
	mov	r7, r3
	bhi	.L112
	bne	.L121
	cmp	r8, r2
	bls	.L121
	add	r5, r5, #1
	cmp	r5, #64
	mov	r3, #0
	mov	r4, #0
	bne	.L115
.L131:
	mov	r1, fp
	mov	r0, sl
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L129:
	cmp	r8, r6
	bhi	.L104
	b	.L117
.L127:
	cmp	r8, r4
	bhi	.L106
	b	.L119
.L132:
	cmp	r8, sl
	bhi	.L110
	b	.L120
.L130:
	cmp	r8, r6
	bhi	.L112
	b	.L122
	.size	montgomery_modular_reduction, .-montgomery_modular_reduction
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"********** RSA Encryption **********\000"
	.space	3
.LC1:
	.ascii	"RSA Encryption Ciphertext: %llu\012\000"
	.space	3
.LC2:
	.ascii	"Time to execute encrypt: %.7f\012\000"
	.space	1
.LC3:
	.ascii	"********** RSA Decryption **********\000"
	.space	3
.LC4:
	.ascii	"Decrypted: %llu\012\000"
	.space	3
.LC5:
	.ascii	"Time to execute decrypt: %.7f\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
