include \masm32\include\masm32rt.inc

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

.data
key db 27
pwd db "jl~iob"
mbTitle db "info", 0
start db "Insert password: ", 0
bad db "Wrong password. Try again", 0
good db "Correct password", 0
inserted db 64 dup(0)

.const
IDC_OK equ 1001
IDC_FIELD equ 1002
IDC_TEXT equ 1003

.code
DlgProc Proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
.if uMsg == WM_COMMAND
    .if wParam == IDC_OK
        invoke SetDlgItemText, hWnd, IDC_TEXT, addr bad
        invoke GetDlgItemText, hWnd, IDC_FIELD, addr inserted, 16

        cmp eax, 6
        jne _exit
        _xor inserted
        _cmp inserted, pwd

        _good:
        invoke SetDlgItemText, hWnd, IDC_TEXT, addr good
        callMessageBox "Узунлу Гамзенур"
        callMessageBox "9882"
        callMessageBox "IP-93"
        _exit:
        
    .endif
.elseif uMsg == WM_CLOSE
     invoke EndDialog, hWnd, NULL
.else
     xor eax, eax
.endif
ret
DlgProc endp

begin:
invoke GetModuleHandle, NULL
Dialog "Лабораторна робота 3", "MS Sans Serif", 10, WS_OVERLAPPED+DS_CENTER+WS_SYSMENU, 3, 0, 0, 100, 50, 1024
DlgStatic "Insert password: ", SS_CENTER, 0, 0, 100, 10, IDC_TEXT
DlgButton "Get info", WS_TABSTOP, 20, 20, 60, 10, IDC_OK
DlgEdit WS_TABSTOP+WS_BORDER, 0, 10, 100, 10, IDC_FIELD
CallModalDialog NULL, NULL, DlgProc, NULL
invoke ExitProcess, NULL
end begin