module alu(
    input [31:0] InputA,
    input [31:0] InputB,
    input [2:0] ALUop,
    output reg [31:0] Result
);
    always @(*) begin
        case (ALUop)
            3'b000, 3'b001: Result = 32'b0; // NOOP
            3'b010: Result = InputA + InputB; // ADD
            3'b011: Result = InputA - InputB; // SUB
            3'b100: Result = InputA << InputB; // SHIFTL
            3'b101: Result = InputA >> InputB; // SHIFTR
            3'b110: Result = InputA + InputB; // ADDI
            3'b111: Result = InputA - InputB; // SUBI
            default: Result = 32'b0;
        endcase
    end
endmodule