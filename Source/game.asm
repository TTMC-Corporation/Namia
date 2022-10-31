[org 0x8000]

mov al, 0x03
mov ah, 0
int 0x10

mov al, 0x13
mov ah, 0
int 0x10

startDraw:
    mov ah, 0x0c
    xor bh, bh
    mov al, 0x07
    xor cx, cx
    xor dx, dx
    jmp loopA

loopA:
    int 0x10
    cmp cx, 320
    jl againA
    jmp loopB

againA:
    inc cx
    jmp loopA

loopB:
    inc dx
    xor cx, cx
    cmp dx, 190
    jl loopA
    mov al, 0x08
    jmp loopD

loopC:
    inc dx
    xor cx, cx
    cmp dx, 200
    jl loopD
    jmp let

loopD:
    int 0x10
    cmp cx, 320
    jl againD
    jmp loopC

let:
    mov al, 0x04
    mov cx, 10
    mov dx, 180
    jmp makePlayer

loop:
    mov ah, 0x00
    int 0x16
    cmp al, 'd'
    je moveRight
    cmp al, 'a'
    je moveLeft
    jmp loop
    moveRight:
        ; add cx, 10
        ; mov bx, loop
        ; jmp makePlayer
    moveLeft:
        ; add cx, -10
        ; mov bx, loop
        ; jmp makePlayer

makePlayer:
    mov al, 0x0c
    mov si, cx
    add si, 10
    mov di, dx
    add di, 10
    why:
        cmp dx, di
        jge end
        jmp whx
    whz:
        add cx, -10
        inc dx
        jmp why
    whx:
        mov ah, 0x0c
        int 0x10
        inc cx
        cmp cx, si
        jge whz
        jmp whx
    end:
        add dx, -10
        jmp loop

againD:
    inc cx
    jmp loopD

exit:
    jmp $