; Example 1.1:
; Writes "Hello World!" to the text display

	mov sp, 255		; Set SP
	call .Lsum_of_squares
    push a
    call .Lsquare_of_sum
    pop b
    sub a, b
    mov d, a
	mov c, 0x2EF	; Point register C to output
	call format_number
	hlt				; Halt execution

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

; args: d (num), c (out ptr)
format_number:
    ; mod = rsi - rsi / 10 * 10
    mov a, d          # divisor
    div 10            # a = d / 10
    mul 10            # a = d / 10 * 10
    mov b, d          # b = d
    sub b, a          # b (mod) = d - d / 10 * 10
    add b, 48         # num -> ascii

    movb [c], bl      # *out = mod
    dec c             # out++

    mov a, d          # divisor
    div 10            # a = c / 10
    mov d, a          # d = c / 10
    cmp d, 0          # d == 0
    jnz format_number # false => jump

    ret
