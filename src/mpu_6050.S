mpu_6050_init:
    push    {lr}
    mov     I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov     I2C_REGISTER_ADDR, MPU6050_RESET
    mov     I2C_DATA, 0x00
    bl      i2c_write
    
    mov     I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov     I2C_REGISTER_ADDR, MPU6050_ACCEL_CONFIG
    mov     I2C_DATA, 0x00
    bl      i2c_write

    mov     I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov     I2C_REGISTER_ADDR, MPU6050_GYRO_CONFIG
    mov     I2C_DATA, 0x00
    bl      i2c_write
    pop     {lr}
    bx      lr

mpu_6050_read_gyro:

    push    {lr}

    mov     I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov     I2C_REGISTER_ADDR, MPU6050_READ_GYRO
    mov     I2C_DATA_LENGTH, 6
    bl      i2c_read

    ldr     r0, =i2c_buffer

    ldr     r1, =gyrox
    mov     r2, #0
    bl      concat_i2c_buffer_to_number

    ldr     r1, =gyroy
    mov     r2, #8
    bl      concat_i2c_buffer_to_number

    ldr     r1, =gyroz
    mov     r2, #16
    bl      concat_i2c_buffer_to_number

    pop     {lr}
    bx      lr

mpu_6050_read_accel:

    push    {lr}

    mov     I2C_DEVICE_ADDR, MPU6050_ADDRESS
    mov     I2C_REGISTER_ADDR, MPU6050_READ_ACCEL
    mov     I2C_DATA_LENGTH, 6
    bl      i2c_read

    ldr     r0, =i2c_buffer

    ldr     r1, =accx
    mov     r2, #0
    bl      concat_i2c_buffer_to_number

    ldr     r1, =accy
    mov     r2, #8
    bl      concat_i2c_buffer_to_number

    ldr     r1, =accz
    mov     r2, #16
    bl      concat_i2c_buffer_to_number

    pop     {lr}
    bx      lr
    