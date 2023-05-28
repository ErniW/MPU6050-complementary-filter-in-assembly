.syntax unified
.thumb

.include "includes/main.inc"
.include "includes/mpu_6050.inc"

.include "src/utils.S"
.include "src/uart.S"
.include "src/i2c.S"

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

    //bl i2c_write

    /*
    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_RESET
    mov I2C_DATA, 0x00
    bl i2c_write
    */
/*
    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_ACCEL_CONFIG
    mov I2C_DATA, 0x00
    bl i2c_write

    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_GYRO_CONFIG
    mov I2C_DATA, 0x00
    bl i2c_write
    */
    

loop:

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



.section .data


.section .bss
.align 4
    tmp: .word
    accx: .word
    accy: .word
    accz: .word
    gyrox: .word
    gyroy: .word
    gyroz: .word
