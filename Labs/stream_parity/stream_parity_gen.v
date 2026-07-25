module stream_parity_gen (
    input  wire clk,
    input  wire reset,
    input  wire serial_in,
    output wire parity_out
);

    // Internal register
    reg [7:0] shift_reg;

    function calc_even_parity (input [7:0] data);
        calc_even_parity = ^data; 
    endfunction

    always @(posedge clk) 
    begin
        if (reset) 
        begin
            shift_reg <= 8'b0000_0000;
        end 
        else 
        begin
            shift_reg <= {shift_reg[6:0], serial_in};
        end
    end

    assign parity_out = calc_even_parity(shift_reg);

endmodule