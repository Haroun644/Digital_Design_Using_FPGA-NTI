# Control Flow
addi x1, x0, 5
addi x2, x0, 5
addi x3, x0, 10

# BEQ (Branch if Equal)
beq  x1, x2, label_beq  
addi x4, x0, 99         
label_beq:
addi x4, x0, 1          # x4 = 1

# BNE (Branch if Not Equal)
bne  x1, x3, label_bne  
addi x5, x0, 99         
label_bne:
addi x5, x0, 1          # x5 = 1

# JAL (Jump and Link)
jal  x6, label_jal      
addi x7, x0, 99         
label_jal:
addi x7, x0, 1          # x7 = 1