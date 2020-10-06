.Lsum_of_squares:
    push b
    push c

    mov c, 0 # sum
    mov b, 0 # i

    .Lsum_of_squares_loop:
    inc b
    mov a, b
    mul a # square
    add c, a
    cmp b, 10
    jb .Lsum_of_squares_loop

    mov a, c
    pop c
    pop b
    ret

.Lsquare_of_sum:
    push b

    mov a, 0 # sum
    mov b, 0 # i

    .Lsquare_of_sum_loop:
    inc b
    mov c, b
    add a, c
    cmp b, 10
    jb .Lsquare_of_sum_loop

    mul a # square
    pop b
    ret
