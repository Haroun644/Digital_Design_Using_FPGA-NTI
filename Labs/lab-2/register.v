module register #(parameter WIDTH = 8)(
    input  wire               clk,       
    input  wire               rst,       // Active-high synchronous reset
    input  wire               load,
    input  wire [WIDTH - 1:0] data_in,
    output reg  [WIDTH - 1:0] data_out
);

    // Register is clocked on the rising edge
    always @(posedge clk)
    begin
        if (rst)
            data_out <= 0;
        else
        begin
            if (load)
                data_out <= data_in;
        end
    end

endmodule 