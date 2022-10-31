[org 0x7e00]

mov bx, startupText
call writeLine
mov bx, lineStartText
call write

mov [DISK_NUMBER], dl

loop:
    mov ah, 0x00
    int 0x16
    cmp al, 0x08
    je goBack
    cmp al, 0x0D
    je enterPressed
    call writeChar
    jmp loop

enterPressed:
    mov al, 0x00
    call writeChar
    call getCursorPosition
    call newLine
    call checkEngine
    jmp loop

checkEngine:
    add dl, -8
    xor dh, dh
    theLoop:
        cmp dh, dl
        jge WrongCommand
        xor bx, bx
        mov bl, dh
        mov ah, theCommand[bx]
        mov al, gameString[bx]
        cmp ah, al
        jne WrongCommand
        cmp al, 0x00
        je theGame
        inc dh
        jmp theLoop
    
    WrongCommand:
        mov bx, unknownCommand
        call writeLine
    NewCommand:
        mov bx, lineStartText
        call write
    ret

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
    call getCursorPosition
    mov ah, 0x02
    add dl, -1
    int 0x10
    ret

writeChar:
    call getCursorPosition
    add dl, -8
    xor bx, bx
    mov bl, dl
    mov theCommand[bx], al
    mov ah, 0x0e
    int 0x10
    ret

startupText:
    db "Namia kernel loaded!", 0x0a, 0x0d, "Version 0.1 (Made by TheBlueLines)", 0x0a, 0x03

lineStartText:
    db "Namia > ", 0x03

unknownCommand:
    db "Unknown command", 0x03

gameString db "start", 0x00
lenGameString equ $ - gameString

DISK_NUMBER db 0

theCommand times 32 db 0x00

end:
    jmp $

write:
    printStringLoop:
        mov ah, 0x0e
        mov al, [bx]
        cmp al, 0x03
        je printStringEnd
        int 0x10
        inc bx
        jmp printStringLoop
    printStringEnd:
        ret

writeLine:
    call write
    call newLine
    ret

newLine:
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    ret

getCursorPosition:
    mov ah, 0x03
    mov bh, 0x00
    int 0x10
    ret

debug:
    mov ah, 0x0e
    mov al, dl
    add al, 40
    int 0x10
    ret

warn:
    mov al, ah
    add al, 48
    mov ah, 0x0e
    int 0x10
    jmp $

theGame:
    jmp (0x8000 >> 4):0x00

error:
    mov al, '!'
    mov ah, 0x0e
    int 0x10
    hlt