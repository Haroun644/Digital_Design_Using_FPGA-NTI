# 🚀 RISC-V RV32I Processor

## 📌 Project Overview
This folder contains the RTL implementation of a **32-bit RISC-V Processor** supporting the **RV32I Base Integer Instruction Set**. This design was developed as the final project for the **Digital Design Using FPGA** program by the National Telecommunication Institute (NTI). 

The processor is designed to execute standard 32-bit instructions efficiently and is optimized for synthesis and deployment on FPGA architectures.

## ⚙️ Key Features
- **Architecture:** 32-bit RISC-V (RV32I Base ISA)
- **Implementation Style:** Single-Cycle Execution *(Update to "Pipelined" if applicable)*
- **Hardware Description Language (HDL):** Verilog / SystemVerilog
- **Instruction Support:** 
  - **R-type:** Arithmetic and Logic operations
  - **I-type:** Immediate Arithmetic, Loads, and JALR
  - **S-type:** Store instructions
  - **B-type:** Branching instructions
  - **U-type:** LUI and AUIPC
  - **J-type:** JAL (Jump and Link)

## 🗂️ Core Modules
The design is structurally modular, comprising the following main blocks:
* **ALU (Arithmetic Logic Unit):** Handles all mathematical and logical operations.
* **Control Unit:** Decodes incoming instructions and orchestrates datapath control signals.
* **Register File:** 32x32-bit registers supporting concurrent read and synchronous write.
* **Instruction Memory:** Stores the compiled assembly instructions.
* **Data Memory:** Handles Load/Store operations.
* **Program Counter (PC):** Manages instruction sequencing and branching targets.

## 🛠️ Tools & Technologies Used
- **Design & Coding:** Verilog / SystemVerilog
- **Simulation & Verification:** QuestaSim / ModelSim
- **Synthesis & FPGA Flow:** Xilinx Vivado

## 🚀 How to Run and Simulate
1. Clone the repository to your local machine:
   ```bash
   git clone [https://github.com/Haroun644/Digital_Design_Using_FPGA-NTI.git](https://github.com/Haroun644/Digital_Design_Using_FPGA-NTI.git)
