global numerator1
global numerator2
global denominator
extern _tech
extern tempi, GLOBV
section .text
numerator1:
	mov [_tech], rcx
	fld qword[_tech]
	mov [_tech], rdx
	fdiv qword[_tech]
	fsin
	fstp qword[_tech]
	mov rax, [_tech]
	ret

numerator2:
	pop r9
	mov qword[tempi], -2
	fild qword[tempi]
	pop qword[_tech]
	fmul qword[_tech]
	mov qword[tempi], 53
	fild qword[tempi]
	fadd st1
	pop qword[_tech]
	fsub qword[_tech]
	fstp qword[_tech]
	push qword[_tech]
	push r9
	ret

denominator:
	fld qword[GLOBV]
	mov qword[tempi], 4
	fild qword[tempi]
	fdivp st1, st0
	fld qword[GLOBV+8]
	fsubp st1, st0
	fxch st1
	fdiv st1
	fstp qword[GLOBV]
	ret