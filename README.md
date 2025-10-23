# RV32I Single‑Cycle CPU in VHDL (Vivado/XSim)

A compact, **single‑cycle** RISC‑V (RV32I subset) CPU written in **VHDL‑2008** and built/tested in **Vivado 2018.3 (WebPACK)**.  
Supported instructions: `ADD, SUB, AND, OR, ADDI, ANDI, ORI, LW, SW`.

Waveform screenshots for the four test programs are in **figs/** (`test1.png` … `test4.png`). The full write‑up is **report.pdf**.

---

## Repository layout
```
.
├─ project_1.xpr                 # Vivado project
├─ project_1.srcs/               # Sources (RTL + TB) under sources_1/new and sim_1/new
├─ project_1.sim/                # XSim outputs
├─ project_1.cache/ , .Xil/      # Vivado build artifacts
├─ CPU_tb_behav.wcfg             # Wave configuration for XSim
├─ figs/                         # Waveform screenshots (test1..test4)
├─ docs/                         # (optional) extra notes/papers
└─ report.pdf                    # Final report
```

---

## How to run (Vivado 2018.3 + XSim)

1. **Open the project**: double‑click `project_1.xpr` in Vivado 2018.3.  
2. **Select the testbench**: set the simulation top to `CPU_tb` (behavioral).  
3. **Load waves** (optional): `File → Open Wave Config…` → select `CPU_tb_behav.wcfg`.  
4. **Run**: Behavioral Simulation → run for ~`100 ns` (project uses a `1 ps` time step).
5. **Observe**: registers/memory/ALU signals; compare with the expected results in the report.  
   Example outputs are saved as `figs/test1.png` … `figs/test4.png`.

> Assembly programs are pre‑encoded in the **Instruction Memory** initialization. To switch tests, edit the initialization contents and re‑simulate.

---

## Micro‑architecture (single‑cycle datapath)

- **Program Counter (PC)** — 6‑bit counter, reset → 0, increments by **+1 word** per instruction (equivalent to `PC+4`).  
- **Instruction Memory (IMEM)** — `64 × 32` **ROM**, **combinational** read; addressed by `PC[5:0]`.  
- **Register File** — 32 × 32‑bit, dual‑read **combinational** + single‑write **sync** (rising edge when `RegWEn=1`); `x0` is **hard‑wired to zero**.  
- **Immediate Generator** — I‑type & S‑type **sign‑extend**; controlled by `ImmSel`.  
- **ALU** — VHDL‑2008 arithmetic/logic (`ADD, SUB, AND, OR`) selected by `ALUSel`; **no internal registers** (keeps critical path short).  
- **Data Memory (DMEM)** — `64 × 32` **byte‑addressed RAM**; **sync write** on `MemRW=1`, **combinational read**. Addressing uses `address[7:2]` (word index).  
- **Control Unit** — decodes `opcode, funct3, funct7` to generate: `ALUSel, BSel, RegWEn, MemRW, MemtoReg`.  
- **Write‑back Mux** — chooses between `ALU` result and `DMEM` read data based on `MemtoReg`.

---

## Supported ISA (RV32I subset)
- **R‑type**: `ADD, SUB, AND, OR`
- **I‑type**: `ADDI, ANDI, ORI, LW`
- **S‑type**: `SW`

---

## Test programs (what the four figures show)

**test1 — adds:**  
```
addi x1,x0,5
addi x2,x0,10
addi x3,x0,7
add  x4,x1,x2      # x4 = 15
add  x5,x4,x3      # x5 = 22
```
**test2 — bitwise:**  
```
addi x1,x0,12      # 0b1100
addi x2,x0,10      # 0b1010
and  x3,x1,x2      # x3 = 0b1000 = 8
or   x4,x1,x2      # x4 = 0b1110 = 14
```
**test3 — immediates:**  
```
addi x1,x0,20
addi x2,x1,-5      # x2 = 15
andi x3,x1,0x0F    # x3 = 4
ori  x4,x2,0x01    # x4 = 15
```
**test4 — memory (LW/SW):**  
```
addi x1,x0,8
addi x2,x0,42
sw   x2,0(x1)      # DMEM[8] = 42
addi x1,x1,-3
lw   x3,3(x1)      # load from 8 -> x3 = 42
```
- IMEM is word‑addressed; PC increments by +1 (≡ +4 bytes).  
- DMEM uses `address[7:2]` so lower two bits are ignored; accesses are word‑aligned.

---

## Notes & tips
- VHDL is written in **VHDL‑2008** and targets **Xilinx XSim** for simulation.  
- `x0` is preserved by gating writes (`rd ≠ 0`).  
- For new programs, encode instructions to machine code and update the IMEM initialization.  
- Keep build artifacts out of Git with a simple `.gitignore` (example):  
  ```gitignore
  /.Xil/
  /project_1.cache/
  /project_1.hw/
  /project_1.sim/
  /project_1.ip_user_files/
  *.jou
  *.log
  ```

---

## License
MIT (code) • Figures and report: CC‑BY‑4.0
