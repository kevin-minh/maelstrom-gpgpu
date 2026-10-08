#!/bin/bash

# Maelstrom-V Environment Setup Script

# Directories
export PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export RTL_DIR="${PROJECT_ROOT}/rtl"
export TB_DIR="${PROJECT_ROOT}/tb"

# Generated Directories
export SIM_DIR="${PROJECT_ROOT}/sim"
export REPORTS_DIR="${PROJECT_ROOT}/reports"

echo "[Maelstrom-V] Environment initialized."
echo "  PROJECT_ROOT = ${PROJECT_ROOT}"
