
/*
I2C_DEVICE_ADDR .req r4
I2C_REGISTER_ADDR .req r5
I2C_DATA .req r6
*/
.equ I2C_DEVICE_ADDR,    0x68
.equ I2C_REGISTER_ADDR, 0x6B
.equ I2C_DATA,          0x00

I2C_DEVICE_ADDR .req r4
I2C_REGISTER_ADDR .req r5
I2C_DATA .req r6
STATUS_REG .req r7
FLAG .req r8

i2c_write:
    push {lr}

    ldr I2C_DEVICE_ADDR, =0x68
    ldr I2C_REGISTER_ADDR, =0x6B
    ldr I2C_DATA, =0x00

    ldr r7, =I2C1_SR2
    mov r8, #I2C_SR2_BUSY
    bl wait_for_flag_clear

    ldr r7, =I2C1_CR1
    mov r8, #I2C_CR1_START
    bl bit_set

    ldr r7, =I2C1_SR1
    mov r8, #I2C_SR1_SB
    bl wait_for_flag_set

    ldr r1, =I2C1_DR
    ldr r2, =I2C_DEVICE_ADDR
    lsl r2, r2, #1
    str r2, [r1]

    ldr r7, =I2C1_SR1
    mov r8, #I2C_SR1_ADDR
    bl wait_for_flag_set

    ldr r7, =I2C1_SR2
    ldr r2, [r7]
    mov r3, r2

    ldr r1, =I2C1_DR
    ldr r2, =I2C_REGISTER_ADDR
    str r2, [r1]

    ldr r7, =I2C1_SR1
    mov r8, #I2C_SR1_TXE
    bl wait_for_flag_set

    ldr r1, =I2C1_DR
    ldr r2, =I2C_DATA
    str r2, [r1]

    ldr r7, =I2C1_SR1
    mov r8, #I2C_SR1_BTF
    bl wait_for_flag_set

    ldr r7, =I2C1_CR1
    mov r8, #I2C_CR1_STOP
    bl bit_set

    pop {lr}
    bx lr
/*
I2C_DEVICE_ADDR .req r4
I2C_REGISTER_ADDR .req r5
I2C_DATA .req r6
*/
i2c_write_3:
    push {lr}

    ldr STATUS_REG, =I2C1_SR2
    mov FLAG, I2C_SR2_BUSY
    bl wait_for_flag_clear

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_START
    bl  bit_set

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_SB
    bl wait_for_flag_set


    /*
    mov r1, I2C_DEVICE_ADDR
    lsl r1, r1, #1
    ldr r2, =I2C1_DR
    str r1, [r2]
    */
    /*
    .equ addralt, (0x68 << 1)
    ldr r1, =I2C1_DR
    mov r2, addralt
    str r2, [r1]

    // tutaj się blokuje???
    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_ADDR
    bl wait_for_flag_set
    */
    /*
    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_ADDR
    bl wait_for_flag_set
    ldr r1, =I2C1_DR
    mov r2, (0x68 << 1)
    str r2, [r1]
    */
    ldr STATUS_REG, =I2C1_SR2
    ldr r2, [STATUS_REG]
    mov r1, r3

    //tmp = I2C1->SR

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_TXE
    bl wait_for_flag_set

    //I2C1->DR = maddr;
    ldr r1, =I2C1_DR
    mov r1, I2C_REGISTER_ADDR

    //mov r1, I2C_REGISTER_ADDR
    //str r2, [REG]

    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_TXE
    bl wait_for_flag_set
    
    //I2C1->DR = *data++; //wystarczy 1 raz, pomijam pętle for
    ldr r1, =I2C1_DR
    mov r1, I2C_DATA


    ldr STATUS_REG, =I2C1_SR1
    mov FLAG, I2C_SR1_BTF
    bl wait_for_flag_set

    ldr REG, =I2C1_CR1
    mov BIT, I2C_CR1_STOP
    bl  bit_set

    pop {lr}
    bx lr

/*
I2C_DEVICE_ADDR .req r4
I2C_REGISTER_ADDR .req r5
I2C_DATA .req r6
*/
/*

i2c_write2:
    push {lr}

    ldr r0, =I2C1_SR2
    mov r1, I2C_SR2_BUSY
    bl wait_for_flag_clear

    ldr r0, =I2C1_CR1
    ldr r1, [r0]
    orr r1, r1, I2C_CR1_START
    str r1, [r0]

    ldr r0, =I2C1_SR1
    mov r1, I2C_SR1_SB
    bl wait_for_flag_set

    ldr r0, =I2C1_DR
    mov r1, I2C_DEVICE_ADDR
    lsl r1, r1, #1
    str r1, [r0]

    ldr r0, =I2C1_SR1
    mov r1, I2C_SR1_ADDR
    bl wait_for_flag_set

    ldr r0, =I2C1_SR2
    ldr r2, [r0]
    mov r1, r2

    ldr r0, =I2C1_SR1
    mov r1, I2C_SR1_TXE
    bl wait_for_flag_set

    ldr r0, =I2C1_DR
    mov r1, I2C_REGISTER_ADDR
    str r1, [r0]

    ldr r0, =I2C1_SR1
    mov r1, I2C_SR1_TXE
    bl wait_for_flag_set

    ldr r0, =I2C1_DR
    mov r1, I2C_DATA
    ldrb r2, [r1]
    str r2, [r0]

    ldr r0, =I2C1_SR1
    mov r1, I2C_SR1_BTF
    bl wait_for_flag_set

    ldr r0, =I2C1_CR1
    ldr r1, [r0]
    orr r1, r1, I2C_CR1_STOP
    str r1, [r0]

    pop {lr}
    bx lr
*/


i2c_read:


/*
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;
    RCC->APB1ENR |= RCC_APB1ENR_I2C1EN;

    GPIOB->MODER |= PB8_AF_MODE | PB9_AF_MODE;
    GPIOB->OTYPER |= GPIO_OTYPER_OT8 | GPIO_OTYPER_OT9;
    GPIOB->PUPDR |= PB8_PULLUP | PB9_PULLUP;
    GPIOB->AFR[1] |= PB8_AF4_I2C_SCL | PB9_AF4_I2C_SDA;

    I2C1->CR1 |= I2C_CR1_SWRST;
    I2C1->CR1 &=~ I2C_CR1_SWRST;

    I2C1->CR2 |= 45;//16;
    I2C1->CCR = 225;//I2C_100KHZ;
    I2C1->TRISE = SD_MODE_MAX_RISE_TIME;
    I2C1->CR1 |= I2C_CR1_PE;
    */


/* 
    void i2c_Write(char saddr, char maddr, int n, char* data){

    volatile int tmp;

    while(I2C1->SR2 & I2C_SR2_BUSY);
    I2C1->CR1 |= I2C_CR1_START;

    while(!(I2C1->SR1 & I2C_SR1_SB));
    I2C1->DR = saddr << 1;

    while (!(I2C1->SR1 & I2C_SR1_ADDR));
    tmp = I2C1->SR2;

    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->DR = maddr;

    for (int i=0; i<n; i++){

        while(!(I2C1->SR1 & I2C_SR1_TXE));
        I2C1->DR = *data++;
    }

    while(!(I2C1->SR1 & I2C_SR1_BTF));
    I2C1->CR1 |= I2C_CR1_STOP;
}
    
     */



    /*
    
    
void i2c_Read(char saddr, char maddr, int n, char* data){
    volatile int tmp;

    while(I2C1->SR2 & I2C_SR2_BUSY);
    I2C1->CR1 |= I2C_CR1_START;

    while(!(I2C1->SR1 & I2C_SR1_SB));
    I2C1->DR = saddr << 1;

    while(!(I2C1->SR1 & I2C_SR1_ADDR));
    tmp = I2C1->SR2;

    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->DR = maddr;

    while(!(I2C1->SR1 & I2C_SR1_TXE));
    I2C1->CR1 |= I2C_CR1_START;

    while(!(I2C1->SR1 & I2C_SR1_SB));
    I2C1->DR = saddr << 1 | 1;

    while (!(I2C1->SR1 & I2C_SR1_ADDR));
    tmp = I2C1->SR2;

    I2C1->CR1 |= I2C_CR1_ACK;

    while(n >0){
        if(n == 1){
            I2C1->CR1 &=~ I2C_CR1_ACK;
            I2C1->CR1 |= I2C_CR1_STOP;

            while (!(I2C1->SR1 & I2C_SR1_RXNE));
            *data++ = I2C1->DR;

            break;
        }
        else{

            while (!(I2C1->SR1 & I2C_SR1_RXNE));
            (*data++) = I2C1->DR;
            n--;
        }
    }
}
    
    */