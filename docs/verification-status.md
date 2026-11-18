# Verification status

This initial publication preserves the supplied Verilog and Python source contents. Files were grouped into folders; no HDL simulation was run for this upload.

## Preparation items identified by source inspection

- `rtl/cpu.v` includes `imem.v`, while the supplied instruction-memory file is named `instr_mem.v`.
- `testbench/ALU_tb.v` is missing its closing `endmodule`.
- `testbench/reg_file_tb.v` holds the active-low reset asserted throughout its stimulus; release reset before evaluating register writes and reads.
- `rtl/instr_mem.v` loads `instruction.mem` initially, but reset clears the memory array. Decide the intended program-loading/reset sequence before CPU tests.
- Set the RTL include directory and choose a consistent compilation strategy to avoid duplicate module definitions from both includes and a full source list. Ensure `mux2_1.v` is included in the build.
- Review the 32-bit adder connections to 10-bit PC signals and confirm intentional truncation/address behavior.

## Results to add later

1. Simulator/version and reproducible compilation/run commands.
2. Module tests with expected values and automatic pass/fail checks.
3. CPU-level program execution with a known instruction-memory image.
4. Waveforms and a short table of tested cases and observed results.

These notes identify visible preparation issues, not an exhaustive functional review.
