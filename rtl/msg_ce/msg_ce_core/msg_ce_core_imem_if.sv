/*
 * msg_ce_core_if.sv
 *
 * @desc Compute Core to IMEM Interface
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;
import msg_ce_core_pkg::*;

interface msg_ce_core_imem_if;

  // ==========================================================================
  // Signals
  // ==========================================================================

  // IMEM Request Channel
  logic  req_vld;
  logic  req_rdy;
  addr_t req_pc;

  // IMEM Response Channel
  logic  res_vld;
  inst_t res_inst;

  // ==========================================================================
  // Functions
  // ==========================================================================

  function automatic request(addr_t pc);
    req_vld = 1'b1;
    req_pc  = pc;
  endfunction

  function automatic logic request_fire();
    return req_vld && req_rdy;
  endfunction
  
  // ==========================================================================
  // Modports
  // ==========================================================================
  
  modport core (
    output req_vld,
    input  req_rdy,
    output req_pc,

    input  res_vld,
    input  res_inst
  );

  modport imem (
    input  req_vld,
    output req_rdy,
    input  req_pc,

    output res_vld,
    output res_inst
  );

  modport monitor (
    input req_vld,
    input req_rdy,
    input req_pc,

    input res_vld,
    input res_inst
  );

endinterface

