.model tiny
.data
  key db 25h
  password db "ukraine"
  message db "è†welcome"
  info db "èlab2†≠", 10,
          "birthday date: 11.10.1999", 10,
          "zalikova number†: àè-9882$"
  input db 16 dup(?)
.code
  .startup
  mov ax,03h
  int 10h
  mov ah,09h
  mov dx,offset message
  int 21h
  mov ah,3fh
  mov bx,0
  mov cx,16
  mov dx,offset input
  int 21h
  mov di,0

  validate:
  mov dh,input[di]
  xor dh,key
  cmp dh,password[di]
  jne exit
  inc di
  cmp di,8
  jb validate
  cmp input[di],13
  jne exit

  mov ax,03h
  int 10h
  mov ah,09h
  mov dx, offset info
  int 21h

  exit:
  mov ah,4ch
	mov al,0
  int 21h
end
