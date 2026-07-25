module memory #(
    parameter AWIDTH = 5,
    parameter DWIDTH = 8
)(
    input  wire [AWIDTH - 1:0] addr,
    inout  wire [DWIDTH - 1:0] data,
    input  wire clk,
    input  wire wr,
    input  wire rd
);

    reg [DWIDTH - 1:0] mem [0:(1 << AWIDTH) - 1];

    always @(posedge clk) begin
        if (wr) begin
            mem[addr] <= data;
        end
    end

    assign data = (rd) ? mem[addr] : {DWIDTH{1'bz}};

endmodule