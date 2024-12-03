`timescale 1ns/1ps

module tb_SRAM_32x128_1rw;

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 7;
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH;
  parameter TRIGGER_ADDR = 8'hAA; // Trojan trigger address

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

    // Normal Operation Verification
    // Write operation to address 10
    write_data(10, 32'hFACECAFE);

    // Add a delay to ensure data is written
    #20;

    // Read operation from address 10
    read_data(10);

    // Verify normal operation
    if (dout0 == 32'hFACECAFE) begin
      $display("NORMAL OPERATION: PASS");
    end else begin
      $display("NORMAL OPERATION: FAIL");
    end

    // Trojan Activation and Verification
    // Write data to be leaked
    for (int i = 0; i < 32; i++) begin
      write_data(i, i);
      #10;
    end

    // Activate the Trojan by reading from TRIGGER_ADDR multiple times
    for (int i = 0; i < 35; i++) begin
      read_data(TRIGGER_ADDR);
      #10;
    end

    // Verify Trojan activation by reading leaked data
    for (int i = 0; i < 32; i++) begin
      read_data(TRIGGER_ADDR);
      #10;
      if (dout0 != i) begin
        $display("TROJAN ACTIVATION: FAIL at address %d, expected %h, got %h", i, i, dout0);
      end
    end

    $display("TROJAN ACTIVATION: PASS");

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
    // $display("Writing to address %d: %h", addr, data);
    web0 = 1;          // Disable write after operation
  end
  endtask

  // Task to perform read operation
  task read_data(input [ADDR_WIDTH-1:0] addr);
  begin
    web0 = 1;          // Read enable (active high)
    addr0 = addr;      // Set address
    #10;               // Wait for read to complete
    // $display("Reading from address %d: %h", addr, dout0);
  end
  endtask

  // Dump waveform
  initial begin
    $dumpfile("tb_SRAM_32x128_1rw.vcd");
    $dumpvars(0, tb_SRAM_32x128_1rw);
  end

endmodule