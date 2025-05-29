module top_module(
    input CLK,
    input WE3,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input [1:0] ALUop,
    output [31:0] RD1, RD2,
    output [31:0] ALUresult
);
    // Instantiate register file
    register_file rf (
        .CLK(CLK),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );
    
    // Instantiate ALU
    alu alu_unit (
        .InputA(RD1),
        .InputB(RD2),
        .Sopcode(ALUop),
        .Result(ALUresult)
    );
endmodule