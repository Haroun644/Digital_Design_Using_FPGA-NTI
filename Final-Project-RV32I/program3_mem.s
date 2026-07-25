# Data Memory and remaining instructions

# LUI (Load Upper Immediate)
lui  x1, 0x00001        

# Memory (SW / LW)
addi x2, x0, 100        
sw   x2, 0(x0)          
lw   x3, 0(x0)          

# JALR (Jump and Link Register)
addi x4, x0, 16         
jalr x5, x4, 0          