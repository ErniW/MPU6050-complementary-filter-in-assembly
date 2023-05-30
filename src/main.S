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

    tmp: .word

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
    mov r2, #0
    bl concat_i2c_buffer_to_number

    ldr r1, =accy
    mov r2, #8
    bl concat_i2c_buffer_to_number

    ldr r1, =accz
    mov r2, #16
    bl concat_i2c_buffer_to_number


    mov I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov I2C_REGISTER_ADDR, MPU6050_READ_GYRO
    mov I2C_DATA_LENGTH, 6
    bl i2c_read

    ldr r0, =i2c_buffer

    ldr r1, =gyrox
    mov r2, #0
    bl concat_i2c_buffer_to_number

    ldr r1, =gyroy
    mov r2, #8
    bl concat_i2c_buffer_to_number

    ldr r1, =gyroz
    mov r2, #16
    bl concat_i2c_buffer_to_number

    mov r0, #'A'
    bl  uart_write_char

    mov r0, #' '
    bl  uart_write_char

    ldr r0, =accx
    ldrsh r4, [r0]
    bl uart_write_digit

    mov r0, #'\t'
    bl  uart_write_char

    ldr r0, =accy
    ldrsh r4, [r0]
    bl uart_write_digit

    mov r0, #'\t'
    bl  uart_write_char

    ldr r0, =accz
    ldrsh r4, [r0]
    bl uart_write_digit

    mov r0, #'\t'
    bl  uart_write_char

    mov r0, #'G'
    bl  uart_write_char

    mov r0, #' '
    bl  uart_write_char

    ldr r0, =gyrox
    ldrsh r4, [r0]
    bl uart_write_digit

    mov r0, #'\t'
    bl  uart_write_char

    ldr r0, =gyroy
    ldrsh r4, [r0]
    bl uart_write_digit

    mov r0, #'\t'
    bl  uart_write_char

    ldr r0, =gyroz
    ldrsh r4, [r0]
    bl uart_write_digit

    mov r0, #'\n'
    bl  uart_write_char
    
    b   loop

.align
.end
