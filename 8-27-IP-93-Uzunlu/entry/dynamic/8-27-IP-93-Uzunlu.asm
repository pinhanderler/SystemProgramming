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
temp dq ?
giveVal1 dq ?
giveVal2 dq ?
getVal dq ?
value_str db 30 dup (?)
value_a_str db 30 dup (?)
value_b_str db 30 dup (?)
value_c_str db 30 dup (?)
value_d_str db 30 dup (?)
hLib dd ?
funcNum1_ref dd ?
funcNum2_ref dd ?
funcNum3_ref dd ?

.data
LibName        db "mymdl",0
FuncNum1_name  db "funcNum1",0
FuncNum2_name  db "funcNum2",0
FuncNum3_name  db "funcNum3",0
MsgBoxCaption  db "Lab 8",0
MsgBoxText     db "a=%s, b=%s, c=%s, d=%s",13,
                  "The value is %s",0
MsgBoxError    db "Calculation cannot be performed",0
LibError       db "Library or function is not found"
array_a dq 12.0, 16.0, 53.87, 0.12, 1.12
array_b dq 0.87, 4.0, 0.6427, 0.42, 1.42
array_c dq 9.7, 8.6, 54.6, 0.6, 1.6
array_d dq 0.0, 6.87, 6.80007, 0.11, 1.11
array_const dq 2.0, 53.0, 4.0

buf db 256 dup (?)
.code

main proc

    invoke LoadLibrary, addr LibName
    cmp eax, 0
    jz lib_error
    mov hLib, eax

    invoke GetProcAddress, hLib, addr FuncNum1_name
    cmp eax, 0
    jz lib_error
    mov funcNum1_ref, eax

    invoke GetProcAddress, hLib, addr FuncNum2_name
    cmp eax, 0
    jz lib_error
    mov funcNum2_ref, eax

    invoke GetProcAddress, hLib, addr FuncNum3_name
    cmp eax, 0
    jz lib_error
    mov funcNum3_ref, eax

    mov edi, 0
    loop_start:
    finit
    lea eax, array_c[edi*8]
    call [funcNum1_ref]
    fld qword ptr [eax]
    fstp temp
    fld array_a[edi*8]
    fld array_d[edi*8]
    fxam
    fstsw ax
    sahf
    jz error
    call [funcNum2_ref]
    fld temp
    fadd
    fstp temp
    ; invoke funcNum3, array_a[edi*8], array_b[edi*8]
    push DWORD ptr array_b[edi*8+4]
    push DWORD ptr array_b[edi*8]
    push DWORD ptr array_a[edi*8+4]
    push DWORD ptr array_a[edi*8]
    call [funcNum3_ref]
    fxam
    fstsw ax
    sahf
    jz error
    fld temp
    fxch
    fdiv
    fstp value
    invoke FloatToStr, array_a[edi*8], addr value_a_str
    invoke FloatToStr, array_b[edi*8], addr value_b_str
    invoke FloatToStr, array_c[edi*8], addr value_c_str
    invoke FloatToStr, array_d[edi*8], addr value_d_str
    invoke FloatToStr2, value, addr value_str
    invoke wsprintf, addr buf, addr MsgBoxText, addr value_a_str, addr value_b_str, addr value_c_str, addr value_d_str, addr value_str
    invoke MessageBox, NULL, addr buf, addr MsgBoxCaption, MB_OK
    jmp repeat_point
    error:
    invoke MessageBox, NULL, addr MsgBoxError, addr MsgBoxCaption, MB_OK
    repeat_point:
    inc edi
    cmp edi, 5
    jnz loop_start
    jmp terminate

    lib_error:
    invoke MessageBox, NULL, addr LibError, addr MsgBoxCaption, MB_OK

terminate:
invoke ExitProcess, NULL
ret

main endp
end main
