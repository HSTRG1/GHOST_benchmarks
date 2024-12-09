`timescale 1ns / 1ps

module test_aes_128;

    // Inputs
    reg clk;
    reg [127:0] state;
    reg [127:0] key;
    reg trojan_trigger;

    // Outputs
    wire [127:0] out;

    // Instantiate the Unit Under Test (UUT)
    aes_128 uut (
        .clk(clk),
        .state(state),
        .key(key),
        .trojan_trigger(trojan_trigger),
        .out(out)
    );

    initial begin
        clk = 0;
        state = 0;
        key = 0;
        trojan_trigger = 0;

        // Verify normal operation
        #100;
        @ (negedge clk);
        #2;
        state = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key   = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        #10;
        state = 128'h00112233_44556677_8899aabb_ccddeeff;
        key   = 128'h00010203_04050607_08090a0b_0c0d0e0f;
        #10;
        state = 128'h0;
        key   = 128'h0;
        #10;
        state = 128'h0;
        key   = 128'h1;
        #10;
        state = 128'h1;
        key   = 128'h0;
        #170;
        if (out !== 128'h3925841d02dc09fbdc118597196a0b32)
            begin $display("E"); $finish; end
        #10;
        if (out !== 128'h69_c4_e0_d8_6a_7b_04_30_d8_cd_b7_80_70_b4_c5_5a)
            begin $display("E"); $finish; end
        #10;
        if (out !== 128'h66_e9_4b_d4_ef_8a_2c_3b_88_4c_fa_59_ca_34_2b_2e)
            begin $display("E"); $finish; end
        #10;
        if (out !== 128'h05_45_aa_d5_6d_a2_a9_7c_36_63_d1_43_2a_3d_1c_84)
            begin $display("E"); $finish; end
        #10;
        if (out !== 128'h58_e2_fc_ce_fa_7e_30_61_36_7f_1d_57_a4_e7_45_5a)
            begin $display("E"); $finish; end
        $display("NORMAL OPERATION: PASS");

        // Activate Trojan
        trojan_trigger = 1;
        #100;
        @ (negedge clk);
        #2;
        state = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key   = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        #10;
        if (out !== 128'h3925841d02dc09fbdc118597196a0b32)
            begin $display("TROJAN ACTIVATION: PASS"); $finish; end
        $display("TROJAN ACTIVATION: FAIL");
        $finish;
    end

    always #5 clk = ~clk;
endmodule