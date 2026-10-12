// ============================================================================
// Includes File List
// 
// @desc Core Testbench Inclusions Filelist
// ============================================================================

-f $(RTL_DIR)/msg_ce/msg_ce_core/msg_ce_core.f

$(TB_DIR)/tb_pkg.sv
$(TB_DIR)/core_tb/core_tb.sv

--top-module core_tb

