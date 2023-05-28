.include "includes/uart.inc"

uart_init:
    
    push {r4-r7, lr}

    ldr REG, =RCC_APB1ENR
    mov BIT, RCC_USART2_EN
    bl bit_set

    ldr REG, =USART2_BRR
    mov BIT, BRR_VALUE
    bl bit_set

    ldr REG, =USART2_CR1
    mov BIT, USART2_CR1_TE | USART2_CR1_UE
    bl bit_set

    ldr REG, =GPIOA_MODER
    mov BIT, PA2_AF_MODE
    bl bit_set

    ldr REG, =GPIOA_AFRL
    mov BIT, PA2_AF_USART2_TX
    bl bit_set

    pop {r4-r7, pc}
    bx lr

uart_write_char:
    push {lr}

    ldr STATUS_REG, =USART2_SR
    mov FLAG, USART2_SR_TXE
    bl wait_for_flag_set

    mov  r1, r0
    ldr r2,=USART2_DR
    str r1,[r2]

    pop {lr}
    bx  lr
