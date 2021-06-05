default rel
extern printf
extern exit

section .text
global _divide
_divide:
    mov eax, edi
    cdq

    idiv esi
    ret

global _start
_start:
	lea    rdi, [format]
	lea    rsi, [message]
	xor    eax, eax
	call   printf

	mov edi, -53
	mov rsi, [array]
	call _divide
	add eax,[array+16]

	push rax

	mov rax, -4
	mov rbx, [array]
	imul rbx

	pop rbx

	add rax, rbx

	push rax

	mov rax, [array]
	mov rbx, [array+8]
	imul rbx

	add rax, 1

	pop rdi
	mov rsi, rax
	call _divide

	push rax
	and rax,1
	pop rax
	jz even

	mov rbx, 5
	imul rbx
	jmp end

	even:

	mov rdi, rax
	mov rsi, 2
	call _divide

	end:

	mov rsi, rax
	lea rdi, [rel formatn]
	xor rax, rax
	call printf

	xor    edi, edi
	call   exit

section .rodata

	message: db "List number 27, variant 7", 0
	format: db "%s", 0xa, 0
	formatn: db "The result is %i", 0xa, 0
	array dq -1,-5,-5