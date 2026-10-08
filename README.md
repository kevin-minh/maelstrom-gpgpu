# Maelstrom-V

maelstrom
/māl'strəm/

noun

1. A powerful, high-velocity whirlpool created when opposing currents force fluid to revolve rapidly around a central axis.
"a massive tidal maelstrom off the coast."

2. An open-source RISC-V SIMT GPGPU microarchitecture that funnels massive parallel thread execution through a high-throughput hardware pipeline.
"scaling thread blocks on the Maelstrom-V core."

Maelstrom-V is an open-source, baseline Single Instruction, Multiple Threads (SIMT) GPGPU accelerator designed as a custom hardware implementation for EECS 627 (Advanced VLSI Design) at the University of Michigan. Built on top of the Vortex GPGPU research platform, it extends the standard 32-bit RISC-V (RV32I) ISA with basic SIMT execution mechanisms—including a primary warp scheduler, fundamental thread divergence control (tmc, wspawn, split, join), and dual AXI5 interfaces (an AXI5-Lite subordinate for host CPU CSR control and a Full AXI5 manager for memory transfers)—providing a clean, unoptimized SystemVerilog baseline ready for end-to-end ASIC synthesis, placement, routing, and timing closure.

