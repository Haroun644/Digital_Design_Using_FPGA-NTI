module seq_detector_overlapping (
    input clk,
    input reset,
    input serial_in,
    output reg detected
);

    // State Encodings
    localparam S_IDLE  = 3'b000;
    localparam S_1     = 3'b001;
    localparam S_11    = 3'b010;
    localparam S_110   = 3'b011;
    localparam S_1101  = 3'b100;
    localparam S_11010 = 3'b101;

    reg [2:0] current_state, next_state;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S_IDLE;
        else
            current_state <= next_state;
    end

    // Next State and Output Logic
    always @(*) begin
        // Default output
        detected = 1'b0;
        next_state = current_state;

        case (current_state)
            S_IDLE: begin
                if (serial_in) next_state = S_1;
                else           next_state = S_IDLE;
            end
            
            S_1: begin
                if (serial_in) next_state = S_11;
                else           next_state = S_IDLE;
            end
            
            S_11: begin
                if (serial_in) next_state = S_11;
                else           next_state = S_110;
            end
            
            S_110: begin
                if (serial_in) next_state = S_1101;
                else           next_state = S_IDLE;
            end
            
            S_1101: begin
                if (serial_in) next_state = S_11; // Suffix '11' matches
                else           next_state = S_11010;
            end
            
            S_11010: begin
                if (serial_in) begin
                    detected = 1'b1;     // Sequence 110101 found!
                    next_state = S_1;    // OVERLAPPING: the '1' starts a new sequence
                end else begin
                    next_state = S_IDLE; // Sequence broken
                end
            end
            
            default: next_state = S_IDLE;
        endcase
    end
endmodule