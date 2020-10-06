# as main.S -o main.o && gcc main.o -o main

.intel_syntax noprefix

.globl main
main:
    push rax

    call .Lsum_of_squares
    movzx rsi, ax

    call .Lsquare_of_sum
    movzx rdx, ax

    lea rdi, [rip + .Lstring]
    xor eax, eax
    call printf

    pop rax
    retq


.Lsum_of_squares:
    push rbx
    push rcx

    mov cx, 0 # sum
    mov bx, 0 # i

    1:
    inc bx
    mov ax, bx
    mul ax # square
    add cx, ax
    cmp bx, 10
    jb 1b

    mov ax, cx
    pop rcx
    pop rbx
    ret

.Lsquare_of_sum:
    push rbx

    mov ax, 0 # sum
    mov bx, 0 # i

    1:
    inc bx
    mov cx, bx
    add ax, cx
    cmp bx, 10
    jb 1b

    mul ax # square
    pop rbx
    ret


.data
.Lstring:
.asciz "Hello, World! %d %d\n"
