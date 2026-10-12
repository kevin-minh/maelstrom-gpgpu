/*
 * tb_pkg.sv
 *
 * @desc Global Testbench Definitions
 *
 * Author: Kevin Nguyen
 * Last Updated: 2026-10-04
 */

package tb_pkg;
  `define SET_DEFAULT(NAME, VAL) \
    `ifndef NAME \
      `define NAME VAL \
    `endif

endpackage

