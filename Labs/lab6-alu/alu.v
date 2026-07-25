module alu #(parameter WIDTH = 8)(
    input  wire [WIDTH - 1:0] in_a,
    input  wire [WIDTH - 1:0] in_b,
    input  wire [2:0]         opcode,
    output reg  [WIDTH - 1:0] alu_out,
    output wire               a_is_zero
);

    // Single bit asynchronous output based on in_a 
    assign a_is_zero = (in_a == {WIDTH{1'b0}});

    // ALU operations
    always @(*) begin
        case (opcode)
            3'b000:  alu_out = in_a;             // HLT: PASS A
            3'b001:  alu_out = in_a;             // SKZ: PASS A
            3'b010:  alu_out = in_a + in_b;      // ADD: ADD
            3'b011:  alu_out = in_a & in_b;      // AND: AND
            3'b100:  alu_out = in_a ^ in_b;      // XOR: XOR
            3'b101:  alu_out = in_b;             // LDA: PASS B
            3'b110:  alu_out = in_a;             // STO: PASS A
            3'b111:  alu_out = in_a;             // JMP: PASS A
            default: alu_out = {WIDTH{1'b0}};   // Default case to prevent latches
        endcase
    end

endmodule