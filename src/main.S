.syntax unified
.thumb

.include "includes/main.inc"

.section .text

.globl main
.word main

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
