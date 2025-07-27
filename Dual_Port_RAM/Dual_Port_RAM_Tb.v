`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2025 18:38:00
// Design Name: 
// Module Name: Dual_Port_RAM_Tb
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


module Dual_Port_RAM_Tb;
    // Parameterized code for scaling hardware up when needded 
    parameter DATA_WIDTH = 7;
    parameter ADDR_WIDTH = 5;
    parameter RAM_LOC = 63;
    // Inputs to DUT
    reg [DATA_WIDTH:0] data_A, data_B;
    reg [ADDR_WIDTH:0] addr_A, addr_B;
    reg w_A, w_B, clk;

    // Outputs from DUT
    wire [DATA_WIDTH:0] q_A, q_B;

    // Instantiate the DUT
    Dual_Port_RAM #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RAM_LOC(RAM_LOC)
    ) X1
    (
        .data_A(data_A),
        .data_B(data_B),
        .addr_A(addr_A),
        .addr_B(addr_B),
        .w_A(w_A),
        .w_B(w_B),
        .clk(clk),
        .q_A(q_A),
        .q_B(q_B)
    );

    // 2ns time period clk
    initial clk = 0;
    always #1 clk = ~clk;
    
    integer i;//port_A loop control variable to write data 
    integer j;//port_B loop control variable to read data
    
    // Test procedure
    initial begin
        //initialize bits
        //data inputs 
        data_A = 0;
        data_B = 0;
        //addr bits of location
        addr_A = 0;
        addr_B = 0;
        //write enable bit
        w_A = 1;//we can use both ports to perform R/W but for large projects better 
        w_B = 0;
        
        //Write data using port_A to all locations 
        for (i = 0; i < RAM_LOC/2; i = i + 3) begin
            addr_A = i; 
            data_A = i+2;  // Or any data pattern
            #2;           // have 1 clk cycle wait
            @(posedge clk); // wait for clk to arrive so previous changes are written in console 
            $display("Write to RAM |At time t=%0t |addr_A=%d | data_A=%b", $time, addr_A, data_A);
        end
        
        $display("Write function over, R/W starts from here t=%0t", $time);
        
        /* standard code to run two for loop in parallel
        fork
            begin
                // First for loop
                for (int i = 0; i < 10; i = i + 1) begin
                    $display("Loop 1: i = %0d at time %0t", i, $time);
                    #5; // wait 5 time units
                end
            end

            begin
                // Second for loop
                for (int j = 0; j < 10; j = j + 1) begin
                    $display("Loop 2: j = %0d at time %0t", j, $time);
                    #7; // wait 7 time units
                end
            end
        join    
        */
        //two loops port_A writes data at odd locations and port_B reads data from 0-end
        fork
            //loop1 
            begin
                for (i = 0; i < RAM_LOC/2; i = i + 2) begin
                    addr_A = i; 
                    data_A = i+3;  // DATA which will be inputes
                    #2;           // 1 clk cycle wait time
                    @(posedge clk); // wait for clk to come in 
                    $display("Write to RAM |At time t=%0t |addr_A=%d | data_A=%b", $time, addr_A, data_A);
                end            
            end
            
            //loop2      
            begin                    
                for (j = 0; j < RAM_LOC/2; j = j + 1) begin
                    addr_B= j; //addr of location which will be read by port_B
                    #2;             // 1clk cycle wait 
                    @(posedge clk); 
                     $display("Read from RAM | t=%0t | addr_B=%d | q_B=%b", $time, addr_B, q_B);
                end
            end                       
        join
    end
endmodule
