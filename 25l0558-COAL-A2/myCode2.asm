[org 0x0100]

start:
    mov cl, [num_obs]
    mov ch, 0
    mov [current_count], cx
    mov si, 0

loop_obs:
    mov ax, [obs + si]

    mov bx, ax
    mov cl, 10
    shr bx, cl
    sub bx, 20
    mov [x1], bx

    mov bx, ax
    mov cl, 5
    shr bx, cl
    and bx, 0x001f
    sub bx, 8
    mov [x2], bx

    mov bx, ax
    and bx, 0x001f
    sub bx, 16
    mov [x3], bx

    mov word [accum], 0

    mov al, [weights + 0]
    mov ah, 0
    test al, 0x80
    jz w_pos1
    mov ah, 0xff
w_pos1:
    mov dx, [x1]
    mov di, 0
    cmp ax, 0
    jge ax_pos1
    not ax
    add ax, 1
    xor di, 1
ax_pos1:
    cmp dx, 0
    jge dx_pos1
    not dx
    add dx, 1
    xor di, 1
dx_pos1:
    mul dx
    cmp di, 1
    jne term_done1
    not ax
    add ax, 1
term_done1:
    add [accum], ax

    mov al, [weights + 1]
    mov ah, 0
    test al, 0x80
    jz w_pos2
    mov ah, 0xff
w_pos2:
    mov dx, [x2]
    mov di, 0
    cmp ax, 0
    jge ax_pos2
    not ax
    add ax, 1
    xor di, 1
ax_pos2:
    cmp dx, 0
    jge dx_pos2
    not dx
    add dx, 1
    xor di, 1
dx_pos2:
    mul dx
    cmp di, 1
    jne term_done2
    not ax
    add ax, 1
term_done2:
    add [accum], ax

    mov al, [weights + 2]
    mov ah, 0
    test al, 0x80
    jz w_pos3
    mov ah, 0xff
w_pos3:
    mov dx, [x3]
    mov di, 0
    cmp ax, 0
    jge ax_pos3
    not ax
    add ax, 1
    xor di, 1
ax_pos3:
    cmp dx, 0
    jge dx_pos3
    not dx
    add dx, 1
    xor di, 1
dx_pos3:
    mul dx
    cmp di, 1
    jne term_done3
    not ax
    add ax, 1
term_done3:
    add [accum], ax

    mov al, [weights + 3]
    mov ah, 0
    test al, 0x80
    jz bias_pos1
    mov ah, 0xff
bias_pos1:
    add [accum], ax
    mov bx, [accum]
    mov [norm_score], bx

    mov word [accum], 0

    mov al, [weights + 4]
    mov ah, 0
    test al, 0x80
    jz w_pos4
    mov ah, 0xff
w_pos4:
    mov dx, [x1]
    mov di, 0
    cmp ax, 0
    jge ax_pos4
    not ax
    add ax, 1
    xor di, 1
ax_pos4:
    cmp dx, 0
    jge dx_pos4
    not dx
    add dx, 1
    xor di, 1
dx_pos4:
    mul dx
    cmp di, 1
    jne term_done4
    not ax
    add ax, 1
term_done4:
    add [accum], ax

    mov al, [weights + 5]
    mov ah, 0
    test al, 0x80
    jz w_pos5
    mov ah, 0xff
w_pos5:
    mov dx, [x2]
    mov di, 0
    cmp ax, 0
    jge ax_pos5
    not ax
    add ax, 1
    xor di, 1
ax_pos5:
    cmp dx, 0
    jge dx_pos5
    not dx
    add dx, 1
    xor di, 1
dx_pos5:
    mul dx
    cmp di, 1
    jne term_done5
    not ax
    add ax, 1
term_done5:
    add [accum], ax

    mov al, [weights + 6]
    mov ah, 0
    test al, 0x80
    jz w_pos6
    mov ah, 0xff
w_pos6:
    mov dx, [x3]
    mov di, 0
    cmp ax, 0
    jge ax_pos6
    not ax
    add ax, 1
    xor di, 1
ax_pos6:
    cmp dx, 0
    jge dx_pos6
    not dx
    add dx, 1
    xor di, 1
dx_pos6:
    mul dx
    cmp di, 1
    jne term_done6
    not ax
    add ax, 1
term_done6:
    add [accum], ax

    mov al, [weights + 7]
    mov ah, 0
    test al, 0x80
    jz bias_pos2
    mov ah, 0xff
bias_pos2:
    add [accum], ax
    mov bx, [accum]
    mov [sus_score], bx

    mov word [accum], 0

    mov al, [weights + 8]
    mov ah, 0
    test al, 0x80
    jz w_pos7
    mov ah, 0xff
w_pos7:
    mov dx, [x1]
    mov di, 0
    cmp ax, 0
    jge ax_pos7
    not ax
    add ax, 1
    xor di, 1
ax_pos7:
    cmp dx, 0
    jge dx_pos7
    not dx
    add dx, 1
    xor di, 1
dx_pos7:
    mul dx
    cmp di, 1
    jne term_done7
    not ax
    add ax, 1
term_done7:
    add [accum], ax

    mov al, [weights + 9]
    mov ah, 0
    test al, 0x80
    jz w_pos8
    mov ah, 0xff
w_pos8:
    mov dx, [x2]
    mov di, 0
    cmp ax, 0
    jge ax_pos8
    not ax
    add ax, 1
    xor di, 1
ax_pos8:
    cmp dx, 0
    jge dx_pos8
    not dx
    add dx, 1
    xor di, 1
dx_pos8:
    mul dx
    cmp di, 1
    jne term_done8
    not ax
    add ax, 1
term_done8:
    add [accum], ax

    mov al, [weights + 10]
    mov ah, 0
    test al, 0x80
    jz w_pos9
    mov ah, 0xff
w_pos9:
    mov dx, [x3]
    mov di, 0
    cmp ax, 0
    jge ax_pos9
    not ax
    add ax, 1
    xor di, 1
ax_pos9:
    cmp dx, 0
    jge dx_pos9
    not dx
    add dx, 1
    xor di, 1
dx_pos9:
    mul dx
    cmp di, 1
    jne term_done9
    not ax
    add ax, 1
term_done9:
    add [accum], ax

    mov al, [weights + 11]
    mov ah, 0
    test al, 0x80
    jz bias_pos3
    mov ah, 0xff
bias_pos3:
    add [accum], ax
    mov bx, [accum]
    mov [atk_score], bx

    mov ax, [norm_score]
    mov bx, [sus_score]
    
    cmp ax, bx
    jl check_sus

    cmp ax, [atk_score]
    jl check_atk         
    
    mov byte [pred_flag], 1
    jmp next_obs

check_sus:
    mov bx, [sus_score]
    cmp bx, [atk_score]
    jl check_atk         
    
    mov byte [pred_flag], 2  
    jmp next_obs

check_atk:
    mov byte [pred_flag], 3  

next_obs:
    add si, 2
    mov cx, [current_count]
    dec cx
    mov [current_count], cx
    jnz loop_obs

    mov ax, 0x4c00
    int 0x21


obs:            dw 0x6552, 0x2c91, 0x7fa3
num_obs:        db 3
weights:        db 2, -3, -1, 10
                db 1, 4, 2, 0
                db -2, 5, 4, -5

norm_score:     dw 0
sus_score:      dw 0
atk_score:      dw 0
pred_flag:      db 0

x1:             dw 0
x2:             dw 0
x3:             dw 0
current_count:  dw 0
accum:          dw 0
