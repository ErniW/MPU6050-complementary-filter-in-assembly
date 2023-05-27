.syntax unified
.thumb

.include "includes/main.inc"
.include "includes/uart.inc"

.include "src/uart.S"

.section .text

.globl  main
.word   main

.thumb_func
main:

    ldr r0, =RCC_AHB1ENR
    ldr r1, =RCC_APB1ENR
    ldr r2, =GPIOA_MODER
    ldr r3, =GPIOA_AFR1
    
    ldr r4, [r0]
    ldr r5, [r1]
    ldr r6, [r2]
    ldr r7, [r3]

    orr r4, GPIOA_EN
    orr r5, RCC_USART2_EN
    orr r6, PA2_AF_MODE
    orr r7, PA2_AF_USART2_TX

    str r4, [r0]
    str r5, [r1]
    str r6, [r2]
    str r7, [r3]

    bl  uart_init

loop:
    mov r0, #'T'
    bl  uart_write

    mov	r0, #'E'
    bl  uart_write

    mov r0, #'S'
    bl  uart_write

    mov r0, #'T'
    bl  uart_write

    mov r0, #'\n'
    bl  uart_write

    b   loop

    .align
    .end

/*
.thumb_func
main:
   
    ldr     r0, =RCC_AHB1ENR
    ldr     r1, [r0]
    orr     r1, GPIOA_EN
    str     r1, [r0]

    ldr     r0, =GPIOA_MODER
    ldr     r1, [r0]
    orr     r1, MODER5_OUT
    str     r1, [r0]

    mov     r1, 0
    ldr     r2, =GPIOA_ODR


Blink:

    eor     r1, LED_ON
    str     r1, [r2]
    ldr     r3, =INTERVAL
    bl      Delay
    b       Blink


Delay:

    subs    r3, r3, 1
    bne     Delay
    bx      lr


    .align
    .end
*/