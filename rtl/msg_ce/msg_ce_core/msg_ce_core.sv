/*
 * msv_ce_core.sv
 * 
 * @desc Compute Core Top-Level SIMD Execution Unit
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;
import msg_ce_core_pkg::*;

module msg_ce_core #(
  parameter int unsigned NUM_WARPS = `CE_CORE_NUM_WARPS,
  parameter int unsigned NUM_LANES = `CE_CORE_NUM_LANES,
  localparam int unsigned REGS_PER_LANE = 32
) (
  input clk_i,
  input rst_ni,

  msg_ce_core_ctrl_if.core ctrl_if,
  msg_ce_core_imem_if.core imem_if,
  msg_ce_core_dmem_if.core dmem_if
);
  
  // ==========================================================================
  // Core FSM
  // ==========================================================================
  core_state_e core_state_q, core_state_d;
  always_ff @(posedge clk_i) begin
    if (!rst_ni) begin
      core_state_q <= CORE_STATE_IDLE;
    end else begin
      core_state_q <= core_state_d;
    end
  end
  
endmodule

