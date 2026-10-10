/*
 * msg_ce_core_pkg.sv
 *
 * @desc Compute Core Definitions
 */

/* verilator lint_off IMPORTSTAR */
import msg_params_pkg::*;
import msg_pkg::*;

package msg_ce_core_pkg;
  typedef enum logic[2:0] {
    CORE_STATE_IDLE    = 3'b000,
    CORE_STATE_FETCH   = 3'b001,
    CORE_STATE_DECODE  = 3'b011,
    CORE_STATE_REQUEST = 3'b111,
    CORE_STATE_WAIT    = 3'b110,
    CORE_STATE_EXECUTE = 3'b100,
    CORE_STATE_UPDATE  = 3'b101,
    CORE_STATE_DONE    = 3'b010
  } core_state_e;


endpackage

