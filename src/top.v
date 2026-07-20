`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module toplevel (
input wire clk,
input wire rst,
input wire rx,
output wire TX_data_out
);
//internal wires
wire [7:0] cmd_msb;
wire [7:0] cmd_lsb;
wire [7:0] data_msb;
wire [7:0] data_lsb;
wire buffer_full;
wire buffer_processed;
wire [15:0] reg_data_in, reg_data_out;
wire [7:0] tx_data;
wire [3:0] reg_addr;
wire write_en, read_en;
wire tx_start;
wire TX_busy;
wire [7:0]rx_data;
wire rx_ready;
wire frame_start;
// === Module Instantiations ===
uart_receiver uart_rx (
.clk(clk),
.rst(rst),
.rx(rx),
.clk_div(16'd868), // Pass the clock divider value (must be defined)
.rx_ready(rx_ready), // Output ready signal when data is received
.rx_data(rx_data), // Output data from the UART receiver
.rx_error() // Output any error detected during reception
);
frame_detector fd (
.clk(clk),
.rst(rst),
.rx_data(rx_data),
.rx_data_valid(rx_ready),
.frame_start(frame_start)
);
command_buffer cb (
.clk(clk),
.rst(rst),
.rx_data(rx_data),
.rx_data_valid(rx_ready),
.buffer_processed(buffer_processed),
.frame_start(frame_start),
.cmd_msb(cmd_msb),
.cmd_lsb(cmd_lsb),
.data_msb(data_msb),
.data_lsb(data_lsb),
.buffer_full(buffer_full)
);
command_fsm fsm (
.clk(clk),
.rst(rst),
.buffer_full(buffer_full),
.cmd_msb(cmd_msb),
.cmd_lsb(cmd_lsb),
.data_msb(data_msb),
.data_lsb(data_lsb),
.tx_busy(TX_busy),
.reg_addr(reg_addr),
.reg_data_in(reg_data_in),
.reg_data_out(reg_data_out),
.write_en(write_en),
.read_en(read_en),
.tx_start(tx_start),
.tx_data(tx_data),
.buffer_processed(buffer_processed)
);
register_file rf (
.clk(clk),
.rst(rst),
.addr(reg_addr),
.data_in(reg_data_in),
.write_en(write_en),
.read_en(read_en),
.data_out(reg_data_out)
);
UART_TX uart_tx_inst (
.clk(clk),
.rst(rst),
.TX_start(tx_start),
.TX_data_in(tx_data),
.TX_data_out(TX_data_out),
.TX_busy(TX_busy)
);
endmodule
