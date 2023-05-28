.equ I2C1_BASE,          0x40005400

.equ I2C_CR1_OFFSET,    0x00
.equ I2C_CR2_OFFSET,    0x04
.equ I2C_DR_OFFSET,     0x10
.equ I2C_SR1_OFFSET,    0x14
.equ I2C_SR2_OFFSET,    0x18
.equ I2C_CCR_OFFSET,    0x1C
.equ I2C_TRISE_OFFSET,  0x20

.equ I2C1_CR1,          (I2C1_BASE + I2C_CR1_OFFSET)
.equ I2C1_CR2,          (I2C1_BASE + I2C_CR2_OFFSET)
.equ I2C_DR,            (I2C1_BASE + I2C_DR_OFFSET)
.equ I2C_SR1,           (I2C1_BASE + I2C_SR1_OFFSET)
.equ I2C_SR2,           (I2C1_BASE + I2C_SR2_OFFSET)
.equ I2C1_CCR,          (I2C1_BASE + I2C_CCR_OFFSET)
.equ I2C1_TRISE,        (I2C1_BASE + I2C_TRISE_OFFSET)

.equ I2C_100KHZ, 80
.equ SD_MODE_MAX_RISE_TIME, 17

.equ GPIO_OTYPER_OT8, (1 << 8)
.equ GPIO_OTYPER_OT9, (1 << 9)

.equ PB8_AF_MODE, (1 << 17)
.equ PB9_AF_MODE, (1 << 19)

.equ PB8_AF4_I2C_SCL, (1 << 2)
.equ PB9_AF4_I2C_SDA, (1 << 6)

.equ PB8_PULLUP, (1 << 16)
.equ PB9_PULLUP, (1 << 18)

.equ RCC_APB1ENR_I2C1EN, (1 << 21)
.equ I2C_CR1_SWRST,     (1 << 15)
.equ I2C_CR1_PE,        (1 << 0)

.equ I2C_SR1_SB,    (1 << 0)
.equ I2C_SR1_ADDR,      (1 << 1)
.equ I2C_SR1_RXNE,  (1 << 6)
.equ I2C_SR1_TXE,   (1 << 7)
.equ I2C_SR1_BTF,   (1 << 2)
.equ I2C_SR2_BUSY,      (1 << 1)
.equ I2C_CR1_STOP,  (1 << 9)
.equ I2C_CR1_ACK,   (1 << 10)

