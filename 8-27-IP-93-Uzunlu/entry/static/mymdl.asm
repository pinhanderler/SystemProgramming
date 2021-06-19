
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

    .486                      ; maximum processor model
    .model flat, stdcall      ; memory model & calling convention
    option casemap :none      ; case sensitive


.data      
    array_const dq -2.0, 53.0, 4.0, -1.0
    

.code       ; code section

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
DllMain proc hInstDLL:DWORD, reason:DWORD, unused:DWORD
    mov eax,1
    ret
DllMain endp

funcNum1 proc
    fld qword ptr [eax]
    fmul array_const[0]
    fadd array_const[8]
    fstp qword ptr [eax]
    ret
funcNum1 endp


funcNum2 proc
    fdiv
    fsin
    fmul array_const[24]
    ret
funcNum2 endp

funcNum3 proc giveVal1:QWORD, giveVal2:QWORD
    fld giveVal1
    fdiv array_const[16]
    fsub giveVal2
    ret
funcNum3 endp

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

end DllMain
