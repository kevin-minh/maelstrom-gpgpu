/*
 * msg_ce_core_fdu.sv
 *
 * @desc Compute Core Fetch-Decode Unit Frontend
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;
import msg_ce_core_pkg::*;

module msg_ce_core_fdu (
  input clk_i,
  input rst_ni,

  input core_state_e core_state,

  msg_ce_core_ctrl_if.core ctrl_if,
  msg_ce_core_imem_if.core imem_if
);
  
endmodule

