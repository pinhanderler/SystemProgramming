.386

.model flat,stdcall
option casemap:none
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\masm32.inc

includelib C:\masm32\lib\kernel32.lib
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\masm32.lib

.data?
value dq ?
value_str db 30 dup (?)
value_a_str db 30 dup (?)
value_b_str db 30 dup (?)
value_c_str db 30 dup (?)
value_d_str db 30 dup (?)

.data
MsgBoxCaption  db "Lab 6",0
MsgBoxText     db "a=%s, b=%s, c=%s, d=%s",13,
                  "The value is %s",0
MsgBoxError    db "Calculation cannot be performed",0
array_a dq 12.0, 1.07, 53.87, 0.12, 1.12
array_b dq 0.87, 10.7, 0.6427, 0.42, 1.42
array_c dq 9.7, 8.6, 54.6, 0.6, 1.6
array_d dq 8.64, 6.87, 6.80007, 0.11, 1.11
array_const dq 2.0, 53.0, 4.0

buf db 256 dup (?)
.code
start:
    mov edi, 0
    loop_start:
    finit
    fld array_a[edi*8]
    fld array_d[edi*8]
    fxam
    fstsw ax
    sahf
    jz error
    fdiv
    fsin
    fld array_const[0]
    fmul array_c[edi*8]
    fadd
    fld array_const[8]
    fxch
    fsub
    fld array_a[edi*8]
    fdiv array_const[16]
    fsub array_b[edi*8]
    fxam
    fstsw ax
    sahf
    jz error
    fdiv
    fstp value

    invoke FloatToStr, array_a[edi*8], addr value_a_str
    invoke FloatToStr, array_b[edi*8], addr value_b_str
    invoke FloatToStr, array_c[edi*8], addr value_c_str
    invoke FloatToStr, array_d[edi*8], addr value_d_str
    invoke FloatToStr, value, addr value_str
    invoke wsprintf, addr buf, addr MsgBoxText, addr value_a_str, addr value_b_str, addr value_c_str, addr value_d_str, addr value_str
    invoke MessageBox, NULL, addr buf, addr MsgBoxCaption, MB_OK
    jmp repeat_point
    error:
    invoke MessageBox, NULL, addr MsgBoxError, addr MsgBoxCaption, MB_OK
    repeat_point:
    inc edi
    cmp edi, 5
    jnz loop_start



invoke ExitProcess, NULL
end start