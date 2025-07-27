`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2025 02:20:10
// Design Name: 
// Module Name: Single_Port_RAM_Tb
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

module Single_Port_RAM_Tb;

    reg [7:0] data_Tb;
    reg [5:0] R_A, W_A;
    reg w, clk;
    wire [7:0] Q;

    // Instantiate the DUT
    Single_Port_RAM X1 (
        .data(data_Tb),
        .read_addr(R_A),
        .write_addr(W_A),
        .w(w),
        .clk(clk),
        .q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    integer i;
    integer j;
    // Test sequence
    initial begin
        w = 1;
        data_Tb = 8'b00000000;
        R_A = 6'd0;
        W_A = 6'd0;
        #10;

        // Write data into all 64 locations
        for (i = 0; i < 64; i = i + 10) begin
            W_A = i;
            data_Tb = i;  // Or any data pattern
            #2;           // Allow data/setup before the clock edge
            @(posedge clk); // Synchronize to positive clock edge for write
            $display("Write | t=%0t | W_A=%0d | Data=%b", $time, W_A, data_Tb);
        end

        // Wait and then read back all locations
        #10;
        w = 0;

        for (j = 0; j < 64; j = j + 10) begin
            R_A = j;
            #2;             // Allow time for address to propagate
            @(posedge clk); // Synchronize to positive clock edge for read
            $display("Read  | t=%0t | R_A=%0d | Q=%b", $time, R_A, Q);
        end

    end

endmodule
