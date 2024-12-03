`timescale 1ns/1ps

module tb_SRAM_32x128_1rw;

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 7;
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH;

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

    // 1. Verify normal operation
    verify_normal_operation();

    // 2. Activate and verify the hardware Trojan
    activate_trojan_and_verify();

    // End of simulation
    #10;
    $finish;
  end

  // Task to verify normal operation
  task verify_normal_operation;
    reg [DATA_WIDTH-1:0] expected_data;
    begin
      // Write operation to address 10
      write_data(10, 32'hFACECAFE);
      expected_data = 32'hFACECAFE;

      // Add a delay to ensure data is written
      #20;

      // Read operation from address 10
      read_data(10);

      // Check if the read data matches the expected data
      if (dout0 === expected_data) begin
        $display("NORMAL OPERATION: PASS");
      end else begin
        $display("NORMAL OPERATION: FAIL");
      end
    end
  endtask

  // Task to activate and verify the hardware Trojan
  task activate_trojan_and_verify;
    reg [DATA_WIDTH-1:0] expected_data;
    integer i;
    begin
      // Write operation to address 16'h10
      write_data(16'h10, 32'hFACECAFE);
      expected_data = 32'hFACECAFE + 1; // Trojan modifies data by adding 1

      // Add a delay to ensure data is written
      #20;

      // Trigger the Trojan by incrementing the counter and reading from address 16'h10
      for (i = 0; i < 10; i = i + 1) begin
        #10; // Wait for one clock cycle
        $display("counter %d", uut.trojan_counter);
      end

      read_data(16'h10);

      // Check if the read data matches the expected data with Trojan modification
      if (dout0 === expected_data) begin
        $display("TROJAN ACTIVATION: PASS");
      end else begin
        $display("TROJAN ACTIVATION: FAIL");
      end
    end
  endtask

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

  // Dump waveform
  initial begin
    $dumpfile("tb_SRAM_32x128_1rw.vcd");
    $dumpvars(0, tb_SRAM_32x128_1rw);
  end

endmodule