# HDL-Memory-IP

## Project Overview

This repository contains **parameterized Verilog implementations** of commonly used memory IP cores currently including:

- Single-Port RAM  
- Dual-Port RAM  
- FIFO *(testbench pending)*

These modules are designed with scalability and reusability in mind for **FPGA and ASIC** projects.
Future updates will expand the library to include more advanced memory components, such as **ECC RAM** and **DDR controllers**, enabling rapid integration into larger digital systems.

Developed as part of self-guided hardware IP design projects, these modules provide verified, simulation-ready components suitable for both high-performance and resource-constrained environments.

## Key Features

- Fully parameterized address and data width for flexible system integration  
- Optimized design for both FPGA and ASIC toolchains  
- Testbenches included for functional validation (except FIFO, in progress)  
- Waveform configuration files (`.wcfg`) for ModelSim/Vivado simulations  
- Clean and modular structure, reusable across designs  
- Future support for ECC RAM, burst-mode memory, cache architectures, and multi-bank RAMs  

---

## Module Descriptions

### 📌 Single-Port RAM

A synchronous memory supporting the following operations:
- Single read (R)
- Single write (W)
- Simultaneous read/write to different addresses

#### Testbench Behavior

- Data is written to 7 specific memory locations
- After disabling write, the same locations are read to verify data integrity  
- `Q` remains at its initial value until valid read occurs (if address overlap is avoided)

#### Simulation Output

**TCL Console:**  
<img width="650" height="304" alt="Single-Port TCL Output" src="https://github.com/user-attachments/assets/44eddcb0-1e2e-4a11-b1a0-aeca5aa9029d" />

**Waveform Result:**  
<img width="1622" height="300" alt="Single-Port Waveform" src="https://github.com/user-attachments/assets/2eece3ef-a1b4-4a4d-8812-2ef57c68dd54" />

---

### 📌 Dual-Port RAM

Supports concurrent access with separate read and write ports, commonly used in pipelined architectures or memory layers in neural networks.

#### Configuration:
- 1 Read (Port B) & 1 Write (Port A) simultaneously 

#### Testbench Behavior

- Port A writes to odd addresses
- Forked parallel loop performs:
  - Port B reads from all addresses [0:30]
  - Port A writes to even addresses [0:30]
- Memory locations with **prime-numbered addresses** are intentionally not written into, resulting in undefined or don't-care values during read

#### Simulation Output

**Write Operation (TCL Console):**  
<img width="440" height="222" alt="Dual-Port Write TCL" src="https://github.com/user-attachments/assets/d57dfef8-a3f0-47c4-8670-5d212029d34b" />

**Read & Write Concurrent Behavior:**  
<img width="460" height="424" alt="Dual-Port Prime Addr Reads" src="https://github.com/user-attachments/assets/0ecc29f9-8ddb-431e-800a-7d8fccaded9e" />

**Waveform Result:**  
<img width="1618" height="378" alt="Dual-Port Waveform" src="https://github.com/user-attachments/assets/c89bd978-ffb8-4654-8e56-36e97588b8fc" />


---
## Future Modules (Planned)
- ECC RAM with bit error detection and correction  
- Multi-bank RAM and bank arbitration logic  
- FIFO (testbench WIP)
- Cache memory (direct-mapped / associative)  
- DDR memory controller interface  
- Burst-mode memory access support  
---
## Usage Notes
These memory blocks are intended to serve as core components for a wide range of digital designs, including:
- Custom processors
- AI/ML accelerators *(currently being explored for implementation)*  
- SoC designs
- Memory-intensive applications

All modules are written in synthesizable Verilog and can be integrated into RTL projects targeting FPGA or ASIC flows.
---
