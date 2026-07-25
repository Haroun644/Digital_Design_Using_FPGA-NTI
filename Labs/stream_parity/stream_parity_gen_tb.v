`timescale 1ns / 1ps

module stream_parity_gen_tb();

    // Signal Declarations
    reg  clk;
    reg  reset;       
    reg  serial_in;  
    wire parity_out;

    // DUT Instantiation
    stream_parity_gen DUT (
        .clk(clk),
        .reset(reset),      
        .serial_in(serial_in),
        .parity_out(parity_out) 
    );

    // Clock Generation
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    // Reset
    task test_reset_and_zeros();
    begin
        $display("--------------------------------------------------");
        $display("Running Test 1: Reset & All Zeros...");
        
        // Assert synchronous active-high reset
        reset = 1; 
        serial_in = 0;
        
        @(negedge clk)
        @(negedge clk)
        
        reset = 0; 
        
        // Shift in 8 zeros
        repeat (8) @(negedge clk); 
        
        $display("Checking Parity for 8'b0000_0000...");
        if (parity_out == 1'b0) $display("[PASS] Zeros: Parity is 0.");
        else $display("[FAIL] Zeros: Parity = %b (Expected 0)", parity_out);
    end
    endtask 

    // Single '1'
    task test_single_one();
    begin
        $display("--------------------------------------------------");
        $display("Running Test 2: Single '1' (Odd Parity)...");
        
        serial_in = 1;
        @(negedge clk);
        
        serial_in = 0;
        repeat (7) @(negedge clk); 
        
        $display("Checking Parity for 8'b0000_0001...");
        if (parity_out == 1'b1) $display("[PASS] Single '1': Parity is 1.");
        else $display("[FAIL] Single '1': Parity = %b (Expected 1)", parity_out);
    end
    endtask

    // Specific Patterns 
    task test_patterns();
    integer i;
    reg [7:0] test_data_even;
    reg [7:0] test_data_odd;
    begin
        $display("--------------------------------------------------");
        $display("Running Test 3: Specific Data Patterns...");
        
        test_data_even = 8'b1011_0100; 
        test_data_odd  = 8'b1111_1110; 
        
        for (i = 7; i >= 0; i = i - 1) begin
            serial_in = test_data_even[i];
            @(negedge clk);
        end
        
        $display("Checking Parity for 8'b1011_0100...");
        if (parity_out == 1'b0) $display("[PASS] Pattern 1: Parity is 0.");
        else $display("[FAIL] Pattern 1: Parity = %b (Expected 0)", parity_out);

        for (i = 7; i >= 0; i = i - 1) begin
            serial_in = test_data_odd[i];
            @(negedge clk);
        end

        $display("Checking Parity for 8'b1111_1110...");
        if (parity_out == 1'b1) $display("[PASS] Pattern 2: Parity is 1.");
        else $display("[FAIL] Pattern 2: Parity = %b (Expected 1)", parity_out);
    end
    endtask

    initial 
    begin
        test_reset_and_zeros();
        @(negedge clk);
        
        test_single_one();
        @(negedge clk);
        
        test_patterns();
        @(negedge clk);
        
        $display("--------------------------------------------------");
        $display("Verification Sequence Completed.");
        $stop; 
    end

endmodule