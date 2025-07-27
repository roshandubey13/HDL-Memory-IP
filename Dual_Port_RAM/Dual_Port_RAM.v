`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2025 06:03:24
// Design Name: 
// Module Name: Single_Port_RAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/*
module module_name 
#(
    parameter PARAM1 = value1,
    parameter PARAM2 = value2
)
(
    input  wire signal1,
    output wire signal2
);

// Module implementation

endmodule

*/
module Dual_Port_RAM
#(
    parameter DATA_WIDTH = 7,
    parameter ADDR_WIDTH = 5,
    parameter RAM_LOC = 63
 )
 (
    input [DATA_WIDTH :0] data_A,data_B,
    input [ADDR_WIDTH:0] addr_A, addr_B,
    input w_A, w_B, clk,
    output reg [DATA_WIDTH:0] q_A, q_B
);
    //RAM block declared 64*8 bit ie 512bits
    reg [DATA_WIDTH:0] RAM [RAM_LOC:0];  // 64 locations
    
    //port_A
    always @(posedge clk) begin
        if (w_A) begin
            RAM[addr_A] <= data_A;  // Write
            q_A <= RAM[addr_A]; end //This one is there to fetch the previous value written at that position
        else
            q_A <= RAM[addr_A];
    end
    
    //port_B
    always @(posedge clk) begin
        if (w_B) begin
            RAM[addr_B] <= data_B;  // Write
            q_B <= RAM[addr_B]; end //This one is there to fetch the previous value written at that position
        else
            q_B <= RAM[addr_B];
    end    

endmodule
