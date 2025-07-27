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

module Single_Port_RAM(data, read_addr, write_addr, w, clk, q);
    parameter DATA_WIDTH = 7;
    parameter ADDR_WIDTH = 5;
    parameter RAM_LOC = 63;
    input [DATA_WIDTH :0] data;
    input [ADDR_WIDTH:0] read_addr, write_addr;
    input w, clk;
    output reg [7:0] q;
    
    

    reg [DATA_WIDTH:0] RAM [RAM_LOC:0];  // 64 locations
    
    always @(posedge clk) begin
        if (w)
            RAM[write_addr] <= data;  // Write
        q <= RAM[read_addr];          // Read
    end

endmodule
