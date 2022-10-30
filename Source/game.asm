[org 2*256]

mov al, 0x13
mov ah, 0
int 10h

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
    jmp end

loopD:
    int 0x10
    cmp cx, 320
    jl againD
    jmp loopC

againD:
    inc cx
    jmp loopD

end:
    jmp $