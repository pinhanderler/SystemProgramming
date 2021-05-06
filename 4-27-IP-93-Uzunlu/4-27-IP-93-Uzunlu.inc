callMessageBox macro text
invoke MessageBox, NULL, SADD(text), SADD(" "), 0
endm

_xor macro text
local cmpSymb
mov edi, 0
cmpSymb:
mov bh, key     ; 1
xor text[edi], bh ;; 2
inc edi
cmp edi, 6
jne cmpSymb
endm

_cmp macro text1, text2
local cmpSymb
mov edi, 0
cmpSymb:
mov bl, text1[edi]  ; 1
mov bh, text2[edi]  ;; 2
cmp bl, bh
jne _exit
endm
