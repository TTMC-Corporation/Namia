mov ah, 0x0e
mov bx, startupText

printString:
    mov al, [bx]
    cmp al, 0x03
    je end
    int 0x10
    inc bx
    jmp printString

end:
    mov bx, lineStartText

printString2:
    mov al, [bx]
    cmp al, 0x03
    je loop
    int 0x10
    inc bx
    jmp printString2


loop:
    mov ah, 0x00
    int 0x16
    cmp al, 0x08
    je goBack
    cmp al, 0x0D
    je enterPressed
    jmp writeChar

enterPressed:
    mov ah, 0x0e
    int 0x10
    mov al, 0x0a
    int 0x10
    mov bx, lineStartText
    jmp printString2

goBack:
    mov ah, 0x03
    mov bh, 0x00
    int 0x10
    cmp dl, 8
    jle loop
    mov ah, 0x0e
    int 0x10
    mov al, 0x00
    mov ah, 0x0e
    int 0x10
    call cursorBack
    jmp loop

cursorBack:
    mov ah, 0x03
    mov bh, 0x00
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    add dl, -1
    int 0x10
    ret

writeChar:
    mov ah, 0x0e
    int 0x10
    jmp loop

startupText:
    db "Namia kernel loaded!", 0x0a, 0x0d, "Version 0.1 (Made by TheBlueLines)", 0x0a, 0x0a, 0x0d, 0x03

lineStartText:
    db "Namia > ", 0x03