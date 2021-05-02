.386
.model flat, stdcall
option casemap: none

include /masm32/include/windows.inc
include /masm32/include/user32.inc
include /masm32/include/kernel32.inc

includelib /masm32/lib/user32.lib
includelib /masm32/lib/kernel32.lib

.data
    msg_title  DB "Lab 1", 0

    format_symbol DB "Character string - '%s'", 0
    buffer_symbol DB 128 DUP (?)
    symbol        DB "1110199", 0

    format_a_pos DB "+A = %x", 0
    format_a_neg DB "-A = %x", 0
    format_b_pos DB "+B = %x", 0
    format_b_neg DB "-B = %x", 0
    format_c_pos DB "+C = %x", 0
    format_c_neg DB "-C = %x", 0
    format_d_pos DB "+D = %x", 0
    format_d_neg DB "-D = %x", 0
    format_e_pos DB "+E = %x%x", 0
    format_e_neg DB "-E = %x%x", 0
    format_f_pos DB "+F = %x%x%x", 0
    format_f_neg DB "-F = %x%x%x", 0

    buffer_a_pos DB 16 DUP (?)
    buffer_a_neg DB 16 DUP (?)
    buffer_b_pos DB 16 DUP (?)
    buffer_b_neg DB 16 DUP (?)
    buffer_c_pos DB 16 DUP (?)
    buffer_c_neg DB 16 DUP (?)
    buffer_d_pos DB 16 DUP (?)
    buffer_d_neg DB 16 DUP (?)
    buffer_e_pos DB 32 DUP (?)
    buffer_e_neg DB 32 DUP (?)
    buffer_f_pos DB 32 DUP (?)
    buffer_f_neg DB 32 DUP (?)

    msg_format DB "%s", 13,
        "%s", 13, ; +A
        "%s", 13, ; -A
        "%s", 13, ; +B
        "%s", 13, ; -B
        "%s", 13, ; +C
        "%s", 13, ; -C
        "%s", 13, ; +D
        "%s", 13, ; -D
        "%s", 13, ; +E
        "%s", 13, ; -E
        "%s", 13, ; +F
        "%s", 13, ; -F
        0

    msg_buffer DB 128 DUP (?)

    ; BYTE
    A_byte_pos DB +11
    A_byte_neg DB -11

    ; WORD
    A_word_pos DW +11
    A_word_neg DW -11
    B_word_pos DW +1110
    B_word_neg DW -1110

    ; SHORT INT
    A_short_pos DD +11
    A_short_neg DD -11
    B_short_pos DD +1110
    B_short_neg DD -1110
    C_short_pos DD +11101999
    C_short_neg DD -11101999

    ; LONG INT
    A_long_pos DQ +11
    A_long_neg DQ -11
    B_long_pos DQ +1110
    B_long_neg DQ -1110
    C_long_pos DQ +11101999
    C_long_neg DQ -11101999

    ; FLOAT
    D_float_pos DD +0.001
    D_float_neg DD -0.001

    ; DOUBLE
    E_double_pos DQ +0.11
    E_double_neg DQ -0.11

    ; LONG DOUBLE
    F_longD_pos DT +11.234
    F_longD_neg DT -11.234

.code
    start:
        invoke wsprintf, addr buffer_symbol, addr format_symbol, addr symbol

        invoke wsprintf, addr buffer_a_pos, addr format_a_pos, A_byte_pos
        invoke wsprintf, addr buffer_a_neg, addr format_a_neg, A_byte_neg
        invoke wsprintf, addr buffer_b_pos, addr format_b_pos, B_word_pos
        invoke wsprintf, addr buffer_b_neg, addr format_b_neg, B_word_neg
        invoke wsprintf, addr buffer_c_pos, addr format_c_pos, C_short_pos
        invoke wsprintf, addr buffer_c_neg, addr format_c_neg, C_short_neg
        invoke wsprintf, addr buffer_d_pos, addr format_d_pos, D_float_pos
        invoke wsprintf, addr buffer_d_neg, addr format_d_neg, D_float_neg
        invoke wsprintf, addr buffer_e_pos, addr format_e_pos, E_double_pos
        invoke wsprintf, addr buffer_e_neg, addr format_e_neg, E_double_neg
        invoke wsprintf, addr buffer_f_pos, addr format_f_pos, F_longD_pos
        invoke wsprintf, addr buffer_f_neg, addr format_f_neg, F_longD_neg

        invoke wsprintf, addr msg_buffer, addr msg_format,
            addr buffer_symbol,
            addr buffer_a_pos,
            addr buffer_a_neg,
            addr buffer_b_pos,
            addr buffer_b_neg,
            addr buffer_c_pos,
            addr buffer_c_neg,
            addr buffer_d_pos,
            addr buffer_d_neg,
            addr buffer_e_pos,
            addr buffer_e_neg,
            addr buffer_f_pos,
            addr buffer_f_neg

        invoke MessageBox, 0, addr msg_buffer, addr msg_title, MB_OK
        invoke ExitProcess, 0
    end start
