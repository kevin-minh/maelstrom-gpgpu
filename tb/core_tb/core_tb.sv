/*
 * core_tb.sv
 *
 * @desc Core Testbench Top-Level
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
  msg_ce_core_imem_if imem_if();
  msg_ce_core_dmem_if dmem_if();

  msg_ce_core dut (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),
    .ctrl_if (ctrl_if.ctrl),
    .imem_if (imem_if.imem),
    .dmem_if (dmem_if.dmem)
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

