# as main.S -o main.o && gcc main.o -o main

.intel_syntax noprefix

.globl main
main:
    push rax

#    lea rdi, [rip + temp]
#    mov rsi, 12
#    call format_number
#    retq

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

# args: rdi (out ptr), rsi (in num)
# rets: rax (out ptr)
.globl format_number
format_number:
    1:
    # mod = rsi - rsi / 10 * 10
    mov rax, rsi   # divisor lo
    mov rdx, 0     # divisor hi
    mov rcx, 10    # dividend
    div rcx        # rax = rsi:rdx / 10
    mul rcx        # rax = rsi / 10 * 10
    mov rbx, rsi   # rbx = rsi
    sub rbx, rax   # rbx (mod) = rsi - rsi / 10 * 10
    add rbx, 48
    mov [rdi], rbx # *out = mod
    inc rdi        # out++
    mov rax, rsi   # divisor lo
    mov rdx, 0     # divisor hi
    div rcx        # rax = rsi:rdx / 10
    mov rsi, rax   # rsi = rsi / 10
    cmp rsi, 0     # rsi == 0
    jnz 1b         # false => jump

    mov rax, rdi
    ret

.data
.Lstring:
.asciz "Hello, World! %d %d\n"

.globl temp
temp:
.asciz "\0\0\0\0\0\0\0\0"
