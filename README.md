# Simple MIPS

An educational **32-bit MIPS-inspired processor** written in Verilog, with a Python assembler and module-level testbench sources.

The project uses **custom instruction encodings**; it is not binary-compatible with the standard MIPS ISA. Simulation results and waveforms will be added later.

## Design overview

The RTL connects a program counter and instruction memory to a control unit and datapath. The datapath includes an ALU, a 32-register file, data memory, immediate-extension logic and multiplexers.

- 32-bit instructions and datapath; 10-bit program-counter/address signals.
- 32 × 32-bit register file with two read ports and one write port; writes to register zero are disabled.
- Separate instruction and data memories, each declared as 1,024 × 32 bits.
- Arithmetic, logic, shift, comparison, load/store, branch and jump decoding.
- Python assembler with **27 base instruction mappings**, **9 pseudo-instruction expansions**, label resolution, syntax checks and hexadecimal output.

## Files

| Folder | Contents |
| --- | --- |
| [`rtl/`](rtl/) | CPU integration, control unit, datapath and supporting modules |
| [`testbench/`](testbench/) | ALU, register-file, data-memory and instruction-memory stimulus |
| [`tools/`](tools/) | Python assembly-to-hex converter |
| [`docs/verification-status.md`](docs/verification-status.md) | Current simulation status and preparation notes |

## Assembler

With Python 3 installed, supply an assembly file using registers `r0`–`r31`:

```sh
python tools/instr_converter.py program.asm instruction.mem
```

`program.asm` is your input file; no example program is included yet. The RTL loads `instruction.mem` relative to the simulator's working directory. Some pseudo-instructions use `r30` and `r31` as scratch registers; see the converter for the exact operand rules.

## Verification status

Four directed testbench sources are included. They provide stimulus for arithmetic/overflow cases, register and memory access, reset and instruction-read enable. They are not a completed self-checking regression suite.

**Pending:** resolve the source-integration items in the verification notes, run simulations, and add commands, expected-versus-observed results and waveform screenshots. No CPU-level pass result, coverage, synthesis or timing result is claimed in this version.
