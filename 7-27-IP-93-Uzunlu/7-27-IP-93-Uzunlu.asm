default rel
extern printf
extern exit
extern numerator1, numerator2, denominator
global _tech, tempi, GLOBV

section .text

global _start
_start:
	lea    rdi, [format]
	lea    rsi, [message]
	xor    eax, eax
	call   printf

	mov rcx, [array]
	mov rdx, [array+24]
	call numerator1
	
	push rax
	push qword[array+16]
	call numerator2
	pop qword[save]
	fld qword[save]

	mov rax, [array]
	mov [GLOBV], rax
	mov rax, [array+8]
	mov [GLOBV+8], rax
	call denominator
	mov rax, [GLOBV]
	mov [save], rax

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
	_tech dq 0.0
	GLOBV dq 0.0, 0.0

section .rodata
	message: db "List number 27, variant 6", 0
	format: db "%s", 0xa, 0
	formatn: db "The result is %f", 0xa, 0
	array dq 12, 0.87, 9.7, 8.64