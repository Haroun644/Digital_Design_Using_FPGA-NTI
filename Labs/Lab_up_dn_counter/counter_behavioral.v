module counter2 (
    input clock,
    input reset, // asynchronous, active-high
    input up,    // 1 = count up, 0 = count down
    output reg [1:0] count
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            count <= 2'b00;
        end else if (up) begin
            count <= count + 1;
        end else begin
            count <= count - 1;
        end
    end

endmodule