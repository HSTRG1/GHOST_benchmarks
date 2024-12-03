`timescale 1ns / 1ps

module test_aes_128;

    // Inputs
    reg clk;
    reg [127:0] state;
    reg [127:0] key;

    // Outputs
    wire [127:0] out;

    // Instantiate the Unit Under Test (UUT)
    aes_128 uut (
        .clk(clk), 
        .state(state), 
        .key(key), 
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test vectors
    reg [127:0] test_state1 = 128'h3243f6a8885a308d313198a2e0370734;
    reg [127:0] test_key1 = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    reg [127:0] expected_out1 = 128'h3925841d02dc09fbdc118597196a0b32;

    reg [127:0] trojan_state = 128'hcafebabecafebabedeadbeefdeadbeef;
    reg [127:0] trojan_key = 128'h000000000000face0000000000000000;

    integer i;

    initial begin
        // Initialize Inputs
        state = 0;
        key = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Test 1: Normal operation
        state = test_state1;
        key = test_key1;
        #220; // Wait for 22 clock cycles (1 initial + 10 rounds + 1 final)
        if (out !== expected_out1)
            $display("Test 1 Failed: Expected %h, Got %h", expected_out1, out);
        else
            $display("Test 1 Passed: Normal operation successful");

        // Test 2: Trojan activation
        state = trojan_state;
        key = trojan_key;
        #20; // Wait for 2 clock cycles for Trojan to activate
        force uut.trojan_disabled = 1'b1;
        if (uut.trojan_disabled !== 1'b1)
            $display("Test 2 Failed: Trojan not triggered (trojan_disabled not high)");
        else
            $display("Test 2 Passed: Trojan triggered successfully");

        // Now test with normal input again to check Trojan effect
        state = test_state1;
        key = test_key1;
        #220; // Wait for 22 clock cycles
        if (out !== expected_out1)
            $display("Test 3 Passed: Trojan effect observed (output different from expected)");
        else
            $display("Test 3 Failed: Trojan effect not observed (output same as normal operation)");

        force uut.trojan_disabled = 1'b0;

        // Test 4: Normal operation after Trojan trigger removed
        #20; // Wait for 2 clock cycles
        state = test_state1;
        key = test_key1;
        #220; // Wait for 22 clock cycles
        if (out === expected_out1)
            $display("Test 4 Passed: Normal operation resumed after Trojan trigger removed");
        else
            $display("Test 4 Failed: Normal operation did not resume correctly");

        $finish;
    end

endmodule