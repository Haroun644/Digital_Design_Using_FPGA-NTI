`timescale 1ns / 1ps

module tb_seq_detectors;

    // Testbench signals
    reg clk;
    reg reset;
    reg serial_in;
    
    wire det_over;
    wire det_nonover;

    seq_detector_overlapping dut_over (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .detected(det_over)
    );

    seq_detector_nonoverlapping dut_nonover (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .detected(det_nonover)
    );

    // Clock Generation (10ns period)
    always #5 clk = ~clk;

    reg [13:0] test_sequence = 14'b0_11010110101_00;
    integer i;

    initial begin
        $dumpfile("seq_detector_sim.vcd");
        $dumpvars(0, tb_seq_detectors);

        // Initialize signals
        clk = 0;
        reset = 1;
        serial_in = 0;

        $display("Time\t| Reset | In | Overlapping | Nonoverlapping");
        $display("---------------------------------------------------");

        $monitor("%0t\t|   %b   |  %b |      %b      |       %b", 
                 $time, reset, serial_in, det_over, det_nonover);

        #12 reset = 0;

        for (i = 13; i >= 0; i = i - 1) begin
            @(negedge clk); // Change input on negative edge for stability at positive edge
            serial_in = test_sequence[i];
        end

        #20;
        $display("---------------------------------------------------");
        $display("Simulation Complete.");
        $finish;
    end

endmodule