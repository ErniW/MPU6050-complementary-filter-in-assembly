.include "includes/i2c.inc"

.extern i2c_buffer

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


I2C_DEVICE_ADDR .req r4
I2C_REGISTER_ADDR .req r5
I2C_DATA .req r6
I2C_DATA_LENGTH .req r7

i2c_write:
    push {lr}

    /*
    while(I2C1->SR2 & I2C_SR2_BUSY);
    I2C1->CR1 |= I2C_CR1_START;
    */

    ldr STATUS_REG, =I2C1_SR2
    mov FLAG, I2C_SR2_BUSY
    bl wait_for_flag_clear

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_START
    bl bit_set

    /*
    while(!(I2C1->SR1 & I2C_SR1_SB));
    I2C1->DR = saddr << 1;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_SB
    bl wait_for_flag_set

    ldr r1, =I2C1_DR
    mov r2, I2C_DEVICE_ADDR
    lsl r2, r2, #1
    str r2, [r1]

    /*
    while (!(I2C1->SR1 & I2C_SR1_ADDR));
    tmp = I2C1->SR2; //access to clear status register
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_ADDR
    bl wait_for_flag_set

    ldr STATUS_REG, =I2C1_SR2
    ldr FLAG, [STATUS_REG]

    /*
    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->DR = maddr;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_TXE
    bl wait_for_flag_set    

    ldr r1, =I2C1_DR
    mov r2, I2C_REGISTER_ADDR
    str r2, [r1]

    /*
    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->DR = *data++;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_TXE
    bl wait_for_flag_set  

    ldr r1, =I2C1_DR
    mov r2, I2C_DATA
    str r2, [r1]

    /*
    while(!(I2C1->SR1 & I2C_SR1_BTF));
    I2C1->CR1 |= I2C_CR1_STOP;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_BTF
    bl wait_for_flag_set  

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_STOP
    bl bit_set

    pop {lr}
    bx lr


i2c_read:
    push {lr}

    /*
    while(I2C1->SR2 & I2C_SR2_BUSY);
    I2C1->CR1 |= I2C_CR1_START;
    */

    ldr STATUS_REG, =I2C1_SR2
    mov FLAG, I2C_SR2_BUSY
    bl wait_for_flag_clear

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_START
    bl bit_set

    /*
    while(!(I2C1->SR1 & I2C_SR1_SB));
    I2C1->DR = saddr << 1;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_SB
    bl wait_for_flag_set

    ldr r1, =I2C1_DR
    mov r2, I2C_DEVICE_ADDR
    lsl r2, r2, #1
    str r2, [r1]

    /*
    while (!(I2C1->SR1 & I2C_SR1_ADDR));
    tmp = I2C1->SR2; //access to clear status register
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_ADDR
    bl wait_for_flag_set

    ldr STATUS_REG, =I2C1_SR2
    ldr FLAG, [STATUS_REG]

    /*
    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->DR = maddr;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_TXE
    bl wait_for_flag_set    

    ldr r1, =I2C1_DR
    mov r2, I2C_REGISTER_ADDR
    str r2, [r1]

    /*
    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->CR1 |= I2C_CR1_START;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_TXE
    bl wait_for_flag_set 

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_START
    bl bit_set

    /*
    while(!(I2C1->SR1 & I2C_SR1_SB));
    I2C1->DR = saddr << 1 | 1;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_SB
    bl wait_for_flag_set

    ldr r1, =I2C1_DR
    mov r2, I2C_DEVICE_ADDR
    lsl r2, r2, #1
    orr r2, r2, #1
    str r2, [r1]

    /*
    while (!(I2C1->SR1 & I2C_SR1_ADDR));
    tmp = I2C1->SR2;
    */

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_ADDR
    bl wait_for_flag_set

    ldr STATUS_REG, =I2C1_SR2
    ldr FLAG, [STATUS_REG]

    /*
    I2C1->CR1 |= I2C_CR1_ACK;
    */

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_ACK
    bl bit_set

    /*
    Pętla while
    */

    mov r0, I2C_DATA_LENGTH
    ldr r8, =i2c_buffer

    read_data_loop:

        ldr STATUS_REG, =I2C1_SR1
        mov FLAG, I2C_SR1_RXNE
        bl wait_for_flag_set

        ldr r1, =I2C1_DR
        ldr r2, [r1], 4

        //push na stacka mi nic tutaj nie daje
        //push {r2}
        //ldr r3, =i2c_buffer
        str r2, [r8]
        add r8, r8, #4


        subs r0, r0, #1
        bne read_data_loop

    ldr     r0, =I2C1_CR1
    ldr     r1, [r0]
    bic     r1, R1, #I2C_CR1_ACK
    str     r1, [r0]

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_STOP
    bl bit_set

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_RXNE
    bl wait_for_flag_set

    ldr r1, =I2C1_DR
    ldr r2, [r1]

    //pop {r0-r5}
    /*
    ldr r1, =i2c_buffer
    mov r2, sp
    mov r3, I2C_DATA_LENGTH

    ldm r2!, {r0-r5}
    stm r1!, {r0-r5}
    */

    pop {lr}
    bx lr