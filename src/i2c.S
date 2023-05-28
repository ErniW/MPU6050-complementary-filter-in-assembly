.include "includes/i2c.inc"

i2c_init:

    push {r4-r7, lr}

    ldr REG, =RCC_APB1ENR
    mov BIT, RCC_APB1ENR_I2C1EN
    bl bit_set

    ldr REG, =GPIOB_MODER
    mov BIT, PB8_AF_MODE | PB9_AF_MODE
    bl  bit_set

    ldr REG, =GPIOB_OTYPER
    mov BIT, GPIO_OTYPER_OT8 | GPIO_OTYPER_OT9
    bl  bit_set
    
    ldr REG, =GPIOB_PUPDR
    mov BIT, PB8_PULLUP | PB9_PULLUP
    bl  bit_set

    ldr REG, =GPIOB_AFRH
    mov BIT, PB8_AF4_I2C_SCL | PB9_AF4_I2C_SDA
    bl  bit_set

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_SWRST
    bl  bit_set

    ldr     r0, =I2C1_CR1
    ldr     r1, [r0]
    bic     r1, R1, #I2C_CR1_SWRST
    str     r1, [r0]

    ldr REG, =I2C1_CR2
    mov BIT, I2C1_FREQ
    bl  bit_set

    ldr REG, =I2C1_CCR
    mov BIT, I2C_CLOCK_CONTROL
    bl  bit_set

    ldr REG, =I2C1_TRISE
    mov BIT, SD_MODE_MAX_RISE_TIME
    bl  bit_set

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_PE
    bl  bit_set

    pop {r4-r7, lr}
    bx lr

i2c_write:
    push {lr}

    

    pop {lr}
    bx lr