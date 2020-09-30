# as main.as -o main.o && gcc main.o -o main

.intel_syntax noprefix

.globl main
main:
    push rax
    lea rdi, [rip + .Lstring]
    mov rsi, rax
    xor eax, eax
    call printf
    pop rax
    retq

.data
.Lstring:
.asciz "Hello, World!\n"
