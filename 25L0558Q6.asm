[org 0x0100]
jmp start

message: db 'TEXT VIEWPORT MANAGER', 0
paragraph: db 'IN A.D. 2101, WAR WAS BEGINNING. CAPTAIN: WHAT HAPPEN? MECHANIC: SOMEBODY SET UP US THE BOMB. OPERATOR: WE GET SIGNAL. CAPTAIN: WHAT! OPERATOR: MAIN SCREEN TURN ON. CAPTAIN: IT IS YOU!! CATS: HOW ARE YOU GENTLEMEN!! ALL YOUR BASE ARE BELONG TO US. YOU ARE ON THE WAY TO DESTRUCTION. CAPTAIN: TAKE OFF EVERY ZIG!! FOR GREAT JUSTICE.', 0
search_word: db 'CAPTAIN', 0

lbl1: db 'Total Matches Found: [', 0
lbl2: db '] | Viewport Status: ACTIVE', 0

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

    mov ax, 10
    push ax
    mov ax, 70
    push ax
    mov ax, 4
    push ax
    mov ax, 21
    push ax
    mov ax, 1
    push ax
    call scroll_window_up

    mov ax, 4
    push ax
    mov ax, 21
    push ax
    mov ax, 10
    push ax
    mov ax, 70
    push ax
    mov ax, 0xCE
    push ax
    mov ax, search_word
    push ax
    call fndhl
		
    push ax

    mov ax, 0
    push ax
    mov ax, 23
    push ax
    mov ax, 0x72
    push ax
    mov ax, lbl1
    push ax
    call printstr

    pop ax
    push 23         
    push 22          
    push ax  
    call prt_n

    mov ax, 23
    push ax
    mov ax, 23
    push ax
    mov ax, 0x72
    push ax
    mov ax, lbl2
    push ax
    call printstr

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

scroll_window_up:
    push bp
    mov bp, sp
    push es
    push ds
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov ax, 0xb800
    mov ds, ax
    mov es, ax

    mov ax, 80
    mov bx, [bp+8]
    xor dx, dx
    mul bx
    add ax, [bp+12]
    shl ax, 1
    mov di, ax

    mov ax, 160
    mov bx, [bp+4]
    xor dx, dx
    mul bx
    mov si, di
    add si, ax

    mov ax, [bp+10]
    sub ax, [bp+12]
    inc ax
    shl ax, 1
    mov bx, 160
    sub bx, ax

    mov cx, [bp+6]
    sub cx, [bp+8]
    sub cx, [bp+4]

row_loop:
    push cx
    mov cx, [bp+10]
    sub cx, [bp+12]
    inc cx
    cld
    rep movsw

    add di, bx
    add si, bx
    pop cx
    loop row_loop

    mov cx, [bp+4]
clear_bottoms:
    push cx
    mov ax, 80
    mov bx, [bp+6]
    sub bx, cx
    xor dx, dx
    mul bx
    add ax, [bp+12]
    shl ax, 1
    mov di, ax

    mov cx, [bp+10]
    sub cx, [bp+12]
    inc cx
    mov ax, 0x7520
    cld
    rep stosw
    pop cx
    loop clear_bottoms

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop ds
    pop es
    pop bp
    ret 10

fndhl:
    push bp
    mov bp, sp
    sub sp, 2
    push es
    push ds
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov word [bp-2], 0

    mov ax, [bp+4]
    push ax
    call strlen
    cmp ax, 0
    jz xit
    mov bx, ax

    mov ax, 0xb800
    mov es, ax

    mov ax, 80
    mul byte [bp+14]
    add ax, [bp+10]
    shl ax, 1
    mov di, ax

    xor dx, dx
    mov si, [bp+4]
    mov cx, [bp+10]

scn:
    mov al, [es:di]
    cmp al, [ds:si]
    jne rst

    inc dx
    inc si
    cmp dx, bx
    jne nxt

    inc word [bp-2]

    push di
    push cx
    push bx
    mov dx, cx
    mov al, [bp+6]

hlw:
    mov [es:di+1], al
    dec bx
    jz hdone
    cmp dx, [bp+10]
    jne hback
    push ax
    mov ax, [bp+8]
    sub ax, [bp+10]
    shl ax, 1
    sub ax, 160
    add di, ax
    pop ax
    mov dx, [bp+8]
    jmp hlw

hback:
    sub di, 2
    dec dx
    jmp hlw

hdone:
    pop bx
    pop cx
    pop di
    xor dx, dx
    mov si, [bp+4]
    jmp nxt

rst:
    xor dx, dx
    mov si, [bp+4]

nxt:
    inc cx
    cmp cx, [bp+8]
    jle skp_w

    mov cx, 80
    sub cx, [bp+8]
    add cx, [bp+10]
    shl cx, 1
    add di, cx

    mov cx, [bp+10]
    jmp chk_e

skp_w:
    add di, 2

chk_e:
    push bx
    push dx
    mov ax, 160
    mov bx, [bp+12]
    inc bx
    mul bx
    pop dx
    pop bx
    cmp di, ax
    jb scn

xit:
    mov ax, [bp-2]
    mov [bp-2], ax
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    mov ax, [bp-2]
    pop ds
    pop es
    add sp, 2
    pop bp
    ret 12

prt_n:
    push bp
    mov bp, sp
    sub sp, 2           
    push es
    push ax
    push bx
    push cx
    push dx
    push di

    mov ax, 0xb800
    mov es, ax

    mov ax, 80
    mul byte [bp+8]     
    add ax, [bp+6]     
    shl ax, 1
    mov di, ax          

    mov ax, [bp+4]      
    mov bx, 10          
    mov word [bp-2], 0  

d_lp:
    xor dx, dx
    div bx
    add dl, 0x30        
    push dx             
    inc word [bp-2]     
    cmp ax, 0
    jnz d_lp

p_lp:
    pop ax
    mov ah, 0x72        
    stosw
    dec word [bp-2]
    mov cx, [bp-2]
    jcxz d_p
    jmp p_lp

d_p:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop es
    add sp, 2           
    pop bp
    ret 6               

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
