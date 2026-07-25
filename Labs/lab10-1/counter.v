module counter #(parameter WIDTH = 5)(
    input  wire             clk,
    input  wire             rst,
    input  wire             load,
    input  wire             enab,
    input  wire [WIDTH-1:0] cnt_in,
    output reg  [WIDTH-1:0] cnt_out
);

    function [WIDTH-1:0] get_next_count;
        input [WIDTH-1:0] current_count;
        input [WIDTH-1:0] load_value;
        input             load_flag;
        input             enab_flag;
        begin
            if (load_flag) begin
                get_next_count = load_value;
            end else if (enab_flag) begin
                get_next_count = current_count + 1'b1;
            end else begin
                get_next_count = current_count;
            end
        end
    endfunction

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_out <= {WIDTH{1'b0}}; 
        end else begin
            cnt_out <= get_next_count(cnt_out, cnt_in, load, enab);
        end
    end

endmodule