module instruction_decoder(
    input [31:0] instruction,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] imm,
    output reg [2:0] ALUop,
    output reg is_immediate
);
    always @(*) begin
        // Default values
        rs1 = 5'b0;
        rs2 = 5'b0;
        rd = 5'b0;
        imm = 32'b0;
        ALUop = 3'b000; // NOOP
        is_immediate = 1'b0;
        
        // Decode instruction
        case (instruction[31:28])
            4'b0001: begin // ADD!
                rd = instruction[24:20];
                rs1 = instruction[19:15];
                imm = {{20{instruction[15]}}, instruction[15:0]}; // Sign-extend
                ALUop = 3'b010; // ADD
                is_immediate = 1'b1;
            end
            4'b0010: begin // ADD
                rd = instruction[24:20];
                rs1 = instruction[19:15];
                rs2 = instruction[14:10];
                ALUop = 3'b010; // ADD
            end
            4'b0011: begin // SUB!
                rd = instruction[24:20];
                rs1 = instruction[19:15];
                imm = {{20{instruction[15]}}, instruction[15:0]}; // Sign-extend
                ALUop = 3'b011; // SUB
                is_immediate = 1'b1;
            end
            4'b0100: begin // SHIFTL
                rd = instruction[24:20];
                rs1 = instruction[19:15];
                rs2 = instruction[14:10];
                ALUop = 3'b100; // SHIFTL
            end
            // Add more instruction types as needed
            default: ALUop = 3'b000; // NOOP
        endcase
    end
endmodule