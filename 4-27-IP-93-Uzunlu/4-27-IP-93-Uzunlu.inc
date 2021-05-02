; ---------------------------------------------------------------------------------------------------
;                     4-27-IP-93-Uzunlu.inc Copyright The MASM32 SDK 1998-2010
; ---------------------------------------------------------------------------------------------------

IFNDEF UZUNLU_INC
UZUNLU_INC equ <1>

printLabel macro printedText, xPos:=<LabelXPos>, yPos:=<LabelYPos>
  ; Create label using passed parameters
  ;; This comment won't be included to listing file
  invoke CreateWindowEx, NULL,
      addr LabelField, addr printedText,
      WS_VISIBLE or WS_CHILD,
      xPos, yPos, LabelWidth, LabelHeight,
      hWnd, LabelID, hInstance, NULL
endm

cipherText macro ciphered
  ;; Declare local labels
  local cycle
  local endPoint
  ; Clear di register (it can be full with a value)
  mov di, 0
  cycle:
    cmp di, len
    je endPoint
    mov dh, key
    xor ciphered[di], dh
    inc di
    jne cycle
  endPoint:
endm

compareText macro ciphered, passwordText
  local cycle
  local endPoint
  mov di, 0
  cycle:
    cmp di, len
    je endPoint
    ; If we didn't reach the end, check
    mov dh, ciphered[di]
    cmp dh, passwordText[di]
    ; If the letters aren't equal, end of comparing
    jne endPoint
    inc di
    jmp cycle
    ;; Comment test
  endPoint:
endm

ELSE
  echo ---------------------------------------------------------
  echo WARNING duplicate include file 4-18-IP-94-Rekechynsky.inc
  echo ---------------------------------------------------------
ENDIF