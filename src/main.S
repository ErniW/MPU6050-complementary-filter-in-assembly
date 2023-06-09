.syntax unified
.thumb
//.fpu softvfp

.include    "includes/main.inc"
.include    "includes/mpu_6050.inc"

.include    "src/utils.S"
.include    "src/uart.S"
.include    "src/i2c.S"
.include    "src/mpu_6050.S"
.include    "src/imu.S"

.section .data
.align 4

    i2c_buffer: .word 0, 1, 2, 3, 4, 5
    accx:       .hword 0
    accy:       .hword 0
    accz:       .hword 0
    gyrox:      .hword 0
    gyroy:      .hword 0
    gyroz:      .hword 0
    roll:       .float 0
    pitch:      .float 0

    PI:             .float 3.14159265358979323846
    dtime:          .float 0.01
    a_sensitivity:  .float 16384.0
    g_sensitivity:  .float 131.0
    deg:            .float 180.0
    rad_to_deg:     .float 57.2957764
    deg_to_rad:     .float 0.01745329
    filter_alpha:   .float 0.98
    filter_beta:    .float 0.02

.section .bss
.align 4

    tmp:    .word

.section .text

.globl  main
.word   main

.thumb_func
main:

    ldr     REG, =SCB_CPACR
    mov     BIT, ENABLE_FPU
    bl      bit_set
    dsb
    isb

    ldr     REG, =RCC_AHB1ENR
    mov     BIT, GPIOA_EN | GPIOB_EN
    bl      bit_set

    bl      uart_init
    bl      i2c_init
    bl      mpu_6050_init

loop:

    bl      mpu_6050_read_accel
    bl      mpu_6050_read_gyro

    # not yet implemented
    # bl      get_imu_orientation

    mov     r0, #'A'
    bl      uart_write_char
    mov     r0, #' '
    bl      uart_write_char

    ldr     r0, =accx
    ldrsh   r4, [r0]
    bl      uart_write_digit

    mov     r0, #'\t'
    bl      uart_write_char

    ldr     r0, =accy
    ldrsh   r4, [r0]
    bl      uart_write_digit

    mov     r0, #'\t'
    bl      uart_write_char

    ldr     r0, =accz
    ldrsh   r4, [r0]
    bl      uart_write_digit

    mov     r0, #'\t'
    bl      uart_write_char

    mov     r0, #'G'
    bl      uart_write_char
    mov     r0, #' '
    bl      uart_write_char

    ldr     r0, =gyrox
    ldrsh   r4, [r0]
    bl      uart_write_digit

    mov     r0, #'\t'
    bl      uart_write_char

    ldr     r0, =gyroy
    ldrsh   r4, [r0]
    bl      uart_write_digit

    mov     r0, #'\t'
    bl      uart_write_char

    ldr     r0, =gyroz
    ldrsh   r4, [r0]
    bl      uart_write_digit

    mov     r0, #'\n'
    bl      uart_write_char
    
    b   loop

.align
.end
