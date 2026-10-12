# =============================================================================
# Top-Level Project Makefile
# =============================================================================
ENV_FILE := setup.sh
ifndef PROJECT_ROOT
$(error Environment variables not set. Please run 'source $(ENV_FILE)' before running make commands.)
endif

.ONESHELL:

# =============================================================================
# Status and Quick View
# =============================================================================

.PHONY: help rtl tb
.DEFAULT_GOAL: help
## Displays full make target list with comments. (DEFAULT)
help:
	@clear
	@echo "================================================================================"
	@echo "  Project Build System"
	@echo "================================================================================"
	@echo "Usage: make [target] [OPTION=value]"
	@echo ""
	@echo "Available targets:"
	@awk '/^## / {desc=substr($$0, 4)} /^[a-zA-Z0-9_%.-]+:/ {if (desc) {printf "  \033[36m%-15s\033[0m %s\n", $$1, desc; desc=""}}' $(firstword $(MAKEFILE_LIST)) | sed 's/://'
	@echo "================================================================================"

## Displays full RTL directory with comments.
rtl:
	@clear
	@python3 $(SCRIPTS_DIR)/view_dir.py rtl

## Displays full testbench (TB) directory with comments.
tb:
	@clear
	@python3 $(SCRIPTS_DIR)/view_dir.py tb

# =============================================================================
# RTL Design and Verification
# =============================================================================

.PHONY: FORCE
FORCE:

# Check Testbench Exists
%.check: FORCE
	@test -e $(TB_DIR)/$*/$*.f || { \
		echo "ERROR: Testbench $* does not exist: Expected '$(TB_DIR)/$*/$*.f' "; exit 1; \
	}

# Create Design Parameters Package
msg_params_pkg.sv:
	@python3 ${SCRIPTS_DIR}/gen_param_pkg.py

## Run RTL Simulations
%.sim: %.check msg_params_pkg.sv FORCE
	@mkdir -p $(SIM_DIR)/$*
	@mkdir -p $(REPORTS_DIR)/$*
	@printf "[INFO] Compiling \"$*\"...\r"
	@$(SIM) -f $(SIM_OPTS) --Mdir $(SIM_DIR)/$* -f $(TB_DIR)/$*/$*.f > $(SIM_DIR)/$*/$(SIM).log 2> $(SIM_DIR)/$*/err.log
	@python3 $(SCRIPTS_DIR)/parse_verilator_logs.py $*
	@printf "[INFO] Simulating \"$*\"...\r"
	@$(SIM_DIR)/$*/V$* > $(REPORTS_DIR)/$*/$(SIM).out
	@printf "[INFO] Simulating \"$*\"...\n"

# =============================================================================
# Cleanup
# =============================================================================

.PHONY: clean nuke

## Delete RTL simulation build directories and reports
clean:
	@rm -rf $(SIM_DIR)
	@rm -rf $(REPORTS_DIR)

## Delete synthesis outputs
clean_synth: 
	@rm -rf $(SYNTH_DIR)

## Delete APR outputs
clean_apr: 
	@rm -rf $(APR_DIR)
