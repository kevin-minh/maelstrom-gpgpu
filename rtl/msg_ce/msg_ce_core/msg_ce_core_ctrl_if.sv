/*
 * msg_ce_core_ctrl_if.sv
 *
 * @desc Compute Core to Controller Interface
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;

interface msg_ce_core_ctrl_if;
  // ==========================================================================
  // Signals
  // ==========================================================================

  logic start;
  logic done;

  warp_id_t   warp_id;
  thread_id_t thread_cnt;

  // ==========================================================================
  // Modports
  // ==========================================================================

  modport core (
    input  start,
    output done,
    input  warp_id,
    input  thread_cnt
  );

  modport ctrl (
    output start,
    input  done,
    output warp_id,
    output thread_cnt
  );

  modport monitor (
    input start,
    input done,
    input warp_id,
    input thread_cnt
  );

endinterface

