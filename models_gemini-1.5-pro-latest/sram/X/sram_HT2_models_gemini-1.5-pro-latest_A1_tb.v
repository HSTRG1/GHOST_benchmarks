`timescale 1ns/1ps

module tb_SRAM_32x128_1rw;

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 7;
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH;

  localparam TRIGGER_ADDR = 7'b1010101; // Trojan activation address
  localparam LEAK_DELAY = 10; // Delay before leaking data

  reg clk0;
  reg csb0;
  reg web0;
  reg [ADDR_WIDTH-1:0] addr0;
  reg [DATA_WIDTH-1:0] din0;
  wire [DATA_WIDTH-1:0] dout0;

  // Instantiate the SRAM module
  SRAM_32x128_1rw uut (
    .clk0(clk0),
    .csb0(csb0),
    .web0(web0),
    .addr0(addr0),
    .din0(din0),
    .dout0(dout0)
  );

  // Clock generation: 100 MHz clock
  always #5 clk0 = ~clk0;

  initial begin
    // Initialize inputs
    clk0 = 0;
    csb0 = 1; // Chip select inactive
    web0 = 1; // Write enable inactive (read mode)
    addr0 = 0;
    din0 = 0;

    // Apply reset and then activate chip select
    #10;
    csb0 = 0; // Chip select active

    // Verify normal operation
    normal_operation_test();

    // Activate and verify Trojan
    trojan_activation_test();

    // End of simulation
    #10;
    $finish;
  end

  // Task to perform write operation
  task write_data(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
  begin
    web0 = 0;          // Write enable (active low)
    addr0 = addr;      // Set address
    din0 = data;       // Set data to be written
    #10;               // Wait for write to complete
    $display("Writing to address %d: %h", addr, data);
    web0 = 1;          // Disable write after operation
  end
  endtask

  // Task to perform read operation
  task read_data(input [ADDR_WIDTH-1:0] addr);
  begin
    web0 = 1;          // Read enable (active high)
    addr0 = addr;      // Set address
    #10;               // Wait for read to complete
    $display("Reading from address %d: %h", addr, dout0);
  end
  endtask

  // Verify normal operation
  task normal_operation_test;
  begin
    write_data(10, 32'hFACECAFE);
    #20;
    read_data(10);
    if (dout0 === 32'hFACECAFE)
      $display("NORMAL OPERATION: PASS");
    else
      $display("NORMAL OPERATION: FAIL");
  end
  endtask

  // Activate and verify Trojan
  task trojan_activation_test;
  begin
    // Write to a different memory location
    write_data(0, 32'hDEADBEEF);

    // Trigger the Trojan
    write_data(TRIGGER_ADDR, 32'h12345678);
    #(LEAK_DELAY * 10); // Wait for the leak delay

    // Check if the leaked bit is inverted
    read_data(TRIGGER_ADDR);
    if (dout0[0] !== 32'h12345678[0])
      $display("TROJAN ACTIVATION: PASS");
    else
      $display("TROJAN ACTIVATION: FAIL");
  end
  endtask

  // Dump waveform
  initial begin
    $dumpfile("tb_SRAM_32x128_1rw.vcd");
    $dumpvars(0, tb_SRAM_32x128_1rw);
  end

endmodule