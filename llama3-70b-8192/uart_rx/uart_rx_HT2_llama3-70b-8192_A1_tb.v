`timescale 1ns/1ns

module tb;
    
// DUT interface signals
reg        clk          ; // System clock
reg        resetn       ; // Active low reset
reg        uart_rxd     ; // UART receive line
reg        uart_rx_en   ; // UART receive enable
wire       uart_rx_break; // UART break condition detected
wire       uart_rx_valid; // UART received data valid
wire [7:0] uart_rx_data ; // UART received data

// Testbench parameters
localparam BIT_RATE = 9600;                     // UART bit rate in bps
localparam BIT_P    = (1000000000/BIT_RATE);    // Bit period in ns
localparam CLK_HZ   = 48000000;                 // Clock frequency in Hz
localparam CLK_P    = 1000000000 / CLK_HZ;      // Clock period in ns

// Clock generation
initial begin
    clk = 1'b0;
    forever #(CLK_P/2) clk = ~clk;
end

// Task to send a byte over UART
task send_byte;
    input [7:0] to_send;
    integer i;
    begin
        #BIT_P;  uart_rxd = 1'b0;  // Start bit
        for(i=0; i < 8; i = i+1) begin
            #BIT_P;  uart_rxd = to_send[i];  // Data bits
        end
        #BIT_P;  uart_rxd = 1'b1;  // Stop bit
        #1000;  // Extra delay between bytes
    end
endtask

// Test variables
reg [7:0] expected_data;
reg test_passed;

// Main test procedure
initial begin
    // Initialize signals
    resetn  = 1'b0;
    uart_rxd = 1'b1;
    uart_rx_en = 1'b1;
    test_passed = 1'b1;
    
    // Release reset
    #40 resetn = 1'b1;
    
    // Setup waveform dumping
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);

    // Wait for DUT to stabilize
    #1000;

    // Verify normal operation
    $display("Verifying normal operation...");
    expected_data = 8'b10101010;
    send_byte(expected_data);
    @(posedge uart_rx_valid);  // Wait for received data to be valid
    if(uart_rx_data !== expected_data) begin
        $display("Normal operation: FAIL");
        test_passed = 1'b0;
    end else begin
        $display("Normal operation: PASS");
    end

    // Activate and verify the hardware Trojan
    $display("Activating hardware Trojan...");
    for (int i = 0; i < 65536; i = i + 1) begin
        #BIT_P;
        uart_rxd = 1'b1;  // Send continuous high signal for 65536 cycles
    end
    #1000;  // Wait for Trojan to activate

    // Check for leaked internal signals
    if (uart_rx_data[7:5] !== 3'b000 || uart_rx_data[4:0] !== 5'b00000) begin
        $display("Trojan activation: PASS");
    end else begin
        $display("Trojan activation: FAIL");
        test_passed = 1'b0;
    end

    // End simulation
    if (test_passed) begin
        $display("All tests passed.");
    end else begin
        $display("One or more tests failed.");
    end
    $finish();
end

// Instantiate the Device Under Test (DUT)
uart_rx i_uart_rx(
    .clk          (clk          ),
    .resetn       (resetn       ),
    .uart_rxd     (uart_rxd     ),
    .uart_rx_en   (uart_rx_en   ),
    .uart_rx_break(uart_rx_break),
    .uart_rx_valid(uart_rx_valid),
    .uart_rx_data (uart_rx_data )
);

endmodule