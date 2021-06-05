default rel
extern printf
extern exit

section .text
global _start
_start:
	lea    rdi, [format]
	lea    rsi, [message]
	xor    eax, eax
	call   printf

	fld qword[array]
	fdiv qword[array+16]
	fsin
	mov qword[tempi], -2
	fild qword[tempi]
	fmul qword[array+8]
	mov qword[tempi], 53
	fild qword[tempi]
	fadd st1
	fsub st2
	fld qword[array]
	mov qword[tempi], 4
	fild qword[tempi]
	fdivp st1, st0
	mov qword[tempi], 1
	fild qword[tempi]
	fsubp st1, st0
	fxch st1
	fdiv st1
	fstp qword[save]

	movups xmm0, [save]
	lea rdi, [rel formatn];
	xor rax, rax
	mov eax, 1
	call printf

	xor    rdi, rdi
	call   exit

section .data
	tempi dq 0
	save dq 0.0

section .rodata
	message: db "List number 27, variant 6", 0
	format: db "%s", 0xa, 0
	formatn: db "The result is %f", 0xa, 0
	array dq 1287.872, 0.87, 98.277