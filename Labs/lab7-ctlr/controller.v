module controller (
    input  wire       zero,
    input  wire [2:0] phase,
    input  wire [2:0] opcode,
    output reg        sel,
    output reg        rd,
    output reg        ld_ir,
    output reg        halt,
    output reg        inc_pc,
    output reg        ld_ac,
    output reg        ld_pc,
    output reg        wr,
    output reg        data_e
);

    // Opcode Encoding 
    localparam HLT = 3'b000;
    localparam SKZ = 3'b001;
    localparam ADD = 3'b010;
    localparam AND = 3'b011;
    localparam XOR = 3'b100;
    localparam LDA = 3'b101;
    localparam STO = 3'b110;
    localparam JMP = 3'b111;

    // Phase Encoding 
    localparam INST_ADDR  = 3'b000;
    localparam INST_FETCH = 3'b001;
    localparam INST_LOAD  = 3'b010;
    localparam IDLE       = 3'b011;
    localparam OP_ADDR    = 3'b100;
    localparam OP_FETCH   = 3'b101;
    localparam ALU_OP     = 3'b110;
    localparam STORE      = 3'b111;

    // ALU_OP Note
    wire alu_op_active;
    
    assign alu_op_active = (opcode == ADD) || (opcode == AND) || (opcode == XOR) || (opcode == LDA);

    always @(*) 
    begin
        sel    = 1'b0;
        rd     = 1'b0;
        ld_ir  = 1'b0;
        halt   = 1'b0;
        inc_pc = 1'b0;
        ld_ac  = 1'b0;
        ld_pc  = 1'b0;
        wr     = 1'b0;
        data_e = 1'b0;

        // Output based on current phase and opcode
        case (phase)
            INST_ADDR:
                sel = 1'b1;
            
            INST_FETCH: 
            begin
                sel = 1'b1;
                rd  = 1'b1;
            end
            
            INST_LOAD: 
            begin
                sel   = 1'b1;
                rd    = 1'b1;
                ld_ir = 1'b1;
            end
            
            IDLE: 
            begin
                sel   = 1'b1;
                rd    = 1'b1;
                ld_ir = 1'b1;
            end
            
            OP_ADDR: 
            begin
                halt   = (opcode == HLT);
                inc_pc = 1'b1;
            end
            
            OP_FETCH: 
                rd = alu_op_active;
            
            ALU_OP: 
            begin
                rd     = alu_op_active;
                inc_pc = (opcode == SKZ) && zero;
                ld_pc  = (opcode == JMP);
                data_e = (opcode == STO);
            end
            
            STORE: 
            begin
                rd     = alu_op_active;
                ld_ac  = alu_op_active;
                ld_pc  = (opcode == JMP);
                wr     = (opcode == STO);
                data_e = (opcode == STO);
            end
        endcase
    end
endmodule