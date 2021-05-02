.386
.model flat, stdcall
option casemap :none   

;******************** Imports ********************

include c:/masm32/include/windows.inc
include c:/masm32/include/user32.inc
include c:/masm32/include/kernel32.inc
 
includelib c:/masm32/lib/user32.lib
includelib c:/masm32/lib/kernel32.lib


;************** Procedure prototypes **************

WinMain proto :dword, :dword, :dword, :dword
WndProc proto :dword, :dword, :dword, :dword


;********************** Data **********************

.data
  ; Window properties
  WndTitle DB "Log In Window", 0
  WndXPos equ 20
  WndYPos equ 20
  WndHeight equ 120
  WndWidth equ 300
  
  ; Label properties
  LabelField db "static", 0
  LabelText db "Enter the password", 0
  LabelID equ 2001
  LabelXPos equ 20
  LabelYPos equ 20
  LabelHeight equ 20
  LabelWidth equ 160
  
  ; Editing field properties
  EditField db "edit", 0
  EditID equ 2000
  EditXPos equ 20
  EditYPos equ 50
  EditHeight equ 20
  EditWidth equ 160
  
  ; Button properties
  Button db "button", 0
  ButtonText db "Try", 0
  ButtonID equ 2002
  ButtonXPos equ 200
  ButtonYPos equ 20
  ButtonHeight equ 20
  ButtonWidth equ 70
	
  ; Exit button
  ExitButtonText db "Exit", 0
  ExitButtonID equ 2003
  ExitButtonXPos equ 200
  ExitButtonYPos equ 50
  ExitButtonHeight equ 20
  ExitButtonWidth equ 70
  
  ; Specific parameters
  KeyboardHookWParam equ 40
  ErrorMessage db "Try again :(", 0
  MsgBoxTitle db "Message", 0
  WndClassName DB "BasicWindow", 0

  ; Student related data
  userInfo db "Uzunlu Gamzenur", 13,
				"9882", 13,
				"11.10.1999", 0
	password db "abcdefgh"
	len dw 8

.data?
	hInstance dd ?
	lpCmdLine dd ?
	hEditText HWND ?
	input db 64 DUP (?)


;******************** Code ********************

.code
start:
  
  ; Invoke GUI hooks
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke GetCommandLine
	mov lpCmdLine, eax
  ; Launch main window
	invoke WinMain, hInstance, NULL, lpCmdLine, SW_SHOWDEFAULT
  ; After it finishes, exit
	invoke ExitProcess, eax


WinMain proc hInst :dword, hPrevInst :dword, CmdLine :dword, nShowCmd :dword
  
  ; WC - window context
	local wc :WNDCLASSEX
  ; Msg - message
	local msg :MSG
	local hWnd :HWND

  ; Apply styles to the window
	mov wc.cbSize, sizeof WNDCLASSEX
	mov wc.style, CS_HREDRAW or CS_VREDRAW or CS_BYTEALIGNWINDOW
	mov wc.lpfnWndProc, WndProc
	mov wc.cbClsExtra, NULL
	mov wc.cbWndExtra, NULL

  ; Apply instance
	push hInst
	pop  wc.hInstance

  ; Apply more window properties
	mov wc.hbrBackground, COLOR_BTNFACE + 1
	mov wc.lpszMenuName, NULL
	mov wc.lpszClassName, offset WndClassName

  ; Initialize app icon
	invoke LoadIcon, hInst, IDI_APPLICATION
	mov  wc.hIcon, eax
	mov  wc.hIconSm, eax

  ; Initialize cursor hooks
	invoke LoadCursor, hInst, IDC_ARROW
	mov wc.hCursor, eax

  ; Register window context as a new window
	invoke RegisterClassEx, addr wc

  ; Create GUI window representation
	invoke  CreateWindowEx, WS_EX_APPWINDOW, addr WndClassName, addr WndTitle,
				WS_OVERLAPPEDWINDOW, 
				WndXPos, WndYPos, WndWidth, WndHeight,
				NULL, NULL, hInst, NULL

  ; Register creation into eax register
	mov hWnd, eax

  ; Show window and update every time it changes
	invoke ShowWindow, hWnd, nShowCmd
	invoke UpdateWindow, hWnd

  ; Event emitting
  EventEmitter:
  	invoke GetMessage, addr msg, NULL, 0, 0
  	cmp eax, 0
  	je 	EndOfEvents
  	invoke TranslateMessage, addr msg
  	invoke DispatchMessage, addr msg
  	jmp 	EventEmitter

  EndOfEvents:
  	mov eax, msg.wParam
  	ret

WinMain endp

; Window events processor
WndProc proc hWnd :dword, uMsg :dword, wParam :dword, lParam :dword
  ; If the current event is creating the window
	.if uMsg==WM_CREATE
    ; Create edit field
		invoke CreateWindowEx, NULL,
      addr EditField, NULL,
      WS_VISIBLE or WS_CHILD or ES_LEFT or ES_AUTOHSCROLL or ES_AUTOVSCROLL or WS_BORDER,
      EditXPos, EditYPos, EditWidth, EditHeight,
      hWnd, EditID, hInstance, NULL 
    mov hEditText, eax
    ; Create label field
    invoke CreateWindowEx, NULL,
      addr LabelField, addr LabelText,
      WS_VISIBLE or WS_CHILD,
      LabelXPos, LabelYPos, LabelWidth, LabelHeight,
      hWnd, LabelID, hInstance, NULL
    ; Create "Try" button
    invoke CreateWindowEx, NULL,
      addr Button, addr ButtonText,
      WS_VISIBLE or WS_CHILD,
      ButtonXPos, ButtonYPos, ButtonWidth, ButtonHeight,
      hWnd, ButtonID, hInstance, NULL
    ; Create "Exit" button
    invoke CreateWindowEx, NULL,
      addr Button, addr ExitButtonText,
      WS_VISIBLE or WS_CHILD,
      ExitButtonXPos, ExitButtonYPos, ExitButtonWidth, ExitButtonHeight,
      hWnd, ExitButtonID, hInstance, NULL
  ; If the event is the window's command
  ; (button click, whatever)
	.elseif uMsg==WM_COMMAND
    ; If clicked "Exit", exit
    cmp wParam, ExitButtonID
    je stopProgram
    ; If clicked "Try", start checking the password
  	cmp wParam, ButtonID
  	jne stop
    ; Take out the string inside edit field
  	invoke SendMessage, hEditText, WM_GETTEXT, KeyboardHookWParam, addr input
    ; If the length of input and password aren't equal,
    ; there is an error
  	cmp ax, len
    jne inputError
    ; Otherwise, start a cycle
  	mov di, 0
  	cycle:
      ; If we checked every letter and it's correct, success
    	cmp di, len
    	je inputSuccess
      ; If we didn't reach the end, check
    	mov dh, input[di]
    	cmp dh, password[di]
      ; If the letters aren't equal, error
    	jne inputError
      inc di
      jmp cycle
    ; Error dialog
  	inputError:
    	invoke MessageBox, hWnd, addr ErrorMessage, addr MsgBoxTitle, MB_OK
    	jmp stop
    ; Success dialog
  	inputSuccess:
  	 invoke MessageBox, hWnd, addr userInfo, addr MsgBoxTitle, MB_OK
  .elseif uMsg == WM_DESTROY
    stopProgram:
      invoke PostQuitMessage, 0
      jmp stop
	.else
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam 
        ret
	.endif
    ; Leave the procedure
		stop:
  	xor eax,eax
  	ret
WndProc endp

end start

;******************** End ********************