`timescale 1ns / 1ps

module tb_lab4();
    reg CLK;
    reg WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;
    reg [1:0] ALUop;
    wire [31:0] RD1, RD2, ALUresult;
    
    // Instantiate top module
    top_module uut (
        .CLK(CLK),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .ALUop(ALUop),
        .RD1(RD1),
        .RD2(RD2),
        .ALUresult(ALUresult)
    );
    
    // Clock generation
    always #5 CLK = ~CLK;
    
    initial begin
        // Initialize inputs
        CLK = 0;
        WE3 = 0;
        A1 = 0;
        A2 = 0;
        A3 = 0;
        WD3 = 0;
        ALUop = 0;
        
        // Test case 1: Write values to register10 and register15
        #10;
        WE3 = 1; A3 = 10; WD3 = 10; #10; // Write 10 to register10
        WE3 = 1; A3 = 15; WD3 = 15; #10; // Write 15 to register15
        
        // Read and ADD operation
        WE3 = 0; A1 = 10; A2 = 15; ALUop = 2'b00; #10;
        WE3 = 1; A3 = 20; WD3 = ALUresult; #10; // Write result to register20
        
        $display("ADD Test: 10 + 15 = %d", ALUresult);
        
        // Test case 2: Write new values to register10 and register15
        WE3 = 1; A3 = 10; WD3 = 20; #10; // Write 20 to register10
        WE3 = 1; A3 = 15; WD3 = 15; #10; // Write 15 to register15
        
        // Read and SUB operation
        WE3 = 0; A1 = 10; A2 = 15; ALUop = 2'b01; #10;
        WE3 = 1; A3 = 20; WD3 = ALUresult; #10; // Write result to register20
        
        $display("SUB Test: 20 - 15 = %d", ALUresult);
        
        // Test case 3: Write new values to register10 and register15
        WE3 = 1; A3 = 10; WD3 = 31; #10; // Write 31 to register10
        WE3 = 1; A3 = 15; WD3 = 2; #10; // Write 2 to register15
        
        // Read and SHIFTL operation
        WE3 = 0; A1 = 10; A2 = 15; ALUop = 2'b10; #10;
        WE3 = 1; A3 = 20; WD3 = ALUresult; #10; // Write result to register20
        
        $display("SHIFTL Test: 31 << 2 = %d", ALUresult);
        
        // SHIFTR operation with same values
        WE3 = 0; A1 = 10; A2 = 15; ALUop = 2'b11; #10;
        WE3 = 1; A3 = 20; WD3 = ALUresult; #10; // Write result to register20
        
        $display("SHIFTR Test: 31 >> 2 = %d", ALUresult);
        
        $finish;
    end
endmodule