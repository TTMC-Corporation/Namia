[org 0x7c00]

mov [DISK_NUMBER], dl ; store the disk number

mov al, 0x03 ; video mode (text) & clear terminal
mov ah, 0x00 ; 00h
int 0x10 ; interrupt

mov ah, 0x02 ; 02h
mov al, 2 ; Number of sectors to read
xor ch, ch ; cylinder number
mov cl, 2 ; sector number
xor dh, dh ; head number
mov dl, [DISK_NUMBER] ; drive number (0x80 for hard drive)
mov bx, KERNEL_LOCATION ; data in memory
int 0x13 ; interrupt
jc error ; error

jmp (KERNEL_LOCATION >> 4):0x00 ; Far jump

DISK_NUMBER db 0 ; Variable for disk number
KERNEL_LOCATION EQU 0x7e00 ; Kernel location

end:
    jmp $

error:
    mov al, ah ; error code charcter
    add al, 48 ; convert to number 0-9
	mov ah, 0x0e ; 0eh
	int 0x10 ; interrupt
    jmp end