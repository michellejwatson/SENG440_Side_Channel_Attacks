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
	@ args = 24, pretend = 0, frame = 80
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r4, #0
	sub	sp, sp, #84
	mov	r5, #0
	str	r4, [sp, #16]
	str	r5, [sp, #20]
	ldr	r1, [sp, #140]
	ldr	r5, [sp, #136]
	mov	r4, r2
	str	r5, [sp, #8]
	add	r9, sp, #128
	ldmia	r9, {r8-r9}
	str	r1, [sp, #4]
	str	r0, [sp, #12]
	mov	r5, r3
	mov	r2, #1
	mov	r6, #0
	mov	r7, #0
	mov	sl, #0
	b	.L78
.L166:
	add	r3, sp, #16
	ldmia	r3, {r2-r3}
	adds	r2, r2, r4
	adc	r3, r3, r5
	cmp	r9, r3
	str	r2, [sp, #16]
	str	r3, [sp, #20]
	bhi	.L72
	beq	.L162
.L128:
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	subs	r0, r0, r8
	sbc	r1, r1, r9
	str	r0, [sp, #16]
	str	r1, [sp, #20]
.L72:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L75
	beq	.L163
.L130:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r9, r5
	bhi	.L75
	beq	.L164
.L131:
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L75:
	add	sl, sl, #1
	cmp	sl, #64
	mov	r2, #0
	mov	r3, #0
	beq	.L165
.L78:
	and	r3, r2, #1
	cmp	r3, #0
	bne	.L166
	adds	r6, r6, r4
	adc	r7, r7, r5
	cmp	r9, r7
	bhi	.L129
	bne	.L72
	cmp	r8, r6
	bls	.L72
.L129:
	subs	r6, r6, r8
	sbc	r7, r7, r9
	b	.L72
.L163:
	cmp	r8, r2
	bls	.L130
	add	sl, sl, #1
	cmp	sl, #64
	mov	r2, #0
	mov	r3, #0
	bne	.L78
.L165:
	ldr	r1, [sp, #8]
	ldr	r4, [sp, #4]
	orrs	r1, r1, r4
	beq	.L79
	ldr	r5, [sp, #120]
	str	r2, [sp, #24]
	str	r3, [sp, #28]
	str	r2, [sp, #64]
	str	r3, [sp, #68]
	ands	r3, r5, #1
	mov	r6, #1
	mov	r7, #0
	beq	.L80
.L188:
	mov	r1, #0
	mov	r0, #0
	str	r0, [sp, #72]
	str	r1, [sp, #76]
	mov	fp, r1
	mov	r1, #0
	add	r5, sp, #16
	ldmia	r5, {r4-r5}
	mov	sl, r0
	str	r1, [sp, #56]
	b	.L89
.L170:
	add	r3, sp, #72
	ldmia	r3, {r2-r3}
	adds	r2, r2, r6
	adc	r3, r3, r7
	cmp	r9, r3
	str	r2, [sp, #72]
	str	r3, [sp, #76]
	bhi	.L82
	beq	.L167
.L132:
	add	r1, sp, #72
	ldmia	r1, {r0-r1}
	subs	r0, r0, r8
	sbc	r1, r1, r9
	str	r0, [sp, #72]
	str	r1, [sp, #76]
.L82:
	adds	r0, r6, r6
	adc	r1, r7, r7
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r6, r2
	mov	r7, r3
	bhi	.L85
	beq	.L168
.L134:
	adds	r6, r6, r6
	adc	r7, r7, r7
	cmp	r9, r7
	bhi	.L85
	beq	.L169
.L135:
	subs	r6, r6, r8
	sbc	r7, r7, r9
.L85:
	ldr	r1, [sp, #56]
	add	r1, r1, #1
	cmp	r1, #64
	str	r1, [sp, #56]
	beq	.L88
.L171:
	movs	r5, r5, lsr #1
	mov	r4, r4, rrx
.L89:
	and	r3, r4, #1
	cmp	r3, #0
	bne	.L170
	adds	sl, sl, r6
	adc	fp, fp, r7
	cmp	r9, fp
	bhi	.L133
	bne	.L82
	cmp	r8, sl
	bls	.L82
.L133:
	subs	sl, sl, r8
	sbc	fp, fp, r9
	b	.L82
.L164:
	cmp	r8, r4
	bhi	.L75
	b	.L131
.L162:
	cmp	r8, r2
	bhi	.L72
	b	.L128
.L168:
	cmp	r8, r2
	bls	.L134
	ldr	r1, [sp, #56]
	add	r1, r1, #1
	cmp	r1, #64
	str	r1, [sp, #56]
	bne	.L171
.L88:
	add	r7, sp, #16
	ldmia	r7, {r6-r7}
	mov	r4, #0
	mov	r3, #0
	mov	r0, #0
	str	r3, [sp, #16]
	str	r4, [sp, #20]
	mov	r5, r7
	mov	r4, r6
	mov	sl, #0
	mov	fp, #0
	str	r0, [sp, #52]
	b	.L107
.L175:
	add	r2, sp, #16
	ldmia	r2, {r1-r2}
	adds	r1, r1, r4
	adc	r2, r2, r5
	cmp	r9, r2
	str	r1, [sp, #16]
	str	r2, [sp, #20]
	bhi	.L100
	beq	.L172
.L140:
	add	r3, sp, #16
	ldmia	r3, {r2-r3}
	subs	r2, r2, r8
	sbc	r3, r3, r9
	str	r2, [sp, #16]
	str	r3, [sp, #20]
.L100:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L103
	beq	.L173
.L142:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r9, r5
	bhi	.L103
	beq	.L174
.L143:
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L103:
	ldr	r3, [sp, #52]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #52]
	beq	.L106
.L176:
	movs	r7, r7, lsr #1
	mov	r6, r6, rrx
.L107:
	and	r3, r6, #1
	cmp	r3, #0
	bne	.L175
	adds	sl, sl, r4
	adc	fp, fp, r5
	cmp	r9, fp
	bhi	.L141
	bne	.L100
	cmp	r8, sl
	bls	.L100
.L141:
	subs	sl, sl, r8
	sbc	fp, fp, r9
	b	.L100
.L169:
	cmp	r8, r6
	bhi	.L85
	b	.L135
.L167:
	cmp	r8, r2
	bhi	.L82
	b	.L132
.L173:
	cmp	r8, r2
	bls	.L142
	ldr	r3, [sp, #52]
	add	r3, r3, #1
	cmp	r3, #64
	str	r3, [sp, #52]
	bne	.L176
.L106:
	add	r5, sp, #64
	ldmia	r5, {r4-r5}
	mov	r0, #1
	adds	r4, r4, r0
	mov	r1, #0
	adc	r5, r5, r1
	ldr	r1, [sp, #4]
	cmp	r1, r5
	str	r4, [sp, #64]
	str	r5, [sp, #68]
	bhi	.L144
	beq	.L177
.L108:
	mov	r5, #0
	mov	r6, #0
	mov	r3, #1
	mov	sl, r5
	mov	fp, r6
	mov	r7, #0
	b	.L118
.L182:
	add	r1, sp, #72
	ldmia	r1, {r0-r1}
	adds	r5, r5, r0
	adc	r6, r6, r1
	cmp	r9, r6
	bhi	.L112
	beq	.L178
.L145:
	subs	r5, r5, r8
	sbc	r6, r6, r9
.L112:
	add	r1, sp, #72
	ldmia	r1, {r0-r1}
	adds	r0, r0, r0
	adc	r1, r1, r1
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	str	r2, [sp, #72]
	str	r3, [sp, #76]
	bhi	.L115
	beq	.L179
.L147:
	add	r4, sp, #72
	ldmia	r4, {r3-r4}
	adds	r3, r3, r3
	adc	r4, r4, r4
	cmp	r9, r4
	str	r3, [sp, #72]
	str	r4, [sp, #76]
	bhi	.L115
	beq	.L180
.L148:
	add	r2, sp, #72
	ldmia	r2, {r1-r2}
	subs	r1, r1, r8
	sbc	r2, r2, r9
	str	r1, [sp, #72]
	str	r2, [sp, #76]
.L115:
	add	r7, r7, #1
	cmp	r7, #64
	mov	r3, #0
	mov	r4, #0
	beq	.L181
.L118:
	and	r3, r3, #1
	cmp	r3, #0
	bne	.L182
	add	r2, sp, #72
	ldmia	r2, {r1-r2}
	adds	sl, sl, r1
	adc	fp, fp, r2
	cmp	r9, fp
	bhi	.L146
	bne	.L112
	cmp	r8, sl
	bls	.L112
.L146:
	subs	sl, sl, r8
	sbc	fp, fp, r9
	b	.L112
.L174:
	cmp	r8, r4
	bhi	.L103
	b	.L143
.L172:
	cmp	r8, r1
	bhi	.L100
	b	.L140
.L179:
	cmp	r8, r2
	bls	.L147
	add	r7, r7, #1
	cmp	r7, #64
	mov	r3, #0
	mov	r4, #0
	bne	.L118
.L181:
	mov	sl, r3
	mov	fp, r4
	mov	r3, #1
	str	sl, [sp, #40]
	str	fp, [sp, #44]
	sub	r7, r7, #64
	b	.L126
.L187:
	adds	sl, sl, r5
	adc	fp, fp, r6
	cmp	r9, fp
	bhi	.L120
	beq	.L183
.L149:
	subs	sl, sl, r8
	sbc	fp, fp, r9
.L120:
	adds	r0, r5, r5
	adc	r1, r6, r6
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r5, r2
	mov	r6, r3
	bhi	.L123
	beq	.L184
.L151:
	adds	r5, r5, r5
	adc	r6, r6, r6
	cmp	r9, r6
	bhi	.L123
	beq	.L185
.L152:
	subs	r5, r5, r8
	sbc	r6, r6, r9
.L123:
	add	r7, r7, #1
	cmp	r7, #64
	mov	r3, #0
	beq	.L186
.L126:
	and	r3, r3, #1
	cmp	r3, #0
	bne	.L187
	add	r3, sp, #40
	ldmia	r3, {r2-r3}
	adds	r2, r2, r5
	adc	r3, r3, r6
	cmp	r9, r3
	str	r2, [sp, #40]
	str	r3, [sp, #44]
	bhi	.L150
	bne	.L120
	cmp	r8, r2
	bls	.L120
.L150:
	add	r4, sp, #40
	ldmia	r4, {r3-r4}
	subs	r3, r3, r8
	sbc	r4, r4, r9
	str	r3, [sp, #40]
	str	r4, [sp, #44]
	b	.L120
.L177:
	ldr	r2, [sp, #8]
	cmp	r2, r4
	bls	.L108
.L144:
	add	r4, sp, #120
	ldmia	r4, {r3-r4}
	movs	r4, r4, lsr #1
	mov	r3, r3, rrx
	str	r3, [sp, #120]
	str	r4, [sp, #124]
	ldr	r5, [sp, #120]
	ands	r3, r5, #1
	add	r7, sp, #72
	ldmia	r7, {r6-r7}
	bne	.L188
.L80:
	mov	r4, #0
	mov	r5, #0
	mov	r0, #0
	mov	r1, #0
	str	r4, [sp, #24]
	str	r5, [sp, #28]
	str	r3, [sp, #60]
	add	fp, sp, #16
	ldmia	fp, {sl-fp}
	mov	r4, r6
	mov	r5, r7
	str	r0, [sp, #32]
	str	r1, [sp, #36]
	b	.L98
.L192:
	add	r2, sp, #24
	ldmia	r2, {r1-r2}
	adds	r1, r1, r4
	adc	r2, r2, r5
	cmp	r9, r2
	str	r1, [sp, #24]
	str	r2, [sp, #28]
	bhi	.L91
	beq	.L189
.L136:
	add	r3, sp, #24
	ldmia	r3, {r2-r3}
	subs	r2, r2, r8
	sbc	r3, r3, r9
	str	r2, [sp, #24]
	str	r3, [sp, #28]
.L91:
	adds	r0, r4, r4
	adc	r1, r5, r5
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r9, r3
	mov	r4, r2
	mov	r5, r3
	bhi	.L94
	beq	.L190
.L138:
	adds	r4, r4, r4
	adc	r5, r5, r5
	cmp	r9, r5
	bhi	.L94
	beq	.L191
.L139:
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L94:
	ldr	r2, [sp, #60]
	add	r2, r2, #1
	cmp	r2, #64
	str	r2, [sp, #60]
	beq	.L97
.L193:
	movs	fp, fp, lsr #1
	mov	sl, sl, rrx
.L98:
	and	r3, sl, #1
	cmp	r3, #0
	bne	.L192
	add	r1, sp, #32
	ldmia	r1, {r0-r1}
	adds	r0, r0, r4
	adc	r1, r1, r5
	cmp	r9, r1
	str	r0, [sp, #32]
	str	r1, [sp, #36]
	bhi	.L137
	bne	.L91
	cmp	r8, r0
	bls	.L91
.L137:
	add	r2, sp, #32
	ldmia	r2, {r1-r2}
	subs	r1, r1, r8
	sbc	r2, r2, r9
	str	r1, [sp, #32]
	str	r2, [sp, #36]
	b	.L91
.L190:
	cmp	r8, r2
	bls	.L138
	ldr	r2, [sp, #60]
	add	r2, r2, #1
	cmp	r2, #64
	str	r2, [sp, #60]
	bne	.L193
.L97:
	str	r6, [sp, #72]
	str	r7, [sp, #76]
	b	.L88
.L191:
	cmp	r8, r4
	bhi	.L94
	b	.L139
.L189:
	cmp	r8, r1
	bhi	.L91
	b	.L136
.L178:
	cmp	r8, r5
	bhi	.L112
	b	.L145
.L180:
	cmp	r8, r3
	bhi	.L115
	b	.L148
.L184:
	cmp	r8, r2
	bls	.L151
	add	r7, r7, #1
	cmp	r7, #64
	mov	r3, #0
	bne	.L126
.L186:
	ldr	r0, [sp, #12]
	add	r5, sp, #24
	ldmia	r5, {r4-r5}
	stmia	r0, {sl-fp}
	str	r4, [r0, #8]
	str	r5, [r0, #12]
	add	sp, sp, #84
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L185:
	cmp	r8, r5
	bhi	.L123
	b	.L152
.L183:
	cmp	r8, sl
	bhi	.L120
	b	.L149
.L79:
	mov	r4, #1
	mov	r5, #0
	str	r2, [sp, #24]
	str	r3, [sp, #28]
	str	r4, [sp, #72]
	str	r5, [sp, #76]
	b	.L108
	.size	montgomery_modular_exponentiation, .-montgomery_modular_exponentiation
	.align	2
	.global	RSA_encryption_decryption
	.type	RSA_encryption_decryption, %function
RSA_encryption_decryption:
	@ Function supports interworking.
	@ args = 24, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	fstmfdd	sp!, {d8}
	sub	sp, sp, #56
	mov	r7, r1
	add	r9, sp, #96
	ldmia	r9, {r8-r9}
	mov	r4, r2
	mov	r5, r3
	mov	r6, r0
	bl	clock
	stmia	sp, {r4-r5}
	add	r5, sp, #112
	ldmia	r5, {r4-r5}
	mov	r2, r6
	mov	r3, r7
	mov	sl, r0
	add	r0, sp, #40
	str	r4, [sp, #16]
	str	r5, [sp, #20]
	str	r8, [sp, #8]
	str	r9, [sp, #12]
	bl	montgomery_modular_exponentiation
	add	r6, sp, #40
	ldmia	r6, {r5-r6}
	bl	clock
	mov	r4, r0
	ldr	r0, .L196+8
	bl	puts
	rsb	r4, sl, r4
	mov	r2, r5
	mov	r3, r6
	ldr	r0, .L196+12
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fldd	d8, .L196
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L196+16
	bl	printf
	bl	clock
	mov	r2, r5
	add	r5, sp, #104
	ldmia	r5, {r4-r5}
	stmia	sp, {r4-r5}
	add	r5, sp, #112
	ldmia	r5, {r4-r5}
	mov	r3, r6
	mov	r7, r0
	add	r0, sp, #24
	str	r4, [sp, #16]
	str	r5, [sp, #20]
	str	r8, [sp, #8]
	str	r9, [sp, #12]
	bl	montgomery_modular_exponentiation
	bl	clock
	mov	r4, r0
	ldr	r0, .L196+20
	bl	puts
	rsb	r4, r7, r4
	add	r3, sp, #24
	ldmia	r3, {r2-r3}
	ldr	r0, .L196+24
	bl	printf
	fmsr	s15, r4	@ int
	fsitod	d16, s15
	fdivd	d17, d16, d8
	fmrrd	r2, r3, d17
	ldr	r0, .L196+28
	bl	printf
	bl	rand
	ldr	r3, .L196+32
	smull	r2, r1, r3, r0
	mov	r2, r0, asr #31
	rsb	r2, r2, r1, asr #1
	mov	r3, r2, asl #2
	add	r3, r3, r2
	rsb	r0, r3, r0
	add	r0, r0, #1
	bl	sleep
	add	sp, sp, #56
	fldmfdd	sp!, {d8}
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L197:
	.align	3
.L196:
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
