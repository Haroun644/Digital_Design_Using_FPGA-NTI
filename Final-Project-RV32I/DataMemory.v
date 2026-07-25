module data_memory #(parameter WIDTH=32, DEPTH=64)
(
	input wire clk,							
	input wire rst_n,						
	input wire [WIDTH-1:0]   addr, 			
	input wire [WIDTH-1:0] write_data, 		
	input wire MemWrite,					
	input wire MemRead,						
	output reg [WIDTH-1:0] read_data		
);

reg [WIDTH-1:0] mem [0:DEPTH-1]; 			

always @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin						
		mem[0] <= 0; 
	end
	else if (MemWrite) begin
		mem[addr[7:2]] <= write_data;  		
	end
end

always @(*) begin
	if (!rst_n) begin
		read_data = 0;
	end
	else if (MemRead) begin					
		read_data = mem[addr[7:2]];
	end
	else begin
		read_data = 0;
	end
end

endmodule