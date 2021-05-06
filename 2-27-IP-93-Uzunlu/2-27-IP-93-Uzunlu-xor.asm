.model tiny
.data
    key db 27
    pwd db "jl~iob"
    start db "Insert password: ", "$"
    bad db "Wrong password", "$"
    good db "Узунлу Гамзенур, 9882, IP-93", "$"
    inserted db 64 dup(0)
.code
.startup
    mov ax, 3
    int 10h
    mov ah, 9
    mov dx, offset start
    int 21h

    mov cx, 64
    mov ah, 3fh
    mov bx, 0
    mov dx, offset inserted
    int 21h

    cmp ax, 8
    jne _bad
    mov bp, 0
    cmpSymb:
    mov bl, pwd[bp]
    mov bh, inserted[bp]
    xor bh, key
    cmp bl, bh
    jne _bad
    inc bp
    cmp bp, 6
    jne cmpSymb
    jmp _good

    _good:
    mov ah, 9
    mov dx, offset good
    int 21h
    ret

    _bad:
    mov ah, 9
    mov dx, offset bad
    int 21h
    ret
end
