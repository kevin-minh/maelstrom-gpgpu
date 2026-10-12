#!/bin/bash

# =============================================================================
# Maelstrom-V Environment Setup Script
#
# Run every session to populate environment variables for build system.
# =============================================================================

# =============================================================================
# Design Directories
# =============================================================================
export PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export RTL_DIR="${PROJECT_ROOT}/rtl"
export TB_DIR="${PROJECT_ROOT}/tb"
export SCRIPTS_DIR="${PROJECT_ROOT}/scripts"
export INPUTS_DIR="${PROJECT_ROOT}/inputs"

# =============================================================================
# Generated Directories
# =============================================================================
export SIM_DIR="${PROJECT_ROOT}/sim"
export REPORTS_DIR="${PROJECT_ROOT}/reports"
export SYNTH_DIR="${PROJECT_ROOT}/synth"
export APR_DIR="${PROJECT_ROOT}/apr"

# =============================================================================
# Simulator
# =============================================================================
export SIM="verilator"
export SIM_OPTS="${SCRIPTS_DIR}/verilator.f"

echo "[Maelstrom-V] Environment initialized."
echo "  PROJECT_ROOT : ${PROJECT_ROOT}"
echo "  SIM          : ${SIM}"
