.syntax unified
.thumb

.include "includes/main.inc"
.include "includes/mpu_6050.inc"

.include "src/utils.S"
.include "src/uart.S"
.include "src/i2c.S"

.section .data
.align 4

    i2c_buffer: .word 0, 1, 2, 3, 4, 5
    accx: .hword 0
    accy: .hword 0
    accz: .hword 0
    gyrox: .hword 0
    gyroy: .hword 0
    gyroz: .hword 0

.section .bss
.align 4

    tmp: .word 0

.section .text

.globl  main
.word   main

.thumb_func
main:

    ldr REG, =RCC_AHB1ENR
    mov BIT, GPIOA_EN | GPIOB_EN
    bl  bit_set

    bl  uart_init
    bl  i2c_init
    
    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_RESET
    mov I2C_DATA, 0x00
    bl i2c_write
    
    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_ACCEL_CONFIG
    mov I2C_DATA, 0x00
    bl i2c_write

    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_GYRO_CONFIG
    mov I2C_DATA, 0x00
    bl i2c_write
    
    

loop:

    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_READ_ACCEL
    mov I2C_DATA_LENGTH, 6
    bl i2c_read

    ldr r0, =i2c_buffer
    ldr r1, =accx
    
    ldr r2, [r0]
    ldr r3, [r0, #4]

    lsl r2, r2, #8
    orr r2, r2, r3
    sxth r2, r2
    strh r2, [r1]

    ldr r0, =i2c_buffer
    ldr r1, =accy
    
    ldr r2, [r0, #8]
    ldr r3, [r0, #12]

    lsl r2, r2, #8
    orr r2, r2, r3
    sxth r2, r2
    strh r2, [r1]

    ldr r0, =i2c_buffer
    ldr r1, =accz
    
    ldr r2, [r0, #16]
    ldr r3, [r0, #20]

    lsl r2, r2, #8
    orr r2, r2, r3
    sxth r2, r2
    strh r2, [r1]

    ldr r0, =accx
    ldr r2, =accy
    ldr r4, =accz

    ldrsh r1, [r0]
    ldrsh r3, [r2]
    ldrsh r5, [r4]

    mov r0, #'T'
    bl  uart_write_char

    mov	r0, #'E'
    bl  uart_write_char

    mov r0, #'S'
    bl  uart_write_char

    mov r0, #'T'
    bl  uart_write_char

    mov r0, #'\n'
    bl  uart_write_char

    b   loop

    .align
    .end




