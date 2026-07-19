# UART for ADPLL

## Overview

Designed and simulated **Universal Asynchronous Receiver/Transmitter (UART)** protocol in **Verilog HDL** for communication and controlin **All Digital Phase Locked Loop (ADPLL)** applications. The UART extends standard serial communication by supporting command-based register read/write operations through a custom frame format.

## Features

* Custom 5-byte communication frame
* UART Transmitter and Receiver
* Frame detection and parsing
* Command decoding
* Register read/write operations
* Functional simulation and verification in Vivado

## Frame Format

| Byte | Description      |
| ---- | ---------------- |
| 1    | Start of Frame   |
| 2    | Command          |
| 3    | Register Address |
| 4–5  | Data (16-bit)    |

## Tools

* Verilog HDL
* Xilinx Vivado



