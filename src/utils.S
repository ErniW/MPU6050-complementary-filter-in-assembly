/*
; REG .req r0
; VAL .req r1

; bit_set:
;     ldr r1, r0

    ; ldr r1, =RCC_APB1ENR
    ; ldr r3, [r1]
    ; orr r3, RCC_USART2_EN
    ; str r3, [r1]

    ; ldr r0, =RCC_AHB1ENR
    ; ldr r1, [r0]
    ; orr r1, GPIOA_EN 
    ; str r1, [r0]
    */