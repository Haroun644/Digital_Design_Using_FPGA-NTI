module counter2 (
    input clock,
    input reset,
    input up,
    output [1:0] count
);

    wire d0, d1;
    wire u_xnor_q0;
    reg q0_reg, q1_reg;

    // Primitive logic gates defining next-state equations
    not  not1  (d0, count[0]);
    xnor xnor1 (u_xnor_q0, up, count[0]);
    xor  xor1  (d1, count[1], u_xnor_q0);

    // State registers (D Flip-Flops mapped to behavioral registers at the lowest level)
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            q0_reg <= 1'b0;
            q1_reg <= 1'b0;
        end else begin
            q0_reg <= d0;
            q1_reg <= d1;
        end
    end

    assign count[0] = q0_reg;
    assign count[1] = q1_reg;

endmodule