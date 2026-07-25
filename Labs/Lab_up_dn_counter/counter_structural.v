// Reusable D Flip-Flop module
module d_flip_flop (
    input d,
    input clk,
    input rst,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst) 
            q <= 1'b0;
        else 
            q <= d;
    end
endmodule

// Next State Logic combinational block
module next_state_logic (
    input up,
    input q0,
    input q1,
    output d0,
    output d1
);
    assign d0 = ~q0;
    assign d1 = q1 ^ (up == q0);
endmodule

// Top-level structural module
module counter2 (
    input clock,
    input reset,
    input up,
    output [1:0] count
);

    wire d0, d1;

    // Instantiate Combinational Logic
    next_state_logic nsl (
        .up(up),
        .q0(count[0]),
        .q1(count[1]),
        .d0(d0),
        .d1(d1)
    );

    // Instantiate D Flip-Flops
    d_flip_flop ff0 (
        .d(d0),
        .clk(clock),
        .rst(reset),
        .q(count[0])
    );

    d_flip_flop ff1 (
        .d(d1),
        .clk(clock),
        .rst(reset),
        .q(count[1])
    );

endmodule