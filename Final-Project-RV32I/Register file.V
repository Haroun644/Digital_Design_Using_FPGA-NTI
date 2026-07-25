module register ( 
    input clk, 
    input rstn,                
    input [4:0] rd1_addr, 
    input [4:0] rd2_addr, 
    input [4:0] wr_addr, 
    input [31:0] wr_data, 
    input wr_en, 
    output reg [31:0] rd1_data, 
    output reg [31:0] rd2_data
); 

    parameter address = 5;
    parameter width = 32;
    parameter depth = 2**address;
    
    reg [width-1:0] mem [depth-1:0];
    integer i;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < depth; i = i + 1) begin
                mem[i] <= 32'd0; 
            end
        end else if (wr_en && wr_addr != 5'd0) begin
            mem[wr_addr] <= wr_data; 
        end
    end

    always @(*) begin
        if (rd1_addr == 0) begin
            rd1_data = 0;
        end else begin
            rd1_data = mem[rd1_addr];
        end

        if (rd2_addr == 0) begin
            rd2_data = 0;
        end else begin
            rd2_data = mem[rd2_addr];
        end
    end
endmodule