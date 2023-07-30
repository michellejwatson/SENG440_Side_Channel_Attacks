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
	@ args = 16, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7}
	add	r5, sp, #16
	ldmia	r5, {r4-r5}
	add	r7, sp, #24
	ldmia	r7, {r6-r7}
	adds	r4, r4, r2
	adc	r5, r5, r3
	cmp	r7, r5
	mov	ip, r0
	bhi	.L2
	beq	.L8
.L6:
	mov	r0, r4
	mov	r1, r5
	subs	r0, r0, r6
	sbc	r1, r1, r7
	mov	r2, r4
	mov	r3, r5
	b	.L4
.L8:
	cmp	r6, r4
	bls	.L6
.L2:
	mov	r2, r4
	mov	r3, r5
	subs	r2, r2, r6
	sbc	r3, r3, r7
	mov	r0, r4
	mov	r1, r5
.L4:
	stmia	ip, {r0-r1}
	str	r2, [ip, #8]
	str	r3, [ip, #12]
	mov	r0, ip
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
	.size	montgomery_add, .-montgomery_add
	.global	__aeabi_uldivmod
	.align	2
	.global	montgomery_multiplication
	.type	montgomery_multiplication, %function
montgomery_multiplication:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #12
	add	fp, sp, #56
	ldmia	fp, {sl-fp}
	str	r0, [sp, #4]
	mov	r5, r2
	mov	r6, r3
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0
	b	.L17
.L27:
	beq	.L24
.L19:
	mov	r4, r7
	str	r8, [sp, #0]
	subs	r7, r7, sl
	sbc	r8, r8, fp
.L10:
	adds	r0, r5, r5
	adc	r1, r6, r6
	mov	r2, sl
	mov	r3, fp
	bl	__aeabi_uldivmod
	cmp	fp, r3
	mov	r5, r2
	mov	r6, r3
	bhi	.L13
	beq	.L25
.L20:
	adds	r5, r5, r5
	adc	r6, r6, r6
	cmp	fp, r6
	bhi	.L13
	beq	.L26
.L21:
	subs	r5, r5, sl
	sbc	r6, r6, fp
.L13:
	add	r9, r9, #1
	cmp	r9, #64
	beq	.L16
.L28:
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	movs	r3, r3, lsr #1
	mov	r2, r2, rrx
	str	r2, [sp, #48]
	str	r3, [sp, #52]
.L17:
	ldr	r2, [sp, #48]
	and	r3, r2, #1
	cmp	r3, #0
	beq	.L10
	adds	r7, r7, r5
	adc	r8, r8, r6
	cmp	fp, r8
	bls	.L27
	mov	r3, r7
	mov	r4, r8
	subs	r3, r3, sl
	sbc	r4, r4, fp
	str	r4, [sp, #0]
	mov	r4, r3
	b	.L10
.L25:
	cmp	sl, r2
	bls	.L20
	add	r9, r9, #1
	cmp	r9, #64
	bne	.L28
.L16:
	ldr	r3, [sp, #4]
	str	r4, [r3, #8]
	ldr	r4, [sp, #0]
	stmia	r3, {r7-r8}
	str	r4, [r3, #12]
	mov	r0, r3
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L26:
	cmp	sl, r5
	bhi	.L13
	b	.L21
.L24:
	cmp	sl, r7
	bls	.L19
	mov	r3, r7
	mov	r4, r8
	subs	r3, r3, sl
	sbc	r4, r4, fp
	str	r4, [sp, #0]
	mov	r4, r3
	b	.L10
	.size	montgomery_multiplication, .-montgomery_multiplication
	.align	2
	.global	montgomery_modular_exponentiation
	.type	montgomery_modular_exponentiation, %function
montgomery_modular_exponentiation:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	sub	sp, sp, #16
	stmia	sp, {r2-r3}
	mov	r6, r0
	mov	r7, r1
	mov	r2, #1
	mov	r4, #0
	mov	r5, #0
	mov	r8, #0
	b	.L35
.L68:
	adds	r6, r6, r6
	ldr	r1, [sp, #52]
	adc	r7, r7, r7
	cmp	r1, r7
	bhi	.L32
	beq	.L89
.L69:
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r6, r6, r0
	sbc	r7, r7, r1
.L32:
	add	r8, r8, #1
	cmp	r8, #64
	mov	r2, #0
	beq	.L90
.L35:
	and	r3, r2, #1
	cmp	r3, #0
	beq	.L30
	adds	r4, r4, r6
	ldr	r0, [sp, #52]
	adc	r5, r5, r7
	cmp	r0, r5
	bhi	.L30
	beq	.L91
.L67:
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	subs	r4, r4, r2
	sbc	r5, r5, r3
.L30:
	adds	r0, r6, r6
	adc	r1, r7, r7
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r7, r3
	ldr	r3, [sp, #52]
	cmp	r3, r7
	mov	r6, r2
	bhi	.L32
	bne	.L68
	ldr	r0, [sp, #48]
	cmp	r0, r6
	bls	.L68
	add	r8, r8, #1
	cmp	r8, #64
	mov	r2, #0
	bne	.L35
.L90:
	ldmia	sp, {r1, r2}	@ phole ldm
	orrs	r1, r1, r2
	beq	.L36
	ldr	r0, [sp, #0]
	and	r3, r0, #1
	cmp	r3, #0
	mov	r6, #1
	mov	r7, #0
	bne	.L92
.L37:
	str	r6, [sp, #8]
	str	r7, [sp, #12]
.L43:
	mov	r6, r4
	mov	r7, r5
	mov	r8, #0
	mov	r9, #0
	mov	sl, #0
	b	.L51
.L74:
	adds	r4, r4, r4
	ldr	r3, [sp, #52]
	adc	r5, r5, r5
	cmp	r3, r5
	bhi	.L47
	beq	.L93
.L75:
	add	r2, sp, #48
	ldmia	r2, {r1-r2}
	subs	r4, r4, r1
	sbc	r5, r5, r2
.L47:
	add	sl, sl, #1
	cmp	sl, #64
	beq	.L50
.L95:
	movs	r7, r7, lsr #1
	mov	r6, r6, rrx
.L51:
	and	r3, r6, #1
	cmp	r3, #0
	beq	.L45
	adds	r8, r8, r4
	ldr	r2, [sp, #52]
	adc	r9, r9, r5
	cmp	r2, r9
	bhi	.L45
	beq	.L94
.L73:
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r8, r8, r0
	sbc	r9, r9, r1
.L45:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r1, [sp, #52]
	mov	r5, r3
	cmp	r1, r5
	mov	r4, r2
	bhi	.L47
	bne	.L74
	ldr	r2, [sp, #48]
	cmp	r2, r4
	bls	.L74
	add	sl, sl, #1
	cmp	sl, #64
	bne	.L95
.L50:
	ldmia	sp, {r2-r3}
	movs	r3, r3, lsr #1
	mov	r2, r2, rrx
	stmia	sp, {r2-r3}
	orrs	r2, r2, r3
	beq	.L52
	ldr	r0, [sp, #0]
	and	r3, r0, #1
	cmp	r3, #0
	add	r7, sp, #8
	ldmia	r7, {r6-r7}
	mov	r4, r8
	mov	r5, r9
	beq	.L37
.L92:
	mov	r1, #0
	mov	r2, #0
	mov	r8, r4
	mov	r9, r5
	str	r1, [sp, #8]
	str	r2, [sp, #12]
	mov	sl, #0
	b	.L44
.L71:
	adds	r6, r6, r6
	ldr	r3, [sp, #52]
	adc	r7, r7, r7
	cmp	r3, r7
	bhi	.L40
	beq	.L96
.L72:
	add	r2, sp, #48
	ldmia	r2, {r1-r2}
	subs	r6, r6, r1
	sbc	r7, r7, r2
.L40:
	add	sl, sl, #1
	cmp	sl, #64
	beq	.L43
	movs	r9, r9, lsr #1
	mov	r8, r8, rrx
.L44:
	and	r3, r8, #1
	cmp	r3, #0
	beq	.L38
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	ldr	r0, [sp, #52]
	adds	r2, r2, r6
	adc	r3, r3, r7
	cmp	r0, r3
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bhi	.L38
	beq	.L97
.L70:
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r2, r2, r0
	sbc	r3, r3, r1
	str	r2, [sp, #8]
	str	r3, [sp, #12]
.L38:
	adds	r0, r6, r6
	adc	r1, r7, r7
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r1, [sp, #52]
	mov	r7, r3
	cmp	r1, r7
	mov	r6, r2
	bhi	.L40
	bne	.L71
	ldr	r2, [sp, #48]
	cmp	r2, r6
	bhi	.L40
	b	.L71
.L91:
	ldr	r1, [sp, #48]
	cmp	r1, r4
	bhi	.L30
	b	.L67
.L89:
	ldr	r2, [sp, #48]
	cmp	r2, r6
	bhi	.L32
	b	.L69
.L94:
	ldr	r3, [sp, #48]
	cmp	r3, r8
	bhi	.L45
	b	.L73
.L93:
	ldr	r0, [sp, #48]
	cmp	r0, r4
	bhi	.L47
	b	.L75
.L96:
	ldr	r0, [sp, #48]
	cmp	r0, r6
	bhi	.L40
	b	.L72
.L97:
	ldr	r1, [sp, #48]
	cmp	r1, r2
	bhi	.L38
	b	.L70
.L36:
	mov	r3, #1
	mov	r4, #0
	str	r3, [sp, #8]
	str	r4, [sp, #12]
.L52:
	mov	r0, #1
	mov	r4, #0
	mov	r5, #0
	mov	r6, #0
	b	.L59
.L77:
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	ldr	r1, [sp, #52]
	adds	r2, r2, r2
	adc	r3, r3, r3
	cmp	r1, r3
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bhi	.L56
	beq	.L98
.L78:
	add	r1, sp, #8
	ldmia	r1, {r0-r1}
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	subs	r0, r0, r2
	sbc	r1, r1, r3
	str	r0, [sp, #8]
	str	r1, [sp, #12]
.L56:
	add	r6, r6, #1
	cmp	r6, #64
	mov	r0, #0
	mov	r1, #0
	beq	.L99
.L59:
	and	r3, r0, #1
	cmp	r3, #0
	beq	.L54
	add	r1, sp, #8
	ldmia	r1, {r0-r1}
	adds	r4, r4, r0
	adc	r5, r5, r1
	ldr	r1, [sp, #52]
	cmp	r1, r5
	bhi	.L54
	beq	.L100
.L76:
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	subs	r4, r4, r0
	sbc	r5, r5, r1
.L54:
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
	bhi	.L56
	bne	.L77
	ldr	r1, [sp, #48]
	cmp	r1, r2
	bls	.L77
	add	r6, r6, #1
	cmp	r6, #64
	mov	r0, #0
	mov	r1, #0
	bne	.L59
.L99:
	mov	r6, r0
	mov	r7, r1
	mov	r2, #1
	mov	r8, #0
	b	.L65
.L80:
	adds	r4, r4, r4
	ldr	r0, [sp, #52]
	adc	r5, r5, r5
	cmp	r0, r5
	bhi	.L62
	beq	.L101
.L81:
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	subs	r4, r4, r2
	sbc	r5, r5, r3
.L62:
	add	r8, r8, #1
	cmp	r8, #64
	mov	r2, #0
	beq	.L102
.L65:
	and	r3, r2, #1
	cmp	r3, #0
	beq	.L60
	adds	r6, r6, r4
	ldr	r3, [sp, #52]
	adc	r7, r7, r5
	cmp	r3, r7
	bhi	.L60
	beq	.L103
.L79:
	add	r2, sp, #48
	ldmia	r2, {r1-r2}
	subs	r6, r6, r1
	sbc	r7, r7, r2
.L60:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r4, r2
	ldr	r2, [sp, #52]
	mov	r5, r3
	cmp	r2, r5
	bhi	.L62
	bne	.L80
	ldr	r3, [sp, #48]
	cmp	r3, r4
	bls	.L80
	add	r8, r8, #1
	cmp	r8, #64
	mov	r2, #0
	bne	.L65
.L102:
	mov	r1, r7
	mov	r0, r6
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L100:
	ldr	r2, [sp, #48]
	cmp	r2, r4
	bhi	.L54
	b	.L76
.L98:
	ldr	r3, [sp, #48]
	cmp	r3, r2
	bhi	.L56
	b	.L78
.L103:
	ldr	r0, [sp, #48]
	cmp	r0, r6
	bhi	.L60
	b	.L79
.L101:
	ldr	r1, [sp, #48]
	cmp	r1, r4
	bhi	.L62
	b	.L81
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
	ldr	r0, .L106+8
	bl	puts
	rsb	r4, sl, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L106+12
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fldd	d8, .L106
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L106+16
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
	ldr	r0, .L106+20
	bl	puts
	rsb	r4, r7, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L106+24
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L106+28
	bl	printf
	bl	rand
	ldr	r3, .L106+32
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
.L107:
	.align	3
.L106:
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
	b	.L114
.L123:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r9, r5
	bhi	.L111
	beq	.L132
.L124:
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L111:
	add	sl, sl, #1
	cmp	sl, #64
	mov	r0, #0
	mov	r1, #0
	beq	.L133
.L114:
	and	r3, r0, #1
	cmp	r3, #0
	beq	.L109
	adds	r6, r6, r4
	adc	r7, r7, r5
	cmp	r9, r7
	bhi	.L109
	beq	.L134
.L122:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L109:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L111
	bne	.L123
	cmp	r8, r2
	bls	.L123
	add	sl, sl, #1
	cmp	sl, #64
	mov	r0, #0
	mov	r1, #0
	bne	.L114
.L133:
	mov	sl, r0
	mov	fp, r1
	mov	r3, #1
	mov	r5, #0
	b	.L120
.L126:
	adds	r6, r6, r6
	adc	r7, r7, r7
	cmp	r9, r7
	bhi	.L117
	beq	.L135
.L127:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L117:
	add	r5, r5, #1
	cmp	r5, #64
	mov	r3, #0
	mov	r4, #0
	beq	.L136
.L120:
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L115
	adds	sl, sl, r6
	adc	fp, fp, r7
	cmp	r9, fp
	bhi	.L115
	beq	.L137
.L125:
	subs	sl, sl, r8
	sbc	fp, fp, r9
.L115:
	adds	r0, r6, r6
	adc	r1, r7, r7
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r6, r2
	mov	r7, r3
	bhi	.L117
	bne	.L126
	cmp	r8, r2
	bls	.L126
	add	r5, r5, #1
	cmp	r5, #64
	mov	r3, #0
	mov	r4, #0
	bne	.L120
.L136:
	mov	r1, fp
	mov	r0, sl
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L134:
	cmp	r8, r6
	bhi	.L109
	b	.L122
.L132:
	cmp	r8, r4
	bhi	.L111
	b	.L124
.L137:
	cmp	r8, sl
	bhi	.L115
	b	.L125
.L135:
	cmp	r8, r6
	bhi	.L117
	b	.L127
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
