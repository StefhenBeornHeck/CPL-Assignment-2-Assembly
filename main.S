# as main.as -o main.o && gcc main.o -o main

.intel_syntax noprefix

.globl main
main:
    push rax

    call .Lsum_of_squares
    mov rsi, rax

    call .Lsquare_of_sum
    mov rdx, rax

    lea rdi, [rip + .Lstring]
    xor eax, eax
    call printf

    pop rax
    retq


.Lsum_of_squares:
    push rbx

    mov rax, 0 # sum
    mov bx, 0 # i

    1:
    inc bx
    mov cx, bx
    imul cx, cx
    add ax, cx
    cmp bx, 10
    jb 1b

    pop rbx
    ret

.Lsquare_of_sum:
    push rbx

    mov rax, 0 # sum
    mov bx, 0 # i

    1:
    inc bx
    mov cx, bx
    add ax, cx
    cmp bx, 10
    jb 1b

    imul ax, ax
    pop rbx
    ret


.data
.Lstring:
.asciz "Hello, World! %d %d\n"
