.syntax unified
.thumb

.include "includes/main.inc"
.include "includes/uart.inc"
.include "includes/i2c.inc"

.include "src/utils.S"
.include "src/uart.S"
.include "src/i2c.S"

.section .text

.globl  main
.word   main

.thumb_func
main:

    ldr r0, =RCC_AHB1ENR
    ldr r1, [r0]
    orr r1, GPIOA_EN 
    str r1, [r0]
    
    bl  uart_init
    bl  i2c_init

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



.section .data



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