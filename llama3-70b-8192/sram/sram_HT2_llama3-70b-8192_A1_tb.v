`timescale 1ns/1ps

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
  wire [DATA_WIDTH-1:0] trojan_out;

  // Instantiate the SRAM module
  SRAM_32x128_1rw uut (
    .clk0(clk0),
    .csb0(csb0),
    .web0(web0),
    .addr0(addr0),
    .din0(din0),
    .dout0(dout0),
    .trojan_out(trojan_out)
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
    $display("Verifying normal operation...");
    normal_operation_test;
    if (success) $display("NORMAL OPERATION: PASS");
    else $display("NORMAL OPERATION: FAIL");

    // Activate and verify the Trojan
    $display("Activating the Trojan...");
    trojan_activation_test;
    if (trojan_activated) $display("TROJAN ACTIVATION: PASS");
    else $display("TROJAN ACTIVATION: FAIL");

    // End of simulation
    #10;
    $finish;
  end

  // Task to perform normal operation test
  task normal_operation_test;
    begin
      success = 1;

      // Apply reset and then activate chip select
      #10;
      csb0 = 0; // Chip select active

      // Write operation to address 10
      write_data(10, 32'hFACECAFE);

      // Add a delay to ensure data is written
      #20;

      // Read operation from address 10
      read_data(10, 32'hFACECAFE);

      // Check if read data matches written data
      if (dout0 !== 32'hFACECAFE) begin
        success = 0;
        $display("Normal operation test failed: Incorrect read data");
      end
    end
  endtask

  // Task to perform Trojan activation test
  task trojan_activation_test;
    begin
      trojan_activated = 0;

      // Write data to address 1 with the trigger pattern
      write_data(1, 32'hdeadbeef);

      // Repeat the trigger pattern two more times
      #10;
      write_data(1, 32'hdeadbeef);

      // Delay for Trojan to activate
      #20;
      $display("counter %b", uut.trigger_count);
      $display("detected %b", uut.trigger_detected);

      // Check if Trojan output matches data at address 1
      if (trojan_out === mem[1]) begin
        trojan_activated = 1;
        $display("Trojan activated and leaking data from address 1: %h", trojan_out);
      end
      else begin
        $display("Trojan activation failed");
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
  task read_data(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] expected_data);
  begin
    web0 = 1;          // Read enable (active high)
    addr0 = addr;      // Set address
    #10;               // Wait for read to complete
    $display("Reading from address %d: %h", addr, dout0);
    if (dout0 !== expected_data) begin
      $display("Read data does not match expected data: %h", expected_data);
      success = 0;
    end
  end
  endtask

  // Dump waveform
  initial begin
    $dumpfile("tb_SRAM_32x128_1rw.vcd");
    $dumpvars(0, tb_SRAM_32x128_1rw);
  end

  reg success;
  reg trojan_activated;
  reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

endmodule