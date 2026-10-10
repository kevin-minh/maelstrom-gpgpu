/*
 * core_tb.sv
 */

module core_tb;
  // ==========================================================================
  // Signals
  // ==========================================================================
  logic clk_i;
  always begin
    #1 clk_i = !clk_i;
  end

  logic rst_ni;

  // ==========================================================================
  // Instantiations
  // ==========================================================================

  msg_ce_core_ctrl_if ctrl_if();
  msg_ce_core_mmu_if  mmu_if();

  msg_ce_core dut (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),
    .ctrl_if (ctrl_if.ctrl),
    .mmu_if  (mmu_if.mmu)
  );

  // ==========================================================================
  // Tasks
  // ==========================================================================

  task automatic init_sim;
    clk_i = 1'b0;
    rst_ni = 1'b0;
    @(negedge clk_i);
  endtask

  task automatic reset_dut;
    rst_ni = 1'b0;
    @(negedge clk_i);
    rst_ni = 1'b1;
    @(negedge clk_i);
  endtask
  
  // ==========================================================================
  // Test Sequence
  // ==========================================================================

  initial begin
    init_sim();
    reset_dut();

    repeat(10) @(negedge clk_i);
    $finish(0);
  end

endmodule

