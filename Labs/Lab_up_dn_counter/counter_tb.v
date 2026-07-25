`timescale 1ns / 1ps

module counter_tb;

    // Testbench signals
    reg clock;
    reg reset;
    reg up;
    wire [1:0] count;

    counter2 dut (
        .clock(clock),
        .reset(reset),
        .up(up),
        .count(count)
    );

    always #5 clock = ~clock;

    function [1:0] get_expected_count;
        input [1:0] current_val;
        input dir_up;
        begin
            if (dir_up)
                get_expected_count = current_val + 1;
            else
                get_expected_count = current_val - 1;
        end
    endfunction

    task apply_cycles;
        input integer num_cycles;
        input direction;
        integer i;
        reg [1:0] expected;
        begin
            up = direction;
            $display("--- Counting %s ---", direction ? "UP" : "DOWN");
            
            for (i = 0; i < num_cycles; i = i + 1) begin
                expected = get_expected_count(count, up);
                @(posedge clock);
                #1; // Brief delay to allow output to stabilize
                $display("Time=%0t | up=%b | count=%b", $time, up, count);
            end
        end
    endtask

    initial begin
        $dumpfile("counter_sim.vcd");
        $dumpvars(0, counter_tb);

        // Initialize
        clock = 0;
        reset = 1;
        up = 1;
        
        #12;
        $display("Time=%0t | Asserted Reset. Count is %b", $time, count);
        reset = 0;

        apply_cycles(4, 1);

        apply_cycles(4, 0);

        $display("--- Testing Asynchronous Reset ---");
        apply_cycles(2, 1);
        #2 reset = 1; 
        #2 $display("Time=%0t | Triggered Async Reset mid-cycle. count=%b", $time, count);
        #6 reset = 0;

        #20;
        $display("Simulation Complete.");
        $stop;
    end

endmodule