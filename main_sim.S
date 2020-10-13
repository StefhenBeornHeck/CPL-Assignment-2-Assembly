mov sp, 255           ; Set SP
call .Lsum_of_squares ; Calculate the sum of the squares
push a                ; Push value of register A onto the stack
call .Lsquare_of_sum  ; Calculate the square of the sums
pop b                 ; Pop result of "sum_of_squares" into register B 
sub a, b              ; Subtract B from A and store result in A
mov d, a              ; Copy value from A to D
mov c, 0x2E0          ; Point register C to output
call format_number    ; Format the number and print
hlt                   ; Halt execution

.Lsum_of_squares:
    push b                    ; Push value of B onto stack
    push c                    ; Push value of C onto stack

    mov c, 0                  ; Store 0 in C (value of the sum)
    mov b, 0                  ; Store 0 in B (value of i)

    .Lsum_of_squares_loop:    ; A "for-loop"
    inc b                     ; Increment B
    mov a, b                  ; Copy B to A
    mul a                     ; Multiply A with A and store result in A
    add c, a                  ; Add C and A and store result in A
    cmp b, 10                 ; Compare B with 10
    jb .Lsum_of_squares_loop  ; Do the loop again if B is below 10 

    mov a, c                  ; Copy C to A
    pop c                     ; Set original value back
    pop b                     ; Set original value back
    ret                       ; Return

.Lsquare_of_sum:
    push b

    mov a, 0                ; sum
    mov b, 0                ; i

    .Lsquare_of_sum_loop:
    inc b.                  ; increment b
    mov c, b.               ; c = b
    add a, c                ; c + a
    cmp b, 10               ; b == 10
    jb .Lsquare_of_sum_loop ; false => jump

    mul a                   ; square
    pop b 
    ret

; args: d (num), c (out ptr)
format_number:
    ; calculate length of the printed number and increment c as necessary
    mov a, d
    dec c
    .Lformat_number_length_loop:
    div 10
    inc c
    cmp a, 0
    jnz .Lformat_number_length_loop

    .Lformat_number_print_loop:
    ; mod = rsi - rsi / 10 * 10
    mov a, d                        ; divisor
    div 10                          ; a = d / 10
    mul 10                          ; a = d / 10 * 10
    mov b, d                        ; b = d
    sub b, a                        ; b (mod) = d - d / 10 * 10
    add b, 48                       ; num -> ascii

    movb [c], bl                    ; *out = mod
    dec c                           ; out++
    
    mov a, d                        ; divisor
    div 10                          ; a = c / 10
    mov d, a                        ; d = c / 10
    cmp d, 0                        ; d == 0
    jnz .Lformat_number_print_loop: ; false => jump

    ret
