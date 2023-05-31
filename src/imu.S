/*
get_imu_orientation:

    push {lr}

    //s0 = gz/g_sen * (PI / 180)
    //load gz, convert to float
    ldr r0, =gyroz
    ldrsh r1, [r0]
    vmov s0, r1
    vcvt.f32.s32 s0, s0  

    //gz / sensitivity
    ldr r0, =g_sensitivity
    vldr s1, [r0]
    vdiv.f32 s0, s0, s1
    
    // to radians
    ldr r0, =deg_to_rad
    vldr s1, [r0]

    vmul.f32 s0, s0, s1

    //s1 = roll, s2 = pitch
    //roll += gyroRateRadZ * dt;
    //pitch += gyroRateRadZ * dt;
    ldr r0, =roll
    vldr s1, [r0]
    ldr r1, =pitch
    vldr s2, [r1]

    ldr r2, =dtime
    vldr s4, [r2]
    // ldr r3, [r2]
    // vmov s4, r3

    vmul.f32 s3, s0, s4
    vadd.f32 s1, s1, s3
    vadd.f32 s2, s2, s3

    //save roll and pitch
    vstr s1, [r0]
    vstr s2, [r1]

    //sprawdzić poprawność wzoru
    //float accelAngleX = atan2(ay / A_SENSITIVITY, az / A_SENSITIVITY) * (180.0 / PI);
    
    //s0 = ax / sen s1  S1 = ay / sen s2= az / sen s3= rad_to_deg, s4= sen

    ldr r0, =accx
    ldrsh r1, [r0]
    vmov s0, r1
    vcvt.f32.s32 s0, s0  

    ldr r1, =accy
    ldrsh r2, [r1]
    vmov s1, r2
    vcvt.f32.s32 s1, s1  

    ldr r2, =accz
    ldrsh r3, [r2]
    vmov s2, r3
    vcvt.f32.s32 s2, s2  

    ldr r3, =rad_to_deg
    vldr s3, [r3]

    ldr r4, =a_sensitivity
    vldr s4, [r4]

    //divide acc axes by sensitivity
    vdiv.f32 s0, s0, s4
    vdiv.f32 s1, s1, s4
    vdiv.f32 s2, s2, s4

    //s5 accel_anglex
    vdiv.f32, s5, s1, s2
    vatan.f32 s5, s5
    vmul.f32 s5, s3

    //TODO: poszukać wzór na atan 
    //atan^2(a, b) = atan(b/a)
    //atan = 
    // normalized_atan(x) ~ (b x + x^2) / (1 + 2 b x + x^2)

    //s6 accel+angley
    //float accelAngleY = atan2(-ax /sen, sqrt((ay /sen) * (ay /sen) + (az /sen) * (az /sen))) * (180.0 / PI);
    vneg.f32 s0, s0
    
    //s7 ay^2
    //s8 az^2
    vmul.f32 s7, s1, s1
    vmul.f32 s8, s2, s2

    //s6 = s7 + s8
    vadd.f32 s6, s7, s8

    //sqrt s6
    vsqrt.f32 s6, s6

    //div -ax / s6
    vdiv.f32 s6, s0, s6

    //atan - unfortunately M4 architecture and DSP extension doesnt provide this function.
    vatan.f32 s6, s6

    //* rad_to_deg
    vmul.f32 s6, s6, s3



    //s0 = roll, s1 = pitch
    //s2 = filter_alpha, s3 = filter_beta
    //s5 = accelAngleX, s6 = accelAngleY

    //ldr r3, =rad_to_deg
    //vldr s3, [r3]
    
    ldr r0, =roll
    vldr s0, [r0]

    ldr r1, =pitch
    vldr s1, [r1]

    ldr r3, =filter_alpha
    vldr s2, [r3]

    ldr r4, =filter_beta
    vldr s3, [r4]

    //alpha * roll
    vmul.f32 s0, s0, s2

    //alpha * pitch
    vmul.f32 s1, s1, s2

    //beta * accelx
    vmul.f32 s5, s5, s3

    //beta * accely
    vmul.f32 s6, s6, s3

    //sum
    vadd.f32 s0, s0, s5
    vadd.f32 s1, s1, s6

    */

    //*roll = 0.98 * (*roll) + 0.02 * (accelAngleX);
    //*pitch = 0.98 * (*pitch) + 0.02 * (accelAngleY);
    /*
    ldr r0, =filter_alpha
    ldr r1, [r0]
    vmov s4, r1

    ldr r0, =filter_beta
    ldr r1, [r0]
    vmov s5, r1

    vmul.f32 s1, s1, s4
    vmul.f32 s1, s2, s4
    */


    


    /*
    ldr r0, =deg
    vldr s0, [r0]

    ldr r1, =PI
    vldr s1, [r1]

    vdiv.f32 s2, s0, s1 */
    
    //pop {lr}
    //bx lr

    // vcvt.s32.f32 s0, r1
    // vdiv.f32 s2, 
