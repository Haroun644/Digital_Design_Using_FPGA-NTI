module memory_test;

  localparam AWIDTH = 5;
  localparam DWIDTH = 8;

  reg  clk;
  reg  wr;
  reg  rd;
  reg  [AWIDTH-1:0] addr;
  reg  [DWIDTH-1:0] data_in; // Register to drive the bidirectional bus
  wire [DWIDTH-1:0] data;    // Wire connecting to the bidirectional port

  assign data = (wr && !rd) ? data_in : {DWIDTH{1'bz}};

  memory
  #(
    .AWIDTH ( AWIDTH ),
    .DWIDTH ( DWIDTH )
   )
  memory_inst
   ( 
    .addr ( addr ),
    .data ( data ),
    .clk  ( clk  ),
    .wr   ( wr   ),
    .rd   ( rd   ) 
   );

  task expect;
    input [DWIDTH-1:0] exp_out;
    if (data !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data=%b",
                $time, addr, data);
      $display("data should be %b", exp_out);
      $finish;
    end
    else begin
      $display("At time %0d addr=%b data=%b",
                $time, addr, data);
    end
  endtask

  initial begink
      clk = 0;
      repeat (80) begin #5 clk=1; #5 clk=0; end
  end

  integer i;

  initial begin
    // Initial state
    wr = 0; rd = 0; addr = 0; data_in = 0;
    
    // match the "At time 370..." requirement from the Lab 8 PDF
    #45; 

    for (i = 0; i < 32; i = i + 1) begin
      @(negedge clk);
      wr = 1; 
      rd = 0;
      addr = 31 - i;
      data_in = i;
    end

    for (i = 0; i < 32; i = i + 1) begin
      @(negedge clk);
      wr = 0; 
      rd = 1;
      addr = 31 - i;
      
      #1; 
      expect(i);
    end

    $display("TEST PASSED");
    $finish;
  end

endmodule