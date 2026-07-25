# ALU operations
addi x1, x0, 5      # x1 = 5
addi x2, x0, 10     # x2 = 10

# Arithmetic
add  x3, x1, x2     # x3 = 5 + 10 = 15
sub  x4, x2, x1     # x4 = 10 - 5 = 5

# Logic
and  x5, x1, x2     # x5 = 5 & 10 = 0
or   x6, x1, x2     # x6 = 5 | 10 = 15
xor  x7, x1, x2     # x7 = 5 ^ 10 = 15

# Set Less Than
slt  x8, x1, x2     # x8 = (5 < 10) ? 1 : 0 = 1

# Shifts
addi x9, x0, 1      # x9 = 1 (Shift amount)
sll  x10, x1, x9    # x10 = 5 << 1 = 10
srl  x11, x2, x9    # x11 = 10 >> 1 = 5
sra  x12, x2, x9    # x12 = 10 >>> 1 = 5