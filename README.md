# MPU6050-complementary-filter-in-assembly

### Devices required:
- STM32F446RE or anything compatible.
- MPU6050 6-axis IMU

### Compile & upload
Type `make compile upload`. But before doing this change STLink directory.

### Debugging
I'm using Cortex-Debug extension for VS Code to use GDB debugger. There is svd file provided for registers lookup.

### What's covered?
- UART interface    DONE
- I2C interface     DONE
- IMU algorithm     In progress

### TODO:
- *I didn't noticed that DSP extension of Cortex-M4 doesn't support trigonometric function instructions like AARCH64 therefore I need to look for different filter function or write from scratch these functions (arctan, atan2 etc.).*
- *Improve the efficiency and final refactor.*
- *Write a clear restart for MPU6050 from freeze which occu*