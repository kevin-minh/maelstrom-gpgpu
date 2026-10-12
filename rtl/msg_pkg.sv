/*
 * msv_pkg.sv
 *
 * @desc Global Project Definitions
 */


`ifndef msg_pkg
`define msg_pkg

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;

package msg_pkg;
  // ==========================================================================
  // Address Definitions
  // ==========================================================================
  `define ADDR_WIDTH 32
  typedef logic [`ADDR_WIDTH-1:0] addr_t;

  // ==========================================================================
  // Data Definitions
  // ==========================================================================
  typedef logic[7:0] byte_t;

  `define WORD_WIDTH 4 // in bytes
  typedef byte_t [`WORD_WIDTH-1:0] word_t;

  // ==========================================================================
  // Thread Definitions
  // ==========================================================================
  typedef logic[$clog2(`CE_CORE_NUM_WARPS)-1:0] warp_id_t;
  typedef logic[$clog2(`CE_CORE_NUM_LANES)-1:0] thread_id_t;

  // ==========================================================================
  // Instruction Definitions
  // ==========================================================================
  typedef enum logic [6:0] {
    OPCODE_ALU_R  = 7'b0110011,
    OPCODE_ALU_I  = 7'b0010011,
    OPCODE_LOAD   = 7'b0000011,
    OPCODE_STORE  = 7'b0100011,
    OPCODE_BRANCH = 7'b1100011,
    OPCODE_VORTEX = 7'b0001011
  } opcode_e;

  typedef logic [4:0] areg_t; // architectural register

  typedef logic [2:0] funct3_t;
  typedef logic [6:0] funct7_t;

  typedef struct packed {
    union packed {
      struct packed {
        funct7_t funct7;
        areg_t rs2;
        areg_t rs1;
        funct3_t funct3;
        areg_t rd;
      } r;
      struct packed {
        logic [11:0] imm;
        areg_t       rs1;
        funct3_t     funct3;
        areg_t       rd;
      } i;
      struct packed {
        logic [6:0] imm_hi;
        areg_t      rs2;
        areg_t      rs1;
        funct3_t    funct3;
        logic [4:0] imm_lo;
      } s;
      struct packed {
        logic [19:0] imm;
        areg_t       rd;
      } u;
    } fields;
    opcode_e opcode;
  } inst_t;

endpackage

`endif

