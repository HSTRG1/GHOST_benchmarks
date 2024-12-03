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

    // Verify normal operation
    verify_normal_operation();

    // Activate and verify the hardware Trojan
    activate_and_verify_trojan();

    // End of simulation
    #10;
    $finish;
  end

  // Task to verify normal operation
  task verify_normal_operation;
  begin
    // Apply reset and then activate chip select
    #10;
    csb0 = 0; // Chip select active

    // Write operation to address 10
    write_data(10, 32'hFACECAFE);

    // Add a delay to ensure data is written
    #20;

    // Read operation from address 10
    read_data(10, 32'hFACECAFE); // Expected data

    // If the read data matches the expected value, normal operation passes
    if (dout0 === 32'hFACECAFE)
      $display("NORMAL OPERATION: PASS");
    else
      $display("NORMAL OPERATION: FAIL");
  end
  endtask

  // Task to activate and verify the hardware Trojan
  task activate_and_verify_trojan;
  begin
    // Activate the Trojan by performing 255 write operations
    repear(10);
    write_data(10, 32'hDEADBEEF);
      $display("counter %h", uut.trojan_counter);
    end
    
    $display("counter %h", uut.trojan_counter);

    // Perform one more write operation to trigger the Trojan
    write_data(12, 32'hDEADBEEF);

    // Read operation from address 255
    read_data(12, ~32'hDEADBEEF); // Expected inverted data

    // If the read data matches the expected inverted value, Trojan activation passes
    if (dout0 === ~32'hDEADBEEF)
      $display("TROJAN ACTIVATION: PASS");
    else
      $display("TROJAN ACTIVATION: FAIL");
  end
  endtask

  // Task to perform write operation
  task write_data(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
  begin
    web0 = 0;          // Write enable (active low)
    addr0 = addr;      // Set address
    din0 = data;       // Set data to be written
    #10;               // Wait for write to complete
//     $display("Writing to address %d: %h", addr, data);
    web0 = 1;          // Disable write after operation
  end
  endtask

  // Task to perform read operation and compare with expected data
  task read_data(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] expected_data);
  begin
    web0 = 1;          // Read enable (active high)
    addr0 = addr;      // Set address
    #10;               // Wait for read to complete
    $display("Reading from address %d: %h (Expected: %h)", addr, dout0, expected_data);
  end
  endtask

  // Dump waveform
  initial begin
    $dumpfile("tb_SRAM_32x128_1rw.vcd");
    $dumpvars(0, tb_SRAM_32x128_1rw);
  end

endmodule