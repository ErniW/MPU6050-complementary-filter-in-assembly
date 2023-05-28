.syntax unified
.include "includes/uart.inc"

uart_init:

    ldr r0, =RCC_APB1ENR
    ldr r1, [r0]
    orr r1, RCC_USART2_EN
    str r1, [r0]

    ldr r0, =RCC_AHB1ENR
    ldr r1, [r0]
    orr r1, GPIOA_EN 
    str r1, [r0]

    ldr r0, =USART2_BRR
    mov r1, #BRR_VALUE
    str r1, [r0]

    ldr r0, =USART2_CR1
    ldr r1, =USART2_CR1_TE | USART2_CR1_UE
    str r1, [r0]

    ldr r0, =GPIOA_MODER
    ldr r1, [r0]
    orr r1, PA2_AF_MODE
    str r1, [r0]

    ldr r0, =GPIOA_AFRL
    ldr r1, [r0]
    orr r1, PA2_AF_USART2_TX
    str r1, [r0]

     

    ; ldr r0, =RCC_AHB1ENR
    ; ldr r1, [r0]
    ; orr r1, GPIOA_EN 
    ; str r1, [r0]

    ; ldr r0, =USART2_BRR
    ; ldr r1, =USART2_CR1

    ; mov r2, #BRR_VALUE
    ; ldr r3, =USART2_CR1_TE | USART2_CR1_UE

    ; str r2, [r0]
    ; str r3, [r1]

    ; ldr r2, =GPIOA_MODER
    ; ldr r3, =GPIOA_AFRL

    ; ldr r6, [r2]
    ; ldr r7, [r3]

    ; orr r6, PA2_AF_MODE
    ; orr r7, PA2_AF_USART2_TX

    ; str r6, [r2]
    ; str r7, [r3]

    ; ldr r1, =RCC_APB1ENR
    ; ldr r3, [r1]
    ; orr r3, RCC_USART2_EN
    ; str r3, [r1]

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
