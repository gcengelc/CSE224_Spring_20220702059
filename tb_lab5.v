`timescale 1ns / 1ps

module tb_lab5();
    reg CLK;
    reg control;
    reg reset;
    wire [31:0] Result;
    
    // Instantiate top module
    top_module uut (
        .CLK(CLK),
        .control(control),
        .reset(reset),
        .Result(Result)
    );
    
    // Clock generation (10ns period)
    always #5 CLK = ~CLK;
    
    initial begin
        // Initialize inputs
        CLK = 0;
        control = 0;
        reset = 1;
        
        // Reset sequence
        #20;
        reset = 0;
        
        // Execute instructions one by one
        #10;
        control = 1; #10; control = 0; // Instruction 1: ADD! reg10, reg0, 10
        $display("Instruction 1: reg10 = %d (Expected: 10)", Result);
        
        #10;
        control = 1; #10; control = 0; // Instruction 2: ADD! reg15, reg0, 15
        $display("Instruction 2: reg15 = %d (Expected: 15)", Result);
        
        #10;
        control = 1; #10; control = 0; // Instruction 3: ADD reg25, reg10, reg15
        $display("Instruction 3: reg25 = %d (Expected: 25)", Result);
        
        #10;
        control = 1; #10; control = 0; // Instruction 4: SUB! reg20, reg25, 5
        $display("Instruction 4: reg20 = %d (Expected: 20)", Result);
        
        #10;
        control = 1; #10; control = 0; // Instruction 5: ADD! reg5, reg0, 2
        $display("Instruction 5: reg5 = %d (Expected: 2)", Result);
        
        #10;
        control = 1; #10; control = 0; // Instruction 6: SHIFTL reg30, reg25, reg5
        $display("Instruction 6: reg30 = %d (Expected: 100)", Result);
        
        #10;
        $finish;
    end
endmodule