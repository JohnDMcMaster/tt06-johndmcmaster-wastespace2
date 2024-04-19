/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    reg [3:0] ascii_rom_counter;
    wire [0:7] ascii_rom [15:0];
    assign ascii_rom[0]  = "s";
    assign ascii_rom[1]  = "i";
    assign ascii_rom[2]  = "l";
    assign ascii_rom[3]  = "i";
    assign ascii_rom[4]  = "c";
    assign ascii_rom[5]  = "o";
    assign ascii_rom[6]  = "n";
    assign ascii_rom[7]  = "p";
    assign ascii_rom[8]  = "r";
    assign ascii_rom[9]  = "0";
    assign ascii_rom[10] = "n";
    assign ascii_rom[11] = ".";
    assign ascii_rom[12] = "o";
    assign ascii_rom[13] = "r";
    assign ascii_rom[14] = "g";
    assign ascii_rom[15] = 0;

    assign uo_out  = ascii_rom[ascii_rom_counter];
    assign uio_oe = 8'b01111111;
    //unity
    assign uio_out[0] = ui_in[0];
    //not
    assign uio_out[1] = ~ui_in[1];
    //nand
    assign uio_out[2] = ~(ui_in[2] & ui_in[1]);
    //nor
    assign uio_out[3] = ~(ui_in[3] | ui_in[2]);
    //xor
    assign uio_out[4] = ui_in[4] ^ ui_in[3];
    //xnor
    assign uio_out[5] = ~(ui_in[4] ^ ui_in[3]);
    //Passthrough other bit
    assign uio_out[6] = ~uio_in[7];

    always @(posedge clk, negedge rst_n) begin
        if (~rst_n)
            ascii_rom_counter = 4'b0;
        else
            ascii_rom_counter = ascii_rom_counter + 4'b1;
    end

endmodule
