module counter #(parameter WIDTH = 5)(
    input  wire             clk,
    input  wire             rst,
    input  wire             load,
    input  wire             enab,
    input  wire [WIDTH-1:0] cnt_in,
    output reg  [WIDTH-1:0] cnt_out
);

    reg [WIDTH-1:0] next_cnt;

    always @(*) begin
        if (load) begin
            next_cnt = cnt_in;
        end else if (enab) begin
            next_cnt = cnt_out + 1'b1;
        end else begin
            next_cnt = cnt_out;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_out <= {WIDTH{1'b0}};
        end else begin
            cnt_out <= next_cnt;
        end
    end

endmodule