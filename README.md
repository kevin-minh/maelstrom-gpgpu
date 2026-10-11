# Maelstrom-GPGPU

maelstrom
/māl'strəm/

noun

1. A powerful, high-velocity whirlpool created when opposing currents force fluid to revolve rapidly around a central axis.
"a massive tidal maelstrom off the coast."

2. An open-source RISC-V SIMT GPGPU microarchitecture that funnels massive parallel thread execution through a high-throughput hardware pipeline.
"scaling thread blocks on the Maelstrom-GPGPU core."

Maelstrom-GPGPU (MSG) is an open-source Single Instruction Multiple Threads (SIMT) General-Purpose Graphics Processing Unit (GPGPU) accelerator designed as a custom hardware implementation for EECS 627 (Advanced VLSI Design) at the University of Michigan. MSG is built to output clean RTL ready for end-to-end ASIC synthesis, placement, routing, timing closure, and power analysis. Built on top of the Vortex GPGPU research platform, it extends the standard 32-bit RISC-V (RV32I) ISA with basic SIMT execution mechanisms—including a primary warp scheduler, fundamental thread divergence control (tmc, wspawn, split, join), and dual AXI5 interfaces (an AXI5-Lite subordinate for host CPU CSR control and a Full AXI5 manager for memory transfers). 

## Table of Contents
[Development Status and Roadmap](##development-status-and-roadmap)
[Usage](##usage)

## Development Status and Roadmap

### Phase 1: Baseline Single-Warp Bring-Up (CURRENT)
- Compute cores process **1** warp at a time.
- Compute cores interface directly with MMU.
- Testing simple workloads.

### Phase 2: Full SIMT + Multi-Warp Interleaving

## Usage

Before using the build system, view 'setup.sh' and its contents. Then run 'source setup.sh' to populate relevant environment variables.

Run 'make' or 'make help' to display all the relevant make targets.j

