vlog ALU.V ALU_control.v Control_unit.v DataMemory.v ImmGen.v InstrMemory.v MUX32.v MUX32_2.v Register\ file.V RV32I_TOP.V io_interface_7seg.v io_interface_8leds.v pc_sel_logic.v program_counter.v targetAdder.v top_tb.v
vsim -voptargs="+acc" work.top_tb 
add wave -position insertpoint  \
sim:/top_tb/DUT/clk \
sim:/top_tb/DUT/rstn \
sim:/top_tb/DUT/reg_data \
sim:/top_tb/DUT/oprand1 \
sim:/top_tb/DUT/oprand2 \
sim:/top_tb/DUT/opcode \
sim:/top_tb/DUT/alu_result \
sim:/top_tb/DUT/zero_flag \
sim:/top_tb/DUT/data_memory_read \
sim:/top_tb/DUT/mem_to_reg_out \
sim:/top_tb/DUT/immGen_out \
sim:/top_tb/DUT/pcNext \
sim:/top_tb/DUT/pcOut \
sim:/top_tb/DUT/pc_plus4 \
sim:/top_tb/DUT/branch_target \
sim:/top_tb/DUT/JALR_out \
sim:/top_tb/DUT/in3_garb \
sim:/top_tb/DUT/pc_sel \
sim:/top_tb/DUT/rs1 \
sim:/top_tb/DUT/rs2 \
sim:/top_tb/DUT/instruction \
sim:/top_tb/DUT/ALU_OP \
sim:/top_tb/DUT/jump_ctrl \
sim:/top_tb/DUT/branch_ctrl \
sim:/top_tb/DUT/mem_to_reg_ctrl \
sim:/top_tb/DUT/mem_wirte_ctrl \
sim:/top_tb/DUT/mem_read_ctrl \
sim:/top_tb/DUT/aluSrc_ctrl \
sim:/top_tb/DUT/regWrite_ctrl \
sim:/top_tb/DUT/final_wr_data
run -all
# q -sim