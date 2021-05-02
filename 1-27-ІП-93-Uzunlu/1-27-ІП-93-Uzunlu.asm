.486
.model flat, stdcall
option casemap: none
 
include /masm32/include/windows.inc
include /masm32/include/user32.inc
include /masm32/include/kernel32.inc
 
includelib /masm32/lib/user32.lib
includelib /masm32/lib/kernel32.lib
 
.data

  wind_title DB "Lab 1 Uzunlu", 0
  symbol DB "1110199", 0

  ; Microsoft (R) Macro Assembler - Programmer's Guide Version 6.0
  ; https://www.pcjs.org/documents/books/mspl13/masm/mpguide/
  ;
  ; 20.3.5  The QuickPascal/MASM Interface
  ;
  ; There's information that types, such as LongInt, ShortInt have
  ; the following representation in MASM:
  ; ShortInt - SBYTE (BYTE)
  ; LongInt - SDWORD (DWORD)
  ; Single - REAL4
  ; Double - REAL8
  ; Extended - REAL10

  ; b - byte
  ; bn - byte, negative
  ; w - word
  ; wn - word, negative
  ; s - shortint
  ; sn - shortint, negative
  ; l = longint
  ; ln = longint, negative

  a_b  BYTE 11
  a_bn BYTE -11
  a_w  WORD 11
  a_wn WORD -11
  a_s  BYTE 11
  a_sn BYTE -11
  a_l  DWORD 11
  a_ln DWORD -11

  b_w  WORD 1110
  b_wn WORD -1110
  ; BYTE can hold values of 0..255 (-128..127),
  ; so B can't be held as ShortInt
  ;; b_s  BYTE 1110
  ;; b_sn BYTE -1110
  b_l  DWORD 1110
  b_ln DWORD -1110

  ; BYTE can hold values of 0..255 (-128..127),
  ; so B can't be held as ShortInt
  ;; c_s  BYTE 11101999
  ;; c_sn BYTE -11101999
  c_l  DWORD 11101999
  c_ln DWORD -11101999

  ; s - Single
  ; sn - Single, negative
  d_s  REAL4 0.001
  d_sn REAL4 -0.001

  ; d - Double
  ; dn - Double, negative
  e_d  REAL8 0.112
  e_dn REAL8 -0.112

  ; e - Extended
  ; en - Extended, negative
  f_e  REAL10 1123.456
  f_en REAL10 -1123.456

  ; %s - there must be string
  ; %x - there must be value in hexadecimal system
  string DB "Symbol: '%s'", 13,
    "B A: %x", 13,
    "B -A: %x", 13,
    "W A: %x", 13,
    "W B: %x", 13,
    "W -A: %x", 13,
    "W -B: %x", 13,
    "SI A: %x", 13,
    "SI -A: %x", 13,
    "LI A: %x", 13, 
    "LI B: %x", 13,
    "LI C: %x", 13,
    "LI -A: %x", 13, 
    "LI -B: %x", 13,
    "LI -C: %x", 13,
    "Sgl D: %x", 13,
    "Sgl -D: %x", 13,
    "Dbl E: %x", 13,
    "Dbl -E: %x", 13,
    "Ext F: %x", 13,
    "Ext -F: %x", 0
              
  buffer DB 2048 DUP (?)


.code

start:
  invoke wsprintf, addr buffer, addr string, addr symbol,
    a_b, a_bn, a_w, b_w, a_wn, b_wn,
    a_s, a_sn,
    a_l, b_l, c_l, a_ln, b_ln, c_ln,
    d_s, d_sn, e_d, e_dn, f_e, f_en

  invoke MessageBox, 0, addr buffer, addr wind_title, 0
  invoke ExitProcess, 0
end start
