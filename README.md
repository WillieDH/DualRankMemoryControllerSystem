# SDR Dual-Rank RAM Controller

This repository contains the Verilog and SystemVerilog source code for a Single Data Rate (SDR) Dual-Rank RAM Controller. The design consists of a 128x8 memory bank, a memory rank with 4 banks, and a top module with 2 ranks.

## Contents

- `RAM_TOP.v`: Top-level module for the memory controller.
- `RAMR4x128.v`: Module for a memory rank consisting of 4 banks.
- `RAMB128x8.v`: Module for a single 128x8 memory bank.
- `RAM_TOP_tb.v`: Testbench for the `RAM_TOP` module.
- `RAMR4x128_tb.v`: Testbench for the `RAMR4x128` module.
- `RAMB128x8_tb.v`: Testbench for the `RAMB128x8` module.

## RAM Controller Design

The SDR Dual-Rank RAM Memory Controller is designed to manage memory operations. It utilizes a 19-bit command input (`command`) and operates on a positive clock edge (`clk`). The memory controller supports dual-rank configuration with each rank consisting of 4 memory banks, each bank having 128 locations of 8-bit data width.

- **Inputs and Outputs:**
  - **RAM_TOP Module:**
    - **Inputs:**
      - `command`: 19-bit command signal.
        - `[18]`: Write enable (1 for write, 0 for read).
        - `[17:10]`: Data to be written.
        - `[9]`: Rank address (0 or 1).
        - `[8:0]`: Bank address within the rank.
      - `clk`: Clock signal.
    - **Outputs:**
      - `data`: 8-bit data output.

  - **RAMR4x128 Module:**
    - **Inputs:**
      - `bankAddr`: 9-bit address for the bank.
      - `dataIn`: 8-bit data input.
      - `wr`: Write enable signal.
      - `clk`: Clock signal.
      - `be`: Bank enable signal.
    - **Outputs:**
      - `dataOut`: 8-bit data output.

  - **RAMB128x8 Module:**
    - **Inputs:**
      - `wordAddr`: 7-bit word address within the bank.
      - `dataIn`: 8-bit data input.
      - `cs`: Chip select signal.
      - `wr`: Write enable signal.
      - `clk`: Clock signal.
    - **Outputs:**
      - `dataOut`: 8-bit data output.

The controller is capable of performing read and write operations by selecting the appropriate rank and bank based on the command input.

## Verification

1. **RAM_TOP_tb**: Tests the `RAM_TOP` module by writing and reading data to/from different ranks.
2. **RAMR4x128_tb**: Tests the `RAMR4x128` module by writing and reading data to/from different banks within a rank.
3. **RAMB128x8_tb**: Tests the `RAMB128x8` module by writing and reading data to/from a single memory bank.


## Future Improvements
  - Add additional Ranks and Banks to increase memory size.
    
## License

This project is licensed under the GNU GPL v3. See the [LICENSE](LICENSE) file for more details.
