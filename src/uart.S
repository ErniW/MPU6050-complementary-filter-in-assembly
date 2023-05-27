.syntax unified
.include "includes/uart.inc"

uart_init:

    ldr r0, =USART2_BRR
    ldr r1, =USART2_CR1

    mov r2, #BRR_VALUE
    ldr r3, =USART2_CR1_TE | USART2_CR1_UE

    str r2, [r0]
    str r3, [r1]

    bx lr

uart_write:

    ldr r1, =USART2_SR

wait_for_tx:

    ldr r2, [r1]
    and r2, #USART2_SR_TXE
    cmp r2, #0
    beq wait_for_tx

    mov  r1,r0
    ldr r2,=USART2_DR
    str r1,[r2]
    bx  lr