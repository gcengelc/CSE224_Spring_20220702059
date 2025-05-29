module instruction_memory(
    input [7:0] PC,
    output reg [31:0] instruction
);
    // Instruction memory (ROM)
    reg [31:0] mem [0:255];
    
    // Initialize with test instructions
    initial begin
        // ADD! reg10, reg0, 10
        mem[0] = 32'b0001_00010_00000_0000000000001010;
        // ADD! reg15, reg0, 15
        mem[1] = 32'b0001_00111_00000_0000000000001111;
        // ADD reg25, reg10, reg15
        mem[2] = 32'b0010_11001_01010_01111_00000000000;
        // SUB! reg20, reg25, 5
        mem[3] = 32'b0011_10100_11001_0000000000000101;
        // ADD! reg5, reg0, 2
        mem[4] = 32'b0001_00101_00000_0000000000000010;
        // SHIFTL reg30, reg25, reg5
        mem[5] = 32'b0100_11110_11001_00101_00000000000;
    end
    
    always @(*) begin
        instruction = mem[PC];
    end
endmodule