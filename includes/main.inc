.equ RCC_BASE,              0x40023800
.equ GPIOA_BASE,            0x40020000
.equ GPIOB_BASE,            0x40020400

.equ GPIO_MODER_OFFSET,     0x00
.equ GPIO_OTYPER_OFFSET,    0x04
.equ GPIO_PUPDR_OFFSET,     0x0C  
.equ GPIO_AFRL_OFFSET,      0x20
.equ GPIO_AFRH_OFFSET,      0x24

.equ AHB1ENR_OFFSET,        0x30
.equ APB1ENR_OFFSET,        0x40 

.equ RCC_AHB1ENR,           (RCC_BASE   + AHB1ENR_OFFSET)
.equ RCC_APB1ENR,           (RCC_BASE   + APB1ENR_OFFSET)

.equ GPIOA_MODER,           (GPIOA_BASE + GPIO_MODER_OFFSET)
.equ GPIOB_MODER,           (GPIOB_BASE + GPIO_MODER_OFFSET)

.equ GPIOA_AFRL,            (GPIOA_BASE + GPIO_AFRL_OFFSET)
.equ GPIOB_AFRH,            (GPIOB_BASE + GPIO_AFRH_OFFSET)

.equ GPIOB_OTYPER,          (GPIOA_BASE + GPIO_OTYPER_OFFSET)
.equ GPIOB_PUPDR,           (GPIOB_BASE + GPIO_PUPDR_OFFSET)


.equ GPIOA_EN,              (1 << 0)
.equ GPIOB_EN,              (1 << 1)

