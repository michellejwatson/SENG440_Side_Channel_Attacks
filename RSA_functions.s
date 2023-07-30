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
	@ args = 16, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r4, r2
	sub	sp, sp, #28
	mov	r2, #0
	mov	r5, r3
	mov	r3, #0
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	mov	r9, r3
	mov	r3, #0
	add	fp, sp, #64
	ldmia	fp, {sl-fp}
	add	r7, sp, #72
	ldmia	r7, {r6-r7}
	str	r0, [sp, #4]
	mov	r8, r2
	str	r3, [sp, #20]
	b	.L18
.L28:
	adds	r8, r8, r4
	adc	r9, r9, r5
	cmp	r7, r9
	bhi	.L11
	beq	.L25
.L20:
	subs	r8, r8, r6
	sbc	r9, r9, r7
.L11:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r6
	mov	r3, r7
	bl	__aeabi_uldivmod
	cmp	r7, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L14
	beq	.L26
.L22:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r7, r5
	bhi	.L14
	beq	.L27
.L23:
	subs	r4, r4, r6
	sbc	r5, r5, r7
.L14:
	ldr	r3, [sp, #20]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #20]
	beq	.L17
.L29:
	movs	fp, fp, lsr #1
	mov	sl, sl, rrx
.L18:
	and	r3, sl, #1
	cmp	r3, #0
	bne	.L28
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	adds	r2, r2, r4
	adc	r3, r3, r5
	cmp	r7, r3
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bhi	.L21
	bne	.L11
	cmp	r6, r2
	bls	.L11
.L21:
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	subs	r2, r2, r6
	sbc	r3, r3, r7
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	b	.L11
.L26:
	cmp	r6, r2
	bls	.L22
	ldr	r3, [sp, #20]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #20]
	bne	.L29
.L17:
	ldr	r4, [sp, #4]
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	stmia	r4, {r8-r9}
	str	r2, [r4, #8]
	str	r3, [r4, #12]
	mov	r0, r4
	add	sp, sp, #28
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L27:
	cmp	r6, r4
	bhi	.L14
	b	.L23
.L25:
	cmp	r6, r8
	bhi	.L11
	b	.L20
	.size	montgomery_multiplication, .-montgomery_multiplication
	.align	2
	.global	montgomery_modular_reduction
	.type	montgomery_modular_reduction, %function
montgomery_modular_reduction:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r6, #0
	sub	sp, sp, #20
	mov	r7, #0
	mov	r9, r3
	mov	r3, #0
	mov	r4, r0
	mov	r5, r1
	mov	r8, r2
	mov	r0, #1
	mov	sl, r6
	mov	fp, r7
	str	r3, [sp, #12]
	b	.L38
.L64:
	adds	r6, r6, r4
	adc	r7, r7, r5
	cmp	r9, r7
	bhi	.L32
	beq	.L60
.L48:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L32:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L35
	beq	.L61
.L50:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r9, r5
	bhi	.L35
	beq	.L62
.L51:
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L35:
	ldr	r3, [sp, #12]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #12]
	mov	r0, #0
	mov	r1, #0
	beq	.L63
.L38:
	and	r3, r0, #1
	cmp	r3, #0
	bne	.L64
	adds	sl, sl, r4
	adc	fp, fp, r5
	cmp	r9, fp
	bhi	.L49
	bne	.L32
	cmp	r8, sl
	bls	.L32
.L49:
	subs	sl, sl, r8
	sbc	fp, fp, r9
	b	.L32
.L61:
	cmp	r8, r2
	bls	.L50
	ldr	r3, [sp, #12]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #12]
	mov	r0, #0
	mov	r1, #0
	bne	.L38
.L63:
	mov	sl, r0
	mov	fp, r1
	mov	r3, #1
	stmia	sp, {sl-fp}
	mov	r5, #0
	b	.L46
.L69:
	adds	sl, sl, r6
	adc	fp, fp, r7
	cmp	r9, fp
	bhi	.L40
	beq	.L65
.L52:
	subs	sl, sl, r8
	sbc	fp, fp, r9
.L40:
	adds	r0, r6, r6
	adc	r1, r7, r7
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r6, r2
	mov	r7, r3
	bhi	.L43
	beq	.L66
.L54:
	adds	r6, r6, r6
	adc	r7, r7, r7
	cmp	r9, r7
	bhi	.L43
	beq	.L67
.L55:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L43:
	add	r5, r5, #1
	cmp	r5, #64
	mov	r3, #0
	mov	r4, #0
	beq	.L68
.L46:
	and	r3, r3, #1
	cmp	r3, #0
	bne	.L69
	ldmia	sp, {r3-r4}
	adds	r3, r3, r6
	adc	r4, r4, r7
	cmp	r9, r4
	stmia	sp, {r3-r4}
	bhi	.L53
	bne	.L40
	cmp	r8, r3
	bls	.L40
.L53:
	ldmia	sp, {r3-r4}
	subs	r3, r3, r8
	sbc	r4, r4, r9
	stmia	sp, {r3-r4}
	b	.L40
.L62:
	cmp	r8, r4
	bhi	.L35
	b	.L51
.L60:
	cmp	r8, r6
	bhi	.L32
	b	.L48
.L66:
	cmp	r8, r2
	bls	.L54
	add	r5, r5, #1
	cmp	r5, #64
	mov	r3, #0
	mov	r4, #0
	bne	.L46
.L68:
	mov	r1, fp
	mov	r0, sl
	add	sp, sp, #20
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L67:
	cmp	r8, r6
	bhi	.L43
	b	.L55
.L65:
	cmp	r8, sl
	bhi	.L40
	b	.L52
	.size	montgomery_modular_reduction, .-montgomery_modular_reduction
	.align	2
	.global	montgomery_modular_exponentiation
	.type	montgomery_modular_exponentiation, %function
montgomery_modular_exponentiation:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r4, #0
	sub	sp, sp, #28
	mov	r5, #0
	stmia	sp, {r2-r3}
	mov	r6, r0
	mov	r7, r1
	mov	r2, #1
	mov	r8, r4
	mov	r9, r5
	mov	sl, #0
	b	.L78
.L149:
	adds	r4, r4, r6
	ldr	r0, [sp, #68]
	adc	r5, r5, r7
	cmp	r0, r5
	bhi	.L72
	beq	.L145
.L118:
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	subs	r4, r4, r2
	sbc	r5, r5, r3
.L72:
	adds	r0, r6, r6
	adc	r1, r7, r7
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r6, r2
	ldr	r2, [sp, #68]
	mov	r7, r3
	cmp	r2, r7
	bhi	.L75
	beq	.L146
.L120:
	adds	r6, r6, r6
	ldr	r0, [sp, #68]
	adc	r7, r7, r7
	cmp	r0, r7
	bhi	.L75
	beq	.L147
.L121:
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	subs	r6, r6, r2
	sbc	r7, r7, r3
.L75:
	add	sl, sl, #1
	cmp	sl, #64
	mov	r2, #0
	beq	.L148
.L78:
	and	r3, r2, #1
	cmp	r3, #0
	bne	.L149
	adds	r8, r8, r6
	ldr	r3, [sp, #68]
	adc	r9, r9, r7
	cmp	r3, r9
	bhi	.L119
	bne	.L72
	ldr	r0, [sp, #64]
	cmp	r0, r8
	bls	.L72
.L119:
	add	r2, sp, #64
	ldmia	r2, {r1-r2}
	subs	r8, r8, r1
	sbc	r9, r9, r2
	b	.L72
.L146:
	ldr	r3, [sp, #64]
	cmp	r3, r6
	bls	.L120
	add	sl, sl, #1
	cmp	sl, #64
	mov	r2, #0
	bne	.L78
.L148:
	ldmia	sp, {r3, r6}	@ phole ldm
	orrs	r3, r3, r6
	beq	.L79
	ldr	r0, [sp, #0]
	and	r3, r0, #1
	cmp	r3, #0
	mov	r6, #1
	mov	r7, #0
	bne	.L150
.L80:
	str	r6, [sp, #16]
	str	r7, [sp, #20]
.L88:
	mov	r8, #0
	mov	r9, #0
	mov	r0, #0
	mov	r6, r4
	mov	r7, r5
	mov	sl, r8
	mov	fp, r9
	str	r0, [sp, #8]
	b	.L98
.L154:
	adds	r8, r8, r4
	ldr	r1, [sp, #68]
	adc	r9, r9, r5
	cmp	r1, r9
	bhi	.L91
	beq	.L151
.L126:
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	subs	r8, r8, r0
	sbc	r9, r9, r1
.L91:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r1, [sp, #68]
	mov	r5, r3
	cmp	r1, r5
	mov	r4, r2
	bhi	.L94
	beq	.L152
.L128:
	adds	r4, r4, r4
	ldr	r3, [sp, #68]
	adc	r5, r5, r5
	cmp	r3, r5
	bhi	.L94
	beq	.L153
.L129:
	add	r2, sp, #64
	ldmia	r2, {r1-r2}
	subs	r4, r4, r1
	sbc	r5, r5, r2
.L94:
	ldr	r2, [sp, #8]
	add	r2, r2, #1
	cmp	r2, #64
	str	r2, [sp, #8]
	beq	.L97
.L155:
	movs	r7, r7, lsr #1
	mov	r6, r6, rrx
.L98:
	and	r3, r6, #1
	cmp	r3, #0
	bne	.L154
	adds	sl, sl, r4
	ldr	r1, [sp, #68]
	adc	fp, fp, r5
	cmp	r1, fp
	bhi	.L127
	bne	.L91
	ldr	r2, [sp, #64]
	cmp	r2, sl
	bls	.L91
.L127:
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	subs	sl, sl, r0
	sbc	fp, fp, r1
	b	.L91
.L147:
	ldr	r1, [sp, #64]
	cmp	r1, r6
	bhi	.L75
	b	.L121
.L145:
	ldr	r1, [sp, #64]
	cmp	r1, r4
	bhi	.L72
	b	.L118
.L152:
	ldr	r2, [sp, #64]
	cmp	r2, r4
	bls	.L128
	ldr	r2, [sp, #8]
	add	r2, r2, #1
	cmp	r2, #64
	str	r2, [sp, #8]
	bne	.L155
.L97:
	ldmia	sp, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	stmia	sp, {r3-r4}
	orrs	r3, r3, r4
	beq	.L99
	ldr	r0, [sp, #0]
	and	r3, r0, #1
	cmp	r3, #0
	mov	r4, r8
	mov	r5, r9
	add	r7, sp, #16
	ldmia	r7, {r6-r7}
	beq	.L80
.L150:
	mov	r2, #0
	mov	r1, #0
	str	r1, [sp, #16]
	str	r2, [sp, #20]
	mov	fp, r2
	mov	r2, #0
	mov	r8, r4
	mov	r9, r5
	mov	sl, r1
	str	r2, [sp, #12]
	b	.L89
.L159:
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	ldr	r2, [sp, #68]
	adds	r0, r0, r6
	adc	r1, r1, r7
	cmp	r2, r1
	str	r0, [sp, #16]
	str	r1, [sp, #20]
	bhi	.L82
	beq	.L156
.L122:
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	subs	r0, r0, r2
	sbc	r1, r1, r3
	str	r0, [sp, #16]
	str	r1, [sp, #20]
.L82:
	adds	r0, r6, r6
	adc	r1, r7, r7
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	mov	r6, r2
	ldr	r2, [sp, #68]
	mov	r7, r3
	cmp	r2, r7
	bhi	.L85
	beq	.L157
.L124:
	adds	r6, r6, r6
	ldr	r0, [sp, #68]
	adc	r7, r7, r7
	cmp	r0, r7
	bhi	.L85
	beq	.L158
.L125:
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	subs	r6, r6, r2
	sbc	r7, r7, r3
.L85:
	ldr	r3, [sp, #12]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #12]
	beq	.L88
	movs	r9, r9, lsr #1
	mov	r8, r8, rrx
.L89:
	and	r3, r8, #1
	cmp	r3, #0
	bne	.L159
	adds	sl, sl, r6
	ldr	r3, [sp, #68]
	adc	fp, fp, r7
	cmp	r3, fp
	bhi	.L123
	bne	.L82
	ldr	r0, [sp, #64]
	cmp	r0, sl
	bls	.L82
.L123:
	add	r2, sp, #64
	ldmia	r2, {r1-r2}
	subs	sl, sl, r1
	sbc	fp, fp, r2
	b	.L82
.L153:
	ldr	r0, [sp, #64]
	cmp	r0, r4
	bhi	.L94
	b	.L129
.L151:
	ldr	r2, [sp, #64]
	cmp	r2, r8
	bhi	.L91
	b	.L126
.L157:
	ldr	r3, [sp, #64]
	cmp	r3, r6
	bhi	.L85
	b	.L124
.L158:
	ldr	r1, [sp, #64]
	cmp	r1, r6
	bhi	.L85
	b	.L125
.L156:
	ldr	r3, [sp, #64]
	cmp	r3, r0
	bhi	.L82
	b	.L122
.L79:
	mov	r6, #1
	mov	r7, #0
	str	r6, [sp, #16]
	str	r7, [sp, #20]
.L99:
	mov	r4, #0
	mov	r5, #0
	mov	r0, #1
	mov	r6, r4
	mov	r7, r5
	mov	r8, #0
	b	.L108
.L164:
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	adds	r4, r4, r0
	adc	r5, r5, r1
	ldr	r1, [sp, #68]
	cmp	r1, r5
	bhi	.L102
	beq	.L160
.L130:
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	subs	r4, r4, r0
	sbc	r5, r5, r1
.L102:
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	adds	r0, r0, r0
	adc	r1, r1, r1
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r0, [sp, #68]
	cmp	r0, r3
	str	r2, [sp, #16]
	str	r3, [sp, #20]
	bhi	.L105
	beq	.L161
.L132:
	add	r3, sp, #16
	ldmia	r3, {r2-r3}
	ldr	r1, [sp, #68]
	adds	r2, r2, r2
	adc	r3, r3, r3
	cmp	r1, r3
	str	r2, [sp, #16]
	str	r3, [sp, #20]
	bhi	.L105
	beq	.L162
.L133:
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	subs	r0, r0, r2
	sbc	r1, r1, r3
	str	r0, [sp, #16]
	str	r1, [sp, #20]
.L105:
	add	r8, r8, #1
	cmp	r8, #64
	mov	r0, #0
	mov	r1, #0
	beq	.L163
.L108:
	and	r3, r0, #1
	cmp	r3, #0
	bne	.L164
	add	r2, sp, #16
	ldmia	r2, {r1-r2}
	adds	r6, r6, r1
	adc	r7, r7, r2
	ldr	r2, [sp, #68]
	cmp	r2, r7
	bhi	.L131
	bne	.L102
	ldr	r3, [sp, #64]
	cmp	r3, r6
	bls	.L102
.L131:
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	subs	r6, r6, r0
	sbc	r7, r7, r1
	b	.L102
.L161:
	ldr	r1, [sp, #64]
	cmp	r1, r2
	bls	.L132
	add	r8, r8, #1
	cmp	r8, #64
	mov	r0, #0
	mov	r1, #0
	bne	.L108
.L163:
	mov	r6, r0
	mov	r7, r1
	mov	r2, #1
	mov	r8, r0
	mov	r9, r1
	mov	sl, #0
	b	.L116
.L169:
	adds	r6, r6, r4
	ldr	r3, [sp, #68]
	adc	r7, r7, r5
	cmp	r3, r7
	bhi	.L110
	beq	.L165
.L134:
	add	r2, sp, #64
	ldmia	r2, {r1-r2}
	subs	r6, r6, r1
	sbc	r7, r7, r2
.L110:
	adds	r0, r4, r4
	adc	r1, r5, r5
	add	r3, sp, #64
	ldmia	r3, {r2-r3}
	bl	__aeabi_uldivmod
	ldr	r1, [sp, #68]
	mov	r5, r3
	cmp	r1, r5
	mov	r4, r2
	bhi	.L113
	beq	.L166
.L136:
	adds	r4, r4, r4
	ldr	r3, [sp, #68]
	adc	r5, r5, r5
	cmp	r3, r5
	bhi	.L113
	beq	.L167
.L137:
	add	r2, sp, #64
	ldmia	r2, {r1-r2}
	subs	r4, r4, r1
	sbc	r5, r5, r2
.L113:
	add	sl, sl, #1
	cmp	sl, #64
	mov	r2, #0
	beq	.L168
.L116:
	and	r3, r2, #1
	cmp	r3, #0
	bne	.L169
	adds	r8, r8, r4
	ldr	r2, [sp, #68]
	adc	r9, r9, r5
	cmp	r2, r9
	bhi	.L135
	bne	.L110
	ldr	r3, [sp, #64]
	cmp	r3, r8
	bls	.L110
.L135:
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	subs	r8, r8, r0
	sbc	r9, r9, r1
	b	.L110
.L162:
	ldr	r3, [sp, #64]
	cmp	r3, r2
	bhi	.L105
	b	.L133
.L160:
	ldr	r2, [sp, #64]
	cmp	r2, r4
	bhi	.L102
	b	.L130
.L166:
	ldr	r2, [sp, #64]
	cmp	r2, r4
	bls	.L136
	add	sl, sl, #1
	cmp	sl, #64
	mov	r2, #0
	bne	.L116
.L168:
	mov	r1, r7
	mov	r0, r6
	add	sp, sp, #28
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L167:
	ldr	r0, [sp, #64]
	cmp	r0, r4
	bhi	.L113
	b	.L137
.L165:
	ldr	r0, [sp, #64]
	cmp	r0, r6
	bhi	.L110
	b	.L134
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
	ldr	r0, .L172+8
	bl	puts
	rsb	r4, sl, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L172+12
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fldd	d8, .L172
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L172+16
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
	ldr	r0, .L172+20
	bl	puts
	rsb	r4, r7, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L172+24
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L172+28
	bl	printf
	bl	rand
	ldr	r3, .L172+32
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
.L173:
	.align	3
.L172:
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
