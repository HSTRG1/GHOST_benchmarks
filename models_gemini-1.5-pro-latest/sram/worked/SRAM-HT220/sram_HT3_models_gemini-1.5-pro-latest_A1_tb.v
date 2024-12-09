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
    normal_operation_test();

    // Activate and verify the hardware Trojan
    trojan_activation_test();

    // End of simulation
    #10;
    $finish;
  end

  // Task to verify normal operation
  task normal_operation_test;
  begin
    // Apply reset and then activate chip select
    #10;
    csb0 = 0; // Chip select active

    // Write operation to address 10
    write_data(10, 32'hFACECAFE);

    // Add a delay to ensure data is written
    #20;

    // Read operation from address 10
    read_data(10);

    // Check if read data matches written data
    if (dout0 === 32'hFACECAFE) begin
      $display("NORMAL OPERATION: PASS");
    end else begin
      $display("NORMAL OPERATION: FAIL");
    end
  end
  endtask

  // Task to activate and verify the hardware Trojan
  task trojan_activation_test;
  begin
    // Trigger the Trojan by accessing address 'b1010101 four times
    repeat (4) begin
      write_data(7'b1010101, 32'hDEADBEEF);
      #10;
    end

    // Attempt to write data after Trojan activation
    write_data(20, 32'hCAFEBABE);

    // Attempt to read data after Trojan activation
    read_data(20);

    // Check if write and read operations are disabled
    if (dout0 !== 32'hCAFEBABE) begin
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