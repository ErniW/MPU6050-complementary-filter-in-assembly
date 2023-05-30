REG .req r0
BIT .req r1

bit_set:
    ldr r2, [REG]
    orr r2, r2, BIT
    str r2, [REG]
    bx lr

STATUS_REG .req r1
FLAG .req r2

wait_for_flag_set:
    ldr r3, [STATUS_REG]
    tst r3, FLAG
    beq wait_for_flag_set
    bx lr

wait_for_flag_clear:
    ldr r3, [STATUS_REG]
    tst r3, FLAG
    bne wait_for_flag_clear
    bx lr

concat_i2c_buffer_to_number:

    push {lr}

    ldr r3, [r0, r2]
    add r2, r2, #4
    ldr r4, [r0, r2]

    lsl r3, r3, #8
    orr r3, r3, r4
    sxth r3, r3
    strh r3, [r1]

    pop {lr}
    bx lr
    