.equ RCC_BASE,              0x40023800
.equ GPIOA_BASE,            0x40020000

.equ AHB1ENR_OFFSET,        0x30
.equ APB1ENR_OFFSET,        0x40 
.equ GPIOA_MODER_OFFSET,    0x00
.equ GPIOA_AFR1_OFFSET,     0x20

.equ RCC_AHB1ENR,           (RCC_BASE   + AHB1ENR_OFFSET)
.equ RCC_APB1ENR,           (RCC_BASE   + APB1ENR_OFFSET)
.equ GPIOA_MODER,           (GPIOA_BASE + GPIOA_MODER_OFFSET)
.equ GPIOA_AFR1,            (GPIOA_BASE + GPIOA_AFR1_OFFSET)

.equ GPIOA_EN,              (1 << 0)
.equ PA2_AF_MODE,           (2 << 4)
.equ PA2_AF_USART2_TX,      (7 << 8)    
.equ RCC_USART2_EN,         (1 << 17)
