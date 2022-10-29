[org 0x7c00]

boot:
mov ax, 0x0100
mov ss, ax
mov sp, 0x2000

read:
xor ax, ax
int 0x13
jc read

mov ax, 0x07e0
mov es, ax
xor bx, bx
xor dh, dh
mov cx, 2
mov ax, 2*256 + 1
int 0x13
jc read

stop:
mov dx,0x3F2
mov al,0x0C
out dx,al 

mov al, 0x03
mov ah, 0
int 10h

mov ax, 0x07e0
mov ds, ax
jmp 0x07e0:0x0

times 510-($-$$) db 0
dw 0xaa55