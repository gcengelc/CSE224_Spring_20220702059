module top_module(
    input CLK,
    input control,
    input reset,
    output [31:0] Result,
    output [6:0] seg,
    output [7:0] an
);
    // Internal signals
    wire [7:0] PC;
    wire [31:0] instruction;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] imm;
    wire [2:0] ALUop;
    wire is_immediate;
    wire [31:0] RD1, RD2;
    wire [31:0] ALU_result;
    reg [31:0] Result_reg;
    reg WE3;
    
    // Instantiate components
    program_counter pc(
        .CLK(CLK),
        .reset(reset),
        .control(control),
        .PC(PC)
    );
    
    instruction_memory imem(
        .PC(PC),
        .instruction(instruction)
    );
    
    instruction_decoder decoder(
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .imm(imm),
        .ALUop(ALUop),
        .is_immediate(is_immediate)
    );
    
    register_file rf(
        .CLK(CLK),
        .WE3(WE3),
        .A1(rs1),
        .A2(rs2),
        .A3(rd),
        .WD3(ALU_result),
        .RD1(RD1),
        .RD2(RD2)
    );
    
    alu alu_unit(
        .InputA(RD1),
        .InputB(is_immediate ? imm : RD2),
        .ALUop(ALUop),
        .Result(ALU_result)
    );
    
    // 7-segment display controller
    seg7_display display(
        .CLK(CLK),
        .data(Result_reg),
        .seg(seg),
        .an(an)
    );
    
    // Control logic
    always @(*) begin
        // Enable write for all operations except NOOP
        WE3 = (ALUop != 3'b000 && ALUop != 3'b001);
        
        // Display the result from the destination register
        Result_reg = (rd == 5'b0) ? 32'b0 : ALU_result;
    end
    
    assign Result = Result_reg;
endmodule