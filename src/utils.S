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
    and r3, r3, FLAG
    cmp r3, #0
    beq wait_for_flag_set
    bx lr

wait_for_flag_clear:

    ldr r3, [STATUS_REG]
    and r3, r3, FLAG
    cmp r3, #0
    bne wait_for_flag_clear
    bx lr