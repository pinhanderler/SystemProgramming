.386

.model flat,stdcall
option casemap:none
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc

includelib C:\masm32\lib\kernel32.lib
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\user32.lib

.data?
value dd ?

.data
MsgBoxCaption  db "Lab 6",0
MsgBoxText     db "a=%i, b=%i, d=%i",13,
                  "The value is %i",0
MsgBoxError    db "Division by zero",0
array_a dd -1, 2, 4, -6, -1
array_b dd 2, -1, -3, 2, -5
array_d dd 2, 7, -1, 7, -5

buf db 128 dup (?)
.code
start:
    mov edi, 0
    loop_start:
    mov eax, 4
    imul array_a[edi*4]
    mov ebx, array_d[edi*4]
    sub ebx, eax
    imul ebx, array_a[edi*4]
    sub ebx, 53
    mov eax, array_a[edi*4]
    imul array_b[edi*4]
    inc eax
    imul array_a[edi*4]
    cmp eax, 0
    jz error
    xchg eax, ebx
    cdq
    idiv ebx
    test eax, 1
    jz evenj
    mov ebx,5
    imul ebx
    jmp fin
    evenj:
    cdq
    mov ebx,2
    idiv ebx
    fin:
    mov value, eax
    invoke wsprintf, addr buf, addr MsgBoxText, array_a[edi*4], array_b[edi*4], array_d[edi*4], value
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