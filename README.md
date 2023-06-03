# MPU6050-complementary-filter-in-assembly

### Devices required:
- STM32F446RE or anything compatible with Cortex-M4 and ARMv7-M architecture.
- MPU6050 6-axis IMU.

### Compile & upload
Type `make compile upload`. But before doing this change STLink directory.

### Debugging
I'm using Cortex-Debug extension for VS Code to use GDB debugger. There is svd file provided for registers lookup.

### What's covered?
- UART interface    DONE
- I2C interface     DONE
- IMU algorithm     In progress

### arctan approximation functions:
Because I couldn't use build-in trigonometric functions (they don't exist in ARM Thumb, or DSP and FPU extensions of Cortex-M4), I could use CORDIC algorithm or Taylor series but I found some approximation functions in this article: [Fast computation of arctangent functions for embedded applications: A comparative analysis](https://www.researchgate.net/publication/259385247_Fast_computation_of_arctangent_functions_for_embedded_applications_A_comparative_analysis). Arctan function is necessary for complementary function. I wanted to avoid lookup table techniques and interpolation.

# $$arctan(x) \approx \frac{x}{1 + 0.28125x^2}$$

# $$arctan(x) \approx \frac{\pi}{4}x + 0.273x(1 -\left| x \right|)$$

# $$arctan(x) \approx \frac{\pi}{4}x - x(\left| x \right| - 1)(0.2447 + 0.0663 \left| x \right|)$$

The x should be between -1 and 1 Radians but the second solution gets quite good results between -1.5 and 1.5 Radians. (1.5 Radians = 85.94 degrees).

**Then we have to compute atan2.**


### TODO:
- *I didn't noticed that DSP extension of Cortex-M4 doesn't support trigonometric function instructions like AARCH64 therefore I need to look for different filter function or write from scratch these functions (arctan, atan2 etc.).*
- *Improve the efficiency and final refactor.*
- *Write a clear restart for MPU6050 from freeze which occurs for example when debugging.*
