.equ RCC_BASE,              0x40023800
.equ GPIOA_BASE,            0x40020000

.equ AHB1ENR_OFFSET,        0x30
.equ GPIOA_MODER_OFFSET,    0x00
.equ GPIOA_ODR_OFFSET,      0x14

.equ RCC_AHB1ENR,           (RCC_BASE + AHB1ENR_OFFSET)
.equ GPIOA_MODER,           (GPIOA_BASE + GPIOA_MODER_OFFSET)
.equ GPIOA_ODR,             (GPIOA_BASE + GPIOA_ODR_OFFSET)

.equ GPIOA_EN,              (1 << 0)
.equ MODER5_OUT,            (1 << 10)
.equ LED_ON,                (1 << 5)
.equ LED_OFF,               (1 << 0)
.equ INTERVAL,              500000
