/*
 * msg_ce_core_if.sv
 *
 * @desc Compute Core to DMEM Interface
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;
import msg_ce_core_pkg::*;

interface msg_ce_core_dmem_if;

  // ==========================================================================
  // Signals
  // ==========================================================================

  // DMEM Read Request Channel
  logic                           rreq_vld;
  logic                           rreq_rdy;
  addr_t [`CE_CORE_NUM_LANES-1:0] rreq_addr;

  // DMEM Read Response Channel
  logic                           rres_vld;
  word_t [`CE_CORE_NUM_LANES-1:0] rres_data;

  // DMEM Write Channel
  logic                           wreq_vld;
  logic                           wreq_rdy;
  addr_t [`CE_CORE_NUM_LANES-1:0] wreq_addr;
  word_t [`CE_CORE_NUM_LANES-1:0] wreq_data;
  
  // ==========================================================================
  // Functions
  // ==========================================================================

  function automatic request_read(addr_t [`CE_CORE_NUM_LANES-1:0] addr);
    rreq_vld  = '1;
    rreq_addr = addr;
  endfunction

  function automatic logic request_read_fire();
    return rreq_vld && rreq_rdy;
  endfunction

  function automatic request_write(
    addr_t [`CE_CORE_NUM_LANES-1:0] addr, 
    word_t [`CE_CORE_NUM_LANES-1:0] data
  );
    wreq_vld  = '1;
    wreq_addr = addr;
    wreq_data = data;
  endfunction

  function automatic logic request_write_fire();
    return wreq_vld && wreq_rdy;
  endfunction

  // ==========================================================================
  // Modports
  // ==========================================================================
  
  modport core (
    output rreq_vld,
    input  rreq_rdy,
    output rreq_addr,

    input  rres_vld,
    input  rres_data,

    output wreq_vld,
    input  wreq_rdy,
    output wreq_addr,
    output wreq_data
  );

  modport dmem (
    input  rreq_vld,
    output rreq_rdy,
    input  rreq_addr,

    output rres_vld,
    output rres_data,

    input  wreq_vld,
    output wreq_rdy,
    input  wreq_addr,
    input  wreq_data
  );

  modport monitor (
    input rreq_vld,
    input rreq_rdy,
    input rreq_addr,

    input rres_vld,
    input rres_data,

    input wreq_vld,
    input wreq_rdy,
    input wreq_addr,
    input wreq_data
  );

endinterface

