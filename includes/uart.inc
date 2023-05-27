.equ BAUDRATE,              115200
.equ APB1_FREQ,             16000000

.equ BRR_VALUE,             (APB1_FREQ + (BAUDRATE/2)) / BAUDRATE - 1

.equ USART2_BASE,           0x40004400

.equ USART2_SR_OFFSET,      0x00
.equ USART2_BRR_OFFSET,     0x08
.equ USART2_CR1_OFFSET,     0x0C
.equ USART2_DR_OFFSET,      0x04  

.equ USART2_BRR,            (USART2_BASE + USART2_BRR_OFFSET)
.equ USART2_CR1,            (USART2_BASE + USART2_CR1_OFFSET)
.equ USART2_DR,             (USART2_BASE + USART2_DR_OFFSET)
.equ USART2_SR,             (USART2_BASE + USART2_SR_OFFSET)

.equ USART2_CR1_TE,         (1 << 3)
.equ USART2_CR1_UE,         (1 << 13)
.equ USART2_SR_TXE,         (1 << 7)      
