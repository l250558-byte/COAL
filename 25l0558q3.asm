[org 0x0100]
jmp start

message: db 'TEXT VIEWPORT MANAGER', 0
paragraph: db 'IN A.D. 2101, WAR WAS BEGINNING. CAPTAIN: WHAT HAPPEN? MECHANIC: SOMEBODY SET UP US THE BOMB. OPERATOR: WE GET SIGNAL. CAPTAIN: WHAT! OPERATOR: MAIN SCREEN TURN ON. CAPTAIN: IT IS YOU!! CATS: HOW ARE YOU GENTLEMEN!! ALL YOUR BASE ARE BELONG TO US. YOU ARE ON THE WAY TO DESTRUCTION. CAPTAIN: TAKE OFF EVERY ZIG!! FOR GREAT JUSTICE.', 0
search_word: db 'CAPTAIN', 0

start:
    call clrscr
    mov ax,3
    push ax
    mov ax,21
    push ax
    mov ax,8
    push ax
    mov ax,72
    push ax
    call draw_borders

    mov ax, 30
    push ax
    mov ax, 3
    push ax
    mov ax, 0x1E
    push ax
    mov ax, message
    push ax
    call printstr

    mov ax, 4
    push ax
    mov ax, 21
    push ax
    mov ax, 10
    push ax
    mov ax, 70
    push ax
    mov ax, 0x75
    push ax
    mov ax, paragraph
    push ax
    call text_buffer
    mov ax,0x4c00
    int 21h

draw_borders:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ax,0xb800
    mov es,ax
    mov cx, [bp+10]
    xor di, di
mul1:
    add di, 160
    loop mul1
    mov ax, [bp+6]
    shl ax, 1
    add di, ax
    mov cx, [bp+4]
    sub cx, [bp+6]
    sub cx, 1
    mov al, 0xc9
    mov ah, 0x73
    stosw
    mov al, 0xcd
    rep stosw
    mov al, 0xbb
    stosw
    mov cx, [bp+8]
    sub cx, [bp+10]
    sub cx, 1
    mov bx, [bp+10]
    inc bx
    xor si, si
mul2:
    add si, 160
    dec bx
    jnz mul2
    mov ax, [bp+6]
    shl ax, 1
    add si, ax
mul3:
    mov di, si
    mov al, 0xba
    mov ah, 0x73
    stosw
    add si, 160
    loop mul3
    mov cx, [bp+8]
    sub cx, [bp+10]
    sub cx, 1
    mov bx, [bp+10]
    inc bx
    xor si, si
mul4:
    add si, 160
    dec bx
    jnz mul4
    mov ax, [bp+4]
    shl ax, 1
    add si, ax
mul5:
    mov di, si
    mov al, 0xba
    mov ah, 0x73
    stosw
    add si, 160
    loop mul5
    mov cx, [bp+8]
    xor di, di
mul6:
    add di, 160
    loop mul6
    mov ax, [bp+6]
    shl ax, 1
    add di, ax
    mov cx, [bp+4]
    sub cx, [bp+6]
    sub cx, 1
    mov al, 0xc8
    mov ah, 0x73
    stosw
    mov al, 0xcd
    rep stosw
    mov al, 0xbc
    stosw
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 8

text_buffer:
    push bp
    mov bp, sp
    push es
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push ds

    mov ax, [bp+4]
    push ax
    call strlen
    cmp ax, 0
    jz exitf
    mov cx, ax

    mov ax, 0xb800
    mov es, ax

    mov ax, 80
    mul byte [bp+14]
    add ax, [bp+10]
    shl ax, 1
    mov di, ax

    mov ax, [bp+8]
    sub ax, [bp+10]
    inc ax
    shl ax, 1
    mov bx, 160
    sub bx, ax

    mov si, [bp+4]
    mov dl, [bp+10]
    mov dh, [bp+14]
    cld

nextchartxt:
    lodsb
    mov ah, 0x75
    stosw
    inc dl

    mov ax, [bp+8]
    inc ax
    cmp dl, al
    jnz skip_wrap

    mov dl, [bp+10]
    inc dh
    cmp dh, [bp+12]
    je exitf

    add di, bx

skip_wrap:
    loop nextchartxt

exitf:
    pop ds
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop es
    pop bp
    ret 12

printstr:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di
    push ds
    mov ax, [bp+4]
    push ax
    call strlen
    cmp ax, 0
    jz exit
    mov cx, ax
    mov ax, 0xb800
    mov es, ax
    mov al, 80
    mul byte [bp+8]
    add ax, [bp+10]
    shl ax, 1
    mov di,ax
    mov si, [bp+4]
    mov ah, [bp+6]
    cld
nextchar:
    lodsb
    stosw
    loop nextchar
exit:
    pop ds
    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 8

strlen:
    push bp
    mov bp,sp
    push es
    push cx
    push di
    mov ax, ds
    mov es, ax
    mov di, [bp+4]
    mov cx, 0xffff
    xor al, al
    repne scasb
    mov ax, 0xffff
    sub ax, cx
    dec ax
    pop di
    pop cx
    pop es
    pop bp
    ret 2

clrscr:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ax,0xb800
    mov es,ax
    xor di,di
    mov ax,0x7020
    mov cx,2000
    rep stosw
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret
