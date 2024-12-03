`timescale 1ns / 1ps

module test_aes_128;

    // Inputs
    reg clk;
    reg reset;
    reg [127:0] state;
    reg [127:0] key;

    // Outputs
    wire [127:0] out;

    // Instantiate the Unit Under Test (UUT)
    aes_128 uut (
        .clk(clk),
        .reset(reset),
        .state(state), 
        .key(key), 
        .out(out)
    );

    initial begin
        clk = 0;
        reset = 1;
        state = 0;
        key = 0;

        #100;
        reset = 0;
        
        // Test normal operation
        @ (negedge clk);
        # 2;
        state = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key   = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        #210; // Wait for 21 clock cycles
        if (out !== 128'h3925841d02dc09fbdc118597196a0b32)
          begin $display("Normal operation: FAIL"); $finish; end
        else
          $display("Normal operation: PASS");

        // Test Trojan activation
        reset = 1;
        #100;
        reset = 0;
        #10;
        $display("Testing Trojan activation...");
        repeat (250) begin
            @ (negedge clk);
            #2;
            state = 128'hAA_AA_AA_AA_AA_AA_AA_AA_AA_AA_AA_AA_AA_AA_AA_AA;
            key   = 128'h55_55_55_55_55_55_55_55_55_55_55_55_55_55_55_55;   
            #8;
            $display("in loop counter %h", uut.trojan_counter);
        end

        // Check if Trojan is activated
        @ (negedge clk);
        #2;
        $display("before counter %h", uut.trojan_counter);
        state = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key   = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        #210; // Wait for 21 clock cycles
        $display("after counter %h", uut.trojan_counter);
        if (out === 128'h3925841d02dc09fbdc118597196a0b32)
          begin $display("Trojan test: FAIL"); $finish; end
        else
          $display("Trojan activated successfully");

        // Check if normal operation resumes
        #10;
        state = 128'h00112233_44556677_8899aabb_ccddeeff;
        key   = 128'h00010203_04050607_08090a0b_0c0d0e0f;
        #210; // Wait for 21 clock cycles
        if (out !== 128'h69c4e0d86a7b0430d8cdb78070b4c55a)
          begin $display("Normal operation not resumed: FAIL"); $finish; end
        else
          $display("Normal operation resumed: PASS");

        $display("All tests completed");
        $finish;
    end
      
    always #5 clk = ~clk;
endmodule