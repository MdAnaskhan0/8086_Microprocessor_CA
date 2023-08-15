.model small
.stack 100h
.data
    a dw ?
    b dw ?
    result dw ?
    check dw ?
    msg1 db 0Dh, 0Ah, 'Enter Two integer numbers Between 0 to 9: $'
    msg2 db 0Dh, 0Ah, 'Choice Operation:', 0Dh, 0Ah, '1.Addition', 0Dh, 0Ah, '2.Subtraction', 0Dh, 0Ah, '3.Multiplication', 0Dh, 0Ah, '4.Division', 0Dh, 0Ah, '$'
    msg3 db 0Dh, 0Ah, 'Addition: $'
    msg4 db 0Dh, 0Ah, 'Subtraction: $'
    msg5 db 0Dh, 0Ah, 'Multiplication: $'
    msg6 db 0Dh, 0Ah, 'Division: $'
    msg7 db 0Dh, 0Ah, 'Invalid choice...!$'
.code
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, msg1
    int 21h

    mov ah, 1
    int 21h
    sub al, 30h
    mov bh, 0
    mov bl, al
    mov a, bx

    mov ah, 1
    int 21h
    sub al, 30h
    mov bh, 0
    mov bl, al
    mov b, bx

    mov ah, 9
    lea dx, msg2
    int 21h

    mov ah, 1
    int 21h
    sub al, 30h
    mov bl, al
    mov check, bx

    cmp check, 1
    je addition
    cmp check, 2
    je subtraction
    cmp check, 3
    je multiplication
    cmp check, 4
    je division
    jmp invalid

addition:              
    mov ax, a    
    add ax, b   
    mov result, ax  
    
    mov ah, 9
    lea dx, msg3
    int 21h
    mov ah, 2
    mov dl, '='
    int 21h
    mov ax, result
    call display_result
    jmp exit

subtraction:
    mov ax, a
    sub ax, b
    mov result, ax
    
    mov ah, 9
    lea dx, msg4
    int 21h
    mov ah, 2
    mov dl, '='
    int 21h
    mov ax, result
    call display_result
    jmp exit

multiplication:
    mov ax, a
    mul b
    mov result, ax 
    
    mov ah, 9
    lea dx, msg5
    int 21h
    mov ah, 2
    mov dl, '='
    int 21h
    mov ax, result
    call display_result
    jmp exit

division:
    mov ax, a
    cwd
    idiv b
    mov result, ax   
    
    mov ah, 9
    lea dx, msg6
    int 21h
    mov ah, 2
    mov dl, '='
    int 21h
    mov ax, result
    call display_result
    jmp exit

invalid:
    mov ah, 9
    lea dx, msg7
    int 21h
    jmp exit

display_result:
    push ax
    push bx
    push cx
    push dx

    cmp ax, 0
    jns positive
    mov dl, '-'
    int 21h
    neg ax

positive:
    mov bx, 10
    xor cx, cx

convert_loop:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    test ax, ax
    jnz convert_loop

display_loop:
    pop dx
    mov ah, 2
    int 21h
    loop display_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret

exit:
    mov ah, 4Ch
    int 21h
end
