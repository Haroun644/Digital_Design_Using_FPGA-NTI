module instr_memory #(parameter WIDTH=32, DEPTH=64)
(
	input wire [WIDTH-1:0] addr,		 
	output reg [WIDTH-1:0] instr		 
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];	       

    always @(*) begin
        instr = mem[addr[7:2]];		       
    end

endmodule