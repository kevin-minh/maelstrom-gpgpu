/*
 * msg_ce_core_if.sv
 *
 * @desc Compute Core to MMU Interface
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;

interface msg_ce_core_mmu_if;
  // ==========================================================================
  // Signals
  // ==========================================================================

  logic  imem_req_vld;
  logic  imem_req_rdy;
  addr_t pc;

  logic  imem_resp_vld;
  logic  imem_resp_rdy;
  inst_t inst;

  logic  [`CE_CORE_NUM_LANES-1:0] dmem_read_vld;
  logic  [`CE_CORE_NUM_LANES-1:0] dmem_read_rdy;
  addr_t [`CE_CORE_NUM_LANES-1:0] dmem_read_addr;
  word_t [`CE_CORE_NUM_LANES-1:0] dmem_read_data;

  logic  [`CE_CORE_NUM_LANES-1:0] dmem_write_vld;
  logic  [`CE_CORE_NUM_LANES-1:0] dmem_write_rdy;
  addr_t [`CE_CORE_NUM_LANES-1:0] dmem_write_addr;
  word_t [`CE_CORE_NUM_LANES-1:0] dmem_write_data;
  
  // ==========================================================================
  // Modports
  // ==========================================================================
  
  modport core (
    output imem_req_vld,
    input  imem_req_rdy,
    output pc,
    input  imem_resp_vld,
    output imem_resp_rdy,
    input  inst,
    output dmem_read_vld,
    input  dmem_read_rdy,
    output dmem_read_addr,
    input  dmem_read_data,
    output dmem_write_vld,
    input  dmem_write_rdy,
    output dmem_write_addr,
    output dmem_write_data
  );

  modport mmu (
    input  imem_req_vld,
    output imem_req_rdy,
    input  pc,
    output imem_resp_vld,
    input  imem_resp_rdy,
    output inst,
    input  dmem_read_vld,
    output dmem_read_rdy,
    input  dmem_read_addr,
    output dmem_read_data,
    input  dmem_write_vld,
    output dmem_write_rdy,
    input  dmem_write_addr,
    input  dmem_write_data
  );

  modport monitor (
    input imem_req_vld,
    input imem_req_rdy,
    input pc,
    input imem_resp_vld,
    input imem_resp_rdy,
    input inst,
    input dmem_read_vld,
    input dmem_read_rdy,
    input dmem_read_addr,
    input dmem_read_data,
    input dmem_write_vld,
    input dmem_write_rdy,
    input dmem_write_addr,
    input dmem_write_data
  );

endinterface

