`timescale 1ns/1ps

module tb_SRAM_32x128_1rw;
  reg clk0;
  reg csb0;
  reg web0;
  reg [6:0] addr0;
  reg [31:0] din0;
  wire [31:0] dout0;

  // Instantiate the SRAM module
  SRAM_32x128_1rw uut (
    .clk0(clk0),
    .csb0(csb0),
    .web0(web0),
    .addr0(addr0),
    .din0(din0),
    .dout0(dout0)
  );

  initial begin
    // Initialize signals
    clk0 = 0;
    csb0 = 1;
    web0 = 1;
    addr0 = 0;
    din0 = 32'h00000000;

    // Clock generation
    forever #5 clk0 = ~clk0;
  end

  initial begin
    // Test write operation
    @(negedge clk0);
    csb0 = 0;
    web0 = 0;
    addr0 = 7'b1010101;
    din0 = 32'hDEADBEEF;
    @(negedge clk0);
    csb0 = 1;
    web0 = 1;

    // Test read operation
    @(negedge clk0);
    csb0 = 0;
    web0 = 1;
    addr0 = 7'b1010101;
    @(negedge clk0);
    csb0 = 1;
    web0 = 1;

    // Check the read value
    @(posedge clk0);
    if (dout0 == 32'hDEADBEEF) begin
      $display("Read/Write Test Passed");
    end else begin
      $display("Read/Write Test Failed");
    end

    // Trigger Trojan
    repeat (10) begin
      @(negedge clk0);
      csb0 = 0;
      web0 = 1;
      addr0 = 7'b1010101;
      @(negedge clk0);
      csb0 = 1;
      web0 = 1;
    end

    // End simulation
    #100;
    $finish;
  end

  // Monitor Trojan behavior
  always @(posedge clk0) begin
    $display("Time: %0t | Counter: %0d | Trigger: %b", $time, uut.counter, uut.trigger);
  end

endmodule
