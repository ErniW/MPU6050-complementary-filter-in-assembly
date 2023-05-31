.include "includes/uart.inc"

uart_init:
    
    push    {r4-r7, lr}

    ldr     REG, =RCC_APB1ENR
    mov     BIT, RCC_USART2_EN
    bl      bit_set

    ldr     REG, =USART2_BRR
    mov     BIT, BRR_VALUE
    bl      bit_set

    ldr     REG, =USART2_CR1
    mov     BIT, USART2_CR1_TE | USART2_CR1_UE
    bl      bit_set

    ldr     REG, =GPIOA_MODER
    mov     BIT, PA2_AF_MODE
    bl      bit_set

    ldr     REG, =GPIOA_AFRL
    mov     BIT, PA2_AF_USART2_TX
    bl      bit_set

    pop     {r4-r7, pc}
    bx      lr

uart_write_char:
    push    {lr}

    ldr     STATUS_REG, =USART2_SR
    mov     FLAG, USART2_SR_TXE
    bl      wait_for_flag_set

    mov     r1, r0
    ldr     r2, =USART2_DR
    str     r1, [r2]

    pop     {lr}
    bx      lr

uart_write_digit:
    push    {lr}

    cmp     r4, #0
    bge     positive_number

    mov     r0, #'-'
    bl      uart_write_char
    rsbs    r4, r4, #0

    positive_number:
        mov     r0, r4 
        mov     r1, #10
        mov     r6, #0

    convert_digit_loop:
        udiv    r3, r0, r1
        mov     r5, r3
        mul     r3, r3, r1
        sub     r2, r0, r3

        push    {r2}
        add     r6, r6, #1
        mov     r0, r5
        cmp     r0, #0
        bne     convert_digit_loop

    print_digits_loop:
        pop     {r0}
        subs    r6, r6, #1
        add     r0, r0, #'0'
        bl      uart_write_char
        cmp     r6, #0
        bne     print_digits_loop

    pop     {lr}
    bx      lr
    